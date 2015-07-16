# == Schema Information
#
# Table name: cms_content_blocks
#
#  id         :integer          not null, primary key
#  domain_id  :integer          not null
#  key        :string(255)      not null
#  content    :text(65535)      not null
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
    "content-block:#{domain_id}:#{key}"
  end
end
