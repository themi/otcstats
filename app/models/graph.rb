# == Schema Information
#
# Table name: graphs
#
#  id              :bigint           not null, primary key
#  active_state    :integer          default("normal"), not null
#  definition      :string
#  envisage_key    :string
#  envisage_name   :string
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

  enum active_state: [:normal, :restricted, :archived]
  after_initialize :set_default_active_state, if: :new_record?

  validates :name, :value_title, presence: true

  scope :graphs_for, ->(organisation_id) { where(organisation_id: organisation_id) }
  scope :active_graphs, -> { where.not(active_state: :archived) }
  scope :active_graphs_for, ->(organisation_id) { graphs_for(organisation_id).active_graphs.order(organisation_id: :asc, item_number: :asc) }

  def to_s
    self.short_name
  end

  def field_titles_array
    @field_titles_array ||= (self.field_titles || "").split("|")
  end

  private

  def set_default_active_state
    self.active_state ||= :normal
  end
end
