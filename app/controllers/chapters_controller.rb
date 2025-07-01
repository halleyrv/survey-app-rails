class ChaptersController < ApplicationController
  before_action :set_chapter, only: %i[ show edit update destroy ]

  # GET /chapters or /chapters.json
  def index
    @chapters = Section.grab_all_chapters
  end

  # GET /chapters/1 or /chapters/1.json
  def show
  end

  # GET /chapters/new
  def new
    @chapter = Section.new
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters or /chapters.json
  def create
    @chapter = current_user.sections.build(chapter_params)
    @chapter.section_type = 2

    respond_to do |format|
      if @chapter.save
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace('chapters_all', 
                                                     partial: 'chapters/chapters',
                                                    locals: {chapters: Section.grab_all_chapters}) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1 or /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.turbo_stream { render turbo_stream: turbo_stream.replace("section_#{@chapter.id}",
                                                                        partial: 'chapters/card_chapter',
                                                                        locals: { chapter: @chapter }) }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1 or /chapters/1.json
  def destroy
    @chapter.destroy

    respond_to do |format|
      format.html { redirect_to chapters_url, notice: "Chapter was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def chapter_params
      params.require(:section).permit(:name, :description,  :body)
    end
end
