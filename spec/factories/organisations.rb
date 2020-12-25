# == Schema Information
#
# Table name: organisations
#
#  id           :bigint           not null, primary key
#  continent    :string
#  envisage_key :string
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :organisation do
    continent { FFaker::Lorem.word }
    name { FFaker::Lorem.words }
  end
end
