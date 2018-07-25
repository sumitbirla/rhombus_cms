# == Schema Information
#
# Table name: cms_pictures
#
#  id                 :integer          not null, primary key
#  imageable_id       :integer
#  imageable_type     :string(255)
#  user_id            :integer
#  sort               :integer
#  votes              :integer
#  file_path          :string(255)
#  width              :integer
#  height             :integer
#  file_size          :integer
#  format             :string(255)
#  bits_per_pixel     :integer
#  chroma_subsampling :string(255)
#  compression_mode   :string(255)
#  caption            :text(65535)
#  description        :text(65535)
#  created_at         :datetime
#  updated_at         :datetime
#  approved           :boolean          default("1"), not null
#  data1              :string(255)
#  data2              :string(255)
#

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
    	output = `mediainfo --Inform="Image;%Format%|%Width%|%Height%|%BitDepth%|%ChromaSubsampling%|%Compression_Mode%\n" "#{base_path + self.file_path}"` ;  result=$?.success?
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
