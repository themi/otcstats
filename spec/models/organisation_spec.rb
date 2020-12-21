# == Schema Information
#
# Table name: organisations
#
#  id           :bigint           not null, primary key
#  envisage_key :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe Organisation, type: :model do
  let(:org) { create(:organisation) }

  it "to_s returns name" do
    expect(org.to_s).to eq org.name
  end
end
