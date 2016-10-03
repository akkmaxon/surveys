class User < ApplicationRecord
  devise :database_authenticatable,
	 :rememberable,
	 :trackable,
	 :validatable

  has_one :info, dependent: :delete
  has_many :surveys, dependent: :destroy

  validates :login, presence: true
  validates :login, length: { maximum: 64 }
  validates :login, uniqueness: { case_sensitive: false }

  default_scope -> { order(updated_at: :desc) }

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def creation_time
    created_at.strftime "%d.%m.%Y"
  end

  def manager?
    info.work_position != "рабочая должность"
  end

  def audience
    manager? ? "Менеджмент" : "Рабочая специальность"
  end

  def create_survey
    surveys.create(audience: audience)
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

  def self.search_for_query(query)
    result = []
    result.concat where("login ilike ?", "%#{query}%")
    u_ids = Info.search_for_query(query).pluck(:user_id)
    result.concat find(u_ids)
    result.uniq
  end

  def to_param
    login
  end
end
