# == Schema Information
#
# Table name: cms_pictures
#
#  id                 :integer          not null, primary key
#  approved           :boolean          default(TRUE), not null
#  bits_per_pixel     :integer
#  caption            :text(65535)
#  chroma_subsampling :string(255)
#  compression_mode   :string(255)
#  data1              :string(255)
#  data2              :string(255)
#  description        :text(65535)
#  file_path          :string(255)
#  file_size          :integer
#  format             :string(255)
#  height             :integer
#  imageable_type     :string(255)
#  purpose            :string(255)      default("web"), not null
#  sort               :integer
#  votes              :integer
#  width              :integer
#  created_at         :datetime
#  updated_at         :datetime
#  imageable_id       :integer
#  user_id            :integer
#
# Indexes
#
#  imageable_id               (imageable_id)
#  imageable_type             (imageable_type)
#  index_pictures_on_user_id  (user_id)
#
require 'digest/md5'

class Picture < ActiveRecord::Base
  include Exportable

  self.table_name = 'cms_pictures'

  belongs_to :imageable, polymorphic: true
  belongs_to :user
  has_many :comments, -> { order(:created_at) }, as: :commentable
  #has_many :votes, as: :votable

  validates_presence_of :file_path

  def cache_key
    "picture:#{id}"
  end

  def set_picture_properties(base_path)
    return false if self.file_path.nil? || self.file_path == ''
    result = false

    begin
      self.md5_hash = Digest::MD5.hexdigest(File.read(base_path + self.file_path))
      output = `mediainfo --Inform="Image;%Format%|%Width%|%Height%|%BitDepth%|%ChromaSubsampling%|%Compression_Mode%\n" "#{base_path + self.file_path}"`; result = $?.success?
      self.format, self.width, self.height, self.bits_per_pixel, self.chroma_subsampling, self.compression_mode = output.split('|') if result
      self.file_size = File.new(base_path + self.file_path).size
    rescue => e
      Rails.logger.error e.message
    end

    result
  end

  # PUNDIT
  def self.policy_class
    ApplicationPolicy
  end
end
