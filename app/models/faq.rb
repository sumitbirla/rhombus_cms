class Faq < ActiveRecord::Base
  self.table_name = "cms_faqs"
  belongs_to :category
  belongs_to :domain
  validates_presence_of :sort, :question, :answer
  
  def cache_key
    "faq:#{domain_id}"
  end
end
