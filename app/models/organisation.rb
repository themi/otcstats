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
class Organisation < ApplicationRecord
  def to_s
    self.name
  end
end
