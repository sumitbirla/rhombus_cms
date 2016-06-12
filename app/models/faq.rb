# == Schema Information
#
# Table name: cms_faqs
#
#  id          :integer          not null, primary key
#  domain_id   :integer
#  sort        :integer          not null
#  question    :string(255)      not null
#  answer      :text(65535)      not null
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Faq < ActiveRecord::Base
  include Exportable
  self.table_name = "cms_faqs"
  belongs_to :category
  belongs_to :domain
  validates_presence_of :sort, :question, :answer
  
  def cache_key
    "faq:#{domain_id}"
  end
end
