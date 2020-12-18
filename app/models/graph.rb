# == Schema Information
#
# Table name: graphs
#
#  id              :bigint           not null, primary key
#  active_state    :integer          default("normal"), not null
#  defintion       :string
#  envisage_key    :string
#  field_titles    :string
#  item_number     :integer
#  name            :string
#  short_name      :string
#  value_title     :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  organisation_id :bigint           not null
#
# Indexes
#
#  index_graphs_on_organisation_id  (organisation_id)
#
# Foreign Keys
#
#  fk_rails_...  (organisation_id => organisations.id)
#
class Graph < ApplicationRecord
  belongs_to :organisation

  enum active_state: [:normal, :restricted, :closed]
  after_initialize :set_default_active_state, if: :new_record?

  def to_s
    self.short_name
  end

  private

  def set_default_active_state
    self.active_state ||= :member
  end
end
