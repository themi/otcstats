# == Schema Information
#
# Table name: members
#
#  id                     :bigint           not null, primary key
#  address                :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  envisage_key           :string
#  full_name              :string
#  phone                  :string
#  processing_level       :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("member"), not null
#  training_level         :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  organisation_id        :bigint           not null
#
# Indexes
#
#  index_members_on_email                 (email) UNIQUE
#  index_members_on_organisation_id       (organisation_id)
#  index_members_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (organisation_id => organisations.id)
#
FactoryBot.define do
  factory :member do
    email   { |i| FFaker::Internet.email }
    full_name  { FFaker::Name.name }
    phone { FFaker::PhoneNumberAU.mobile_phone_number }
    address { FFaker::AddressAU.full_address }
    training_level { ["Clear","Solo","OT1","OT2"] }
    processing_level { ["Clear","Solo","OT1","OT2"] }
    password              { "verySecr3t!" }
    password_confirmation { "verySecr3t!" }
    organisation

    trait :maintainer do
      role = :maintainer
    end
  end
end
