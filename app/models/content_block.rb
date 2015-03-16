# == Schema Information
#
# Table name: content_blocks
#
#  id         :integer          not null, primary key
#  key        :string(255)      not null
#  content    :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class ContentBlock < ActiveRecord::Base
  self.table_name = 'cms_content_blocks'
  
  validates_presence_of :key
  validates_uniqueness_of :key, scope: :domain_id
  
  def to_s
    content
  end
  
  def cache_key
    "content-block:#{key}"
  end
end
