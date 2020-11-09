# == Schema Information
#
# Table name: cms_votes
#
#  id           :integer          not null, primary key
#  votable_id   :integer          not null
#  votable_type :string(255)      not null
#  user_id      :integer
#  ip_address   :string(255)      not null
#  cookie       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

class Vote < ActiveRecord::Base
  include Exportable

  self.table_name = 'cms_votes'
  belongs_to :votable, polymorphic: true
  belongs_to :user
end
