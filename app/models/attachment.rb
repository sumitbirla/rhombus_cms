require "digest/md5"

class Attachment < ApplicationRecord
  self.table_name = "cms_attachments"
  before_save :set_md5
  
  belongs_to :attachable, polymorphic: true
  validates_presence_of :file_path, :content_type
  
  def set_md5
    unless file_path.start_with?("http:")
      dir = Setting.get(Rails.configuration.domain_id, :system, "Static Files Path")
      self.md5 = Digest::MD5.hexdigest(File.read(dir + file_path))
    end
  end
end
