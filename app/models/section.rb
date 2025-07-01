class Section < ApplicationRecord
  belongs_to :user
  enum section_type: [:default, :evaluation, :chapter]

  scope :grab_all_evaluations, -> { where(section_type: 1) }
  scope :grab_all_chapters, -> { where(section_type: 2) }
end
