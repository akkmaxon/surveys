class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
   #:registerable,
   #:recoverable,
    :rememberable,
    :trackable,
    :validatable
  has_one :info, dependent: :destroy
  has_many :surveys, dependent: :destroy

  validates :login, presence: true
  validates :login, length: { maximum: 64 }
  validates :login, uniqueness: { case_sensitive: false }

  def email_required?
    false
  end
end
