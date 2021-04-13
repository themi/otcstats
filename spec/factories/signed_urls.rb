# == Schema Information
#
# Table name: signed_urls
#
#  id         :bigint           not null, primary key
#  email      :string
#  expires_in :integer
#  short_path :string
#  token      :string
#  used_at    :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stream_id  :string
#
FactoryBot.define do
  factory :signed_url do
    email { "MyString" }
    token { "MyString" }
    stream_id { "MyString" }
    expires_in { 1 }
    short_path { "MyString" }
    used_at { "2021-04-13 16:40:53" }
    generated_at { "2021-04-13 16:40:53" }
  end
end
