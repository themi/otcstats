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
class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  belongs_to :organisation

  enum role: [:member, :maintainer, :archived]
  after_initialize :set_default_role, if: :new_record?

  def self.select_list(organisation_id=nil)
    results = if organisation_id
      where(organisation_id: organisation_id)
    else
      self
    end
    results.order(organisation_id: :asc, full_name: :asc).map { |m| m.full_name }
  end

  def to_s
    self.full_name
  end

  private

  def set_default_role
    self.role ||= :member
  end
end
