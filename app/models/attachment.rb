class Attachment < ApplicationRecord
  self.table_name = "cms_attachments"
  belongs_to :attachable, polymorphic: true
  validates_presence_of :file_path, :content_type
end
