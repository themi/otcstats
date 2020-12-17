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
  pending "add some examples to (or delete) #{__FILE__}"
end
