class EvaluationsController < ApplicationController
  before_action :set_evaluation, only: %i[ show edit update destroy ]

  # GET /evaluations or /evaluations.json
  def index
    @evaluations = Section.all.where(section_type: 1)
  end

  # GET /evaluations/1 or /evaluations/1.json
  def show
  end

  # GET /evaluations/new
  def new
    @evaluation = Section.new
  end

  # GET /evaluations/1/edit
  def edit
  end

  # POST /evaluations or /evaluations.json
  def create
    @evaluation = current_user.sections.build(evaluation_params)
    @evaluation.section_type = 1

    respond_to do |format|
      if @evaluation.save
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace('evaluations_all', 
                                                     partial: 'evaluations/evaluations',
                                                    locals: {evaluations: Section.all.where(section_type: 1)}) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /evaluations/1 or /evaluations/1.json
  def update
    respond_to do |format|
      if @evaluation.update(evaluation_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("section_#{@evaluation.id}",
                                                  partial: 'evaluations/evaluation',
                                                  locals: { evaluation: @evaluation }) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluations/1 or /evaluations/1.json
  def destroy
    @evaluation.destroy

    respond_to do |format|
      format.html { redirect_to evaluations_url, notice: "Evaluation was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evaluation
      @evaluation = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def evaluation_params
      params.require(:section).permit(:name, :description, :body)
    end
end
