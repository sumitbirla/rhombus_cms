# == Schema Information
#
# Table name: cms_faqs
#
#  id          :integer          not null, primary key
#  answer      :text(65535)      not null
#  question    :string(255)      not null
#  sort        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  domain_id   :integer
#
# Indexes
#
#  index_cms_faqs_on_category_id  (category_id)
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

  # PUNDIT
  def self.policy_class
    ApplicationPolicy
  end
end
