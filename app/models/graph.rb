# == Schema Information
#
# Table name: graphs
#
#  id              :bigint           not null, primary key
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
end
