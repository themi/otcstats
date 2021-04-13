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
require 'rails_helper'

RSpec.describe SignedUrl, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
