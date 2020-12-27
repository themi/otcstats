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
require 'rails_helper'

RSpec.describe Graph, type: :model do
  let(:graph) { create(:graph) }

  it "active_state defaults to normal" do
    expect(graph.active_state).to eq "normal"
  end

  it "to_s returns short name" do
    expect(graph.to_s).to eq graph.short_name
  end

  # context "#get_field_title_for" do
  #   subject(:action) { graph.get_field_title_for(1) }
  #   it "returns the correct FieldTitle" do
  #     expect(action).to eq "COL2"
  #   end
  # end
end
