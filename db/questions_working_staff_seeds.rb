### 1 question ###
q_1 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 1,
  criterion: "Инициативность, энтузиазм, проактивность",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_1.id
  left.title = "Инициатива убивает систему"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_1.id
  right.title = "Я! Я! Я!"
  right.text = "Рабочая специальность"
end
### 2 question ###
q_2 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 2,
  criterion: "Инициативность, энтузиазм, проактивность",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_2.id
  left.title = "Инициатива убивает систему"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_2.id
  right.title = "Я! Я! Я!"
  right.text = "Рабочая специальность"
end
### 3 question ###
q_3 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 3,
  criterion: "Нацеленность на повышение эффективности в работе",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_3.id
  left.title = "Лучшее - враг хорошего"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_3.id
  right.title = "Постоянно улучшая"
  right.text = "Рабочая специальность"
end
### 4 question ###
q_4 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 4,
  criterion: "Нацеленность на повышение эффективности в работе",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_4.id
  left.title = "Лучшее - враг хорошего"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_4.id
  right.title = "Постоянно улучшая"
  right.text = "Рабочая специальность"
end
### 5 question ###
q_5 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 5,
  criterion: "Увлеченность работой и профессией",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_5.id
  left.title = "Ответственные подчиненные"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_5.id
  right.title = "Самостоятельные"
  right.text = "Рабочая специальность"
end
### 6 question ###
q_6 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 6,
  criterion: "Увлеченность работой и профессией",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_6.id
  left.title = "Ответственные подчиненные"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_6.id
  right.title = "Самостоятельные"
  right.text = "Рабочая специальность"
end
### 7 question ###
q_7 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 7,
  criterion: "Вовлеченность в команду(потребность в принадлежности)",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_7.id
  left.title = "Индивидуальный игрок"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_7.id
  right.title = "Командный игрок"
  right.text = "Рабочая специальность"
end
### 8 question ###
q_8 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 8,
  criterion: "Вовлеченность в команду(потребность в принадлежности)",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_8.id
  left.title = "Индивидуальный игрок"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_8.id
  right.title = "Командный игрок"
  right.text = "Рабочая специальность"
end
### 9 question ###
q_9 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 9,
  criterion: "Доверие к руководству",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_9.id
  left.title = "Трудно застать"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_9.id
  right.title = "В любой момент"
  right.text = "Рабочая специальность"
end
### 10 question ###
q_10 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 10,
  criterion: "Доверие к руководству",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_10.id
  left.title = "Не понимаю"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_10.id
  right.title = "Поддерживаю"
  right.text = "Рабочая специальность"
end
### 11 question ###
q_11 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 11,
  criterion: "Доверие к руководству",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_11.id
  left.title = "О деньгах, не о людях"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_11.id
  right.title = "О людях, а не о деньгах"
  right.text = "Рабочая специальность"
end
### 12 question ###
q_12 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 12,
  criterion: "Доверие к руководству",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_12.id
  left.title = "Подчинение, но не уважение"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_12.id
  right.title = "Взаимное уважение"
  right.text = "Рабочая специальность"
end
### 13 question ###
q_13 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 13,
  criterion: "Доверие к руководству",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_13.id
  left.title = "Начальник"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_13.id
  right.title = "Лидер"
  right.text = "Рабочая специальность"
end
### 14 question ###
q_14 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 14,
  criterion: "Понимание собственных полномочий(потребность в автономии)",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_14.id
  left.title = "Работа как работа"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_14.id
  right.title = "Я нахожусь на своем месте"
  right.text = "Рабочая специальность"
end
### 15 question ###
q_15 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 15,
  criterion: "Понимание собственных полномочий(потребность в автономии)",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_15.id
  left.title = "Работа как работа"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_15.id
  right.title = "Я нахожусь на своем месте"
  right.text = "Рабочая специальность"
end
### 16 question ###
q_16 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 16,
  criterion: "Субъективная клиенториентированность",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_16.id
  left.title = "Мы не всемогущие!"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_16.id
  right.title = "Клиент - наше все!"
  right.text = "Рабочая специальность"
end
### 17 question ###
q_17 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 17,
  criterion: "Субъективная клиенториентированность",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_17.id
  left.title = "Мы не всемогущие!"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_17.id
  right.title = "Клиент - наше все!"
  right.text = "Рабочая специальность"
end
### 18 question ###
q_18 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 18,
  criterion: "Брэнд работодателя",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_18.id
  left.title = "Не советую"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_18.id
  right.title = "Рекомендую"
  right.text = "Рабочая специальность"
end
### 19 question ###
q_19 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 19,
  criterion: "Брэнд работодателя",
  criterion_type: "Вовлеченность"
LeftStatement.create! do |left|
  left.question_id = q_19.id
  left.title = "Не советую"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_19.id
  right.title = "Рекомендую"
  right.text = "Рабочая специальность"
end
### 20 question ###
q_20 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 20,
  criterion: "Удовлетворенность условиями труда",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_20.id
  left.title = "В условиях дефицита"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_20.id
  right.title = "Все есть для работы"
  right.text = "Рабочая специальность"
end
### 21 question ###
q_21 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 21,
  criterion: "Удовлетворенность условиями труда",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_21.id
  left.title = "В условиях дефицита"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_21.id
  right.title = "Все есть для работы"
  right.text = "Рабочая специальность"
end
### 22 question ###
q_22 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 22,
  criterion: "Удовлетворенность качеством коммуникаций(информированность)",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_22.id
  left.title = "Неосведомленный"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_22.id
  right.title = "В курсе событий"
  right.text = "Рабочая специальность"
end
### 23 question ###
q_23 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 23,
  criterion: "Удовлетворенность качеством коммуникаций(информированность)",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_23.id
  left.title = "Неосведомленный"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_23.id
  right.title = "В курсе событий"
  right.text = "Рабочая специальность"
end
### 24 question ###
q_24 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 24,
  criterion: "Удовлетворенность атмосферой в коллективе",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_24.id
  left.title = "Прохладная обстановка"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_24.id
  right.title = "Почти как дома"
  right.text = "Рабочая специальность"
end
### 25 question ###
q_25 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 25,
  criterion: "Удовлетворенность атмосферой в коллективе",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_25.id
  left.title = "Прохладная обстановка"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_25.id
  right.title = "Почти как дома"
  right.text = "Рабочая специальность"
end
### 26 question ###
q_26 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 26,
  criterion: "Удовлетворенность потребности в компетентности",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_26.id
  left.title = "Непризнанный"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_26.id
  right.title = "Мастер своего дела"
  right.text = "Рабочая специальность"
end
### 27 question ###
q_27 = Question.create! opinion_subject: "Мои коллеги", audience: "Рабочая специальность", number: 27,
  criterion: "Удовлетворенность потребности в компетентности",
  criterion_type: "Удовлетворенность"
LeftStatement.create! do |left|
  left.question_id = q_27.id
  left.title = "Непризнанный"
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_27.id
  right.title = "Мастер своего дела"
  right.text = "Рабочая специальность"
end
### 28 question ###
q_28 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 28,
  criterion: "Шкала социальной желательности"
LeftStatement.create! do |left|
  left.question_id = q_28.id
  left.title = ""
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_28.id
  right.title = ""
  right.text = "Рабочая специальность"
end
### 29 question ###
q_29 = Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 29,
  criterion: "Шкала социальной желательности"
LeftStatement.create! do |left|
  left.question_id = q_29.id
  left.title = ""
  left.text = "Рабочая специальность"
end
RightStatement.create! do |right|
  right.question_id = q_29.id
  right.title = ""
  right.text = "Рабочая специальность"
end

questions_2_criterion = "Свободные ответы"
### 2_1 question ###
Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 201,
  sentence: "Рабочая специальность",
  criterion: questions_2_criterion
### 2_2 question ###
Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 202,
  sentence: "Рабочая специальность",
  criterion: questions_2_criterion
### 2_3 question ###
Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 203,
  sentence: "Рабочая специальность",
  criterion: questions_2_criterion
### 2_4 question ###
Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 204,
  sentence: "Рабочая специальность",
  criterion: questions_2_criterion
### 2_5 question ###
Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 205,
  sentence: "Рабочая специальность",
  criterion: questions_2_criterion
### 2_6 question ###
Question.create! opinion_subject: "Я", audience: "Рабочая специальность", number: 206,
  sentence: "Рабочая специальность",
  criterion: questions_2_criterion
