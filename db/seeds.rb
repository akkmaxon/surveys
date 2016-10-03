require_relative 'questions_management_seeds'
require_relative 'questions_working_staff_seeds'

### Companies ###
Company.create! name: "ГК Управдом"
Company.create! name: "ГК ДУК"
Company.create! name: "ГК Дзержинские лифты"
Company.create! name: "ГК Газы"
Company.create! name: "Рекламные технологии"
Company.create! name: "Таможенный пост"
Company.create! name: "Управление недвижимостью"
Company.create! name: "Городской парк"

### Users ###
newuser = User.create! login: 'newuser',
  password: 'password'
admin = Admin.create! login: 'admin',
  email: 'admin@email.com',
  password: 'password'
coordinator = Coordinator.create! login: 'coordinator',
  password: 'password'
genders = %w[ мужской женский ]
ages = ["менее 25 лет", "от 25 до 30 лет", "от 30 до 40 лет", "от 40 до 55 лет", "более 55 лет"]
experiences = ["менее 1 года", "от 1 года до 3 лет", "от 3 лет до 5 лет", "более 5 лет"]
workplace_numbers = ["первое", "второе", "третье", "больше третьего"]
work_positions = ["рабочая должность", "производственный руководитель", "работник офиса", "руководитель отдела", "топ-менеджер"]
user_agreements = ["я не согласен со своим результатом",
		   "я частично согласен со своим результатом",
		   "я полностью согласен со своим результатом"]

2999.times do |counter|
  login = User.find_by(login: 'user').nil? ? 'user' : (counter + 1000000).to_s(36)
  user = User.create! login: login,
    password: 'password'

  Info.create! do |i|
    i.gender = genders[rand(2)]
    i.experience = experiences[rand(4)]
    i.age = ages[rand(5)]
    i.workplace_number = workplace_numbers[rand(4)]
    i.work_position = work_positions[rand(5)]
    i.company = Company.find(rand(8) + 1).name
    i.user_id = user.id
  end

  rand(5).times do
    ### User takes a survey ###
    survey = Survey.create! do |s|
      s.user_id = user.id
      s.user_agreement = user_agreements[rand(3)]
      s.user_email = "#{login}@email.com"
      s.completed = true
      s.audience = user.audience
    end

    Question.first_questions_for(survey).each do |question|
      Response.create! do |resp|
	resp.survey_id = survey.id
	resp.question_number = question.number
	resp.answer = (rand(5) + 1).to_s
	resp.criterion = question.criterion
	resp.criterion_type = question.criterion_type
      end
    end

    Question.second_questions_for(survey).each do |question|
      Response.create! do |resp|
	resp.survey_id = survey.id
	resp.question_number = question.number
	resp.answer = Faker::Lorem.sentence
	resp.sentence = question.sentence
      end
    end
  end
end
