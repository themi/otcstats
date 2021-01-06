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
class Organisation < ApplicationRecord
  has_many :graphs

  validates :name, presence: true

  def self.select_list
    order(continent: :asc, name: :asc).map { |o| o.name }
  end

  def to_s
    "#{self.name} #{self.continent}"
  end
end
