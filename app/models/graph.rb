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

  def get_field_title_for(index)
    if field_titles_array.any? &&
        field_titles_array.length >= (index + 1)

      field_titles_array[index]
    end
  end

  def field_titles_array
    @field_titles_array ||= (self.field_titles || "").split("|")
  end

  private

  def set_default_active_state
    self.active_state ||= :normal
  end
end
