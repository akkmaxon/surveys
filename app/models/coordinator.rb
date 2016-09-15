class Coordinator < ApplicationRecord
  devise :database_authenticatable,
         :rememberable,
	 :trackable,
	 :validatable

  validates :login, presence: true
  validates :login, length: { maximum: 64 }
  def email_required?
    false
  end

  def email_changed?
    false
  end
end
