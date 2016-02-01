class Attachment < ActiveRecord::Base
  belongs_to :task

  has_attached_file :file
  do_not_validate_attachment_file_type :file

  validates :task, presence: true
  validates :file, attachment_presence: true
end
