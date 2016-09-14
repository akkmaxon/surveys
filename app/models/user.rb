class User < ApplicationRecord
  devise :database_authenticatable,
    :registerable,
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

  def manager?
    info.work_position != "рабочая должность"
  end

  def current_survey_number
    surveys.blank? ? 1 : (count_completed_surveys + 1)
  end

  def completed_surveys
    surveys.where('completed = ?', true)
  end

  def count_completed_surveys
    completed_surveys.count
  end

  def update_decrypted_password(passwd)
    update(decrypted_password: password) unless passwd.blank?
  end
end
