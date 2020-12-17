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
FactoryBot.define do
  factory :organisation do
    name { "MyString" }
    envisage_key { "MyString" }
  end
end
