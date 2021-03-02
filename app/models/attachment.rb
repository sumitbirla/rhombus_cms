# == Schema Information
#
# Table name: cms_attachments
#
#  id              :bigint           not null, primary key
#  attachable_type :string(255)
#  content_type    :string(255)      not null
#  file_name       :string(255)
#  file_path       :string(255)      not null
#  file_size       :integer
#  md5             :string(255)
#  metadata        :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  attachable_id   :bigint
#
# Indexes
#
#  index_cms_attachments_on_attachable_type_and_attachable_id  (attachable_type,attachable_id)
#
require "digest/md5"

class Attachment < ApplicationRecord
  self.table_name = "cms_attachments"
  before_save :set_md5

  belongs_to :attachable, polymorphic: true
  validates_presence_of :file_path, :content_type

  def set_md5
    unless file_path.start_with?("http:")
      dir = Setting.get(Rails.configuration.domain_id, :system, "Static Files Path")
      begin
        self.md5 = Digest::MD5.hexdigest(File.read(dir + file_path))
      rescue => e
        Rails.logger.error e.message
      end
    end
  end
end
