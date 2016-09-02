user = User.create! login: 'user', password: 'password', password_confirmation: 'password'
newuser = User.create! login: 'newuser', password: 'password', password_confirmation: 'password'
admin = Admin.create! login: 'admin', password: 'password', password_confirmation: 'password'

Info.create! do |i|
  i.gender = "мужской"
  i.experience = "более 5ти лет"
  i.age = "от 30 до 40 лет"
  i.workplace_number = "второе"
  i.work_position = "руководитель отдела"
  i.company = "ГК Газы"
  i.user_id = user.id
end

### 1 question ###
q_1 = Question.create! opinion_subject: "Я", audience: "management", number: 1,
  criterion: "Инициативность, энтузиазм, проактивность"
LeftStatement.create! do |left|
  left.question_id = q_1.id
  left.title = "Инициатива убивает систему"
  left.text = "Я четко выполняю свои обязанности, согласно должностной инструкции, не больше и не меньше. Я не склонен проявлять инициативу, считая, что на работе она неуместна, и часто наказуема. Я часто чувствую себя усталым на работе."
end
RightStatement.create! do |right|
  right.question_id = q_1.id
  right.title = "Я! Я! Я!"
  right.text = "Я часто проявляю инициативу, выходя за рамки своей должностной инструкции. Я всегда что-то предлагаю, охотно участвую в новых проектах, не могу сидеть без дела. Я готов брать ответственность за реализацию предложений на себя. Я энергичен и заражаю своей энергией других."
end
### 2 question ###
q_2 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 2,
  criterion: "Инициативность, энтузиазм, проактивность"
LeftStatement.create! do |left|
  left.question_id = q_2.id
  left.title = "Инициатива убивает систему"
  left.text = "Большинство моих коллег  четко выполняют свои обязанности, согласно должностной инструкции, не больше и не меньше. Они не  склонны проявлять инициативу, считая, что на работе она неуместна, и часто наказуема. Большинство моих коллег пассивны и малоэнергичны."
end
RightStatement.create! do |right|
  right.question_id = q_2.id
  right.title = "Я! Я! Я!"
  right.text = "Большинство моих коллег часто проявляют инициативу, выходя за рамки своей должностной инструкции. Они всегда что-то предлагают, охотно участвуют в новых проектах, не могут сидеть без дела.
  Они готовы брать ответственность за реализацию предложений на себя. Они энергичны и заражают своей энергией других."
end
### 3 question ###
q_3 = Question.create! opinion_subject: "Я", audience: "management", number: 3,
  criterion: "Нацеленность на повышение эффективности в работе"
LeftStatement.create! do |left|
  left.question_id = q_3.id
  left.title = "Лучшее - враг хорошего"
  left.text = "Я работают так, как меня когда-то научили. Я убежден, что надо ничего менять, если каждый будет делать по-своему, в компании начнется беспорядок."
end
RightStatement.create! do |right|
  right.question_id = q_3.id
  right.title = "Постоянно улучшая"
  right.text = "Я считаю, что моей задачей является постоянное улучшение рабочих процессов. Я  часто вносит изменения в свою работу, чтобы сделать ее проще, удобнее. После выполнения какого-либо задания, я не могу его забыть, пока не продумаю, как можно было бы сделать его лучше."
end
### 4 question ###
q_4 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 4,
  criterion: "Нацеленность на повышение эффективности в работе"
LeftStatement.create! do |left|
  left.question_id = q_4.id
  left.title = "Лучшее - враг хорошего"
  left.text = 'Большинство моих коллег работают так, как их когда-то научили. "Не надо ничего менять, если каждый будет делать по-своему, в компании начнется беспорядок", - считают они.'
end
RightStatement.create! do |right|
  right.question_id = q_4.id
  right.title = "Постоянно улучшая"
  right.text = "Задачей каждого работника, считают мои коллеги,  является постоянное улучшение рабочих процессов. Мои коллеги  часто инициируют изменения в нашу работу, чтобы сделать ее проще, удобнее. После выполнения какого-либо задания, они не забывают его, а думают, как в следующий раз можно было бы сделать лучше."
end
### 5 question ###
q_5 = Question.create! opinion_subject: "Я", audience: "management", number: 5,
  criterion: "Увлеченность работой и профессией"
LeftStatement.create! do |left|
  left.question_id = q_5.id
  left.title = "Ответственные подчиненные"
  left.text = "Я не принимаю самостоятельных решений. Лучше пусть начальник скажет, как нужно делать, а то сделаю еще что-нибудь не так. Если руководителя рядом нет, решение просто не принимается до его появления."
end
RightStatement.create! do |right|
  right.question_id = q_5.id
  right.title = "Самостоятельные"
  right.text = "Я четко понимаю, каких результатов ожидают от моей работы, от работы моего подразделения. Я сам выбираю способы, как этих результатов достичь, самостоятельно принимая решения по многим вопросам, принимая на себя ответственность за принятые решения."
end
### 6 question ###
q_6 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 6,
  criterion: "Увлеченность работой и профессией"
LeftStatement.create! do |left|
  left.question_id = q_6.id
  left.title = "Ответственные подчиненные"
  left.text = "Большинство моих коллег не принимают самостоятельных решений. «Лучше пусть начальник скажет, как нужно делать», - считают они. – «А то сделаю еще что-нибудь не так». Если руководителя рядом нет, решение просто не принимается до его появления."
end
RightStatement.create! do |right|
  right.question_id = q_6.id
  right.title = "Самостоятельные"
  right.text = "Большинство моих коллег четко понимают, каких результатов ожидают от их работы, от работы их подразделения. Они сами выбирают способы, как этих результатов достичь, самостоятельно принимая решения по многим вопросам, принимая на себя ответственность за принятые решения."
end
### 7 question ###
q_7 = Question.create! opinion_subject: "Я", audience: "management", number: 7,
  criterion: "Вовлеченность в команду(потребность в принадлежности)"
LeftStatement.create! do |left|
  left.question_id = q_7.id
  left.title = "Индивидуальный игрок"
  left.text = "Я считаю, что совместная работа приводит к тому, что кто-то работает больше, а кто-то меньше. Кто-то может вообще подвести всех. Я предпочитаю работать в одиночку, и добиваюсь больше, чем работая в команде и пытаясь справедливо распределить работу между ее членами."
end
RightStatement.create! do |right|
  right.question_id = q_7.id
  right.title = "Командный игрок"
  right.text = "Я считаю свой коллектив настоящей командой. Работая вместе можно достичь большего. В коллективе у меня есть коллеги, на которых я могу полностью положиться. И я, в свою очередь, стараюсь не подводить команду."
end
### 8 question ###
q_8 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 8,
  criterion: "Вовлеченность в команду(потребность в принадлежности)"
LeftStatement.create! do |left|
  left.question_id = q_8.id
  left.title = "Индивидуальный игрок"
  left.text = '"Совместная работа, - считают большинство моих коллег, - приводит к тому, что кто-то работает больше, а кто-то меньше. Кто-то может вообще подвести всех". Предпочитая работать в одиночку, такие работники добиваются больше, чем работая в команде и пытаясь справедливо распределить работу между ее членами.'
end
RightStatement.create! do |right|
  right.question_id = q_8.id
  right.title = "Командный игрок"
  right.text = "Большинство моих коллег считают свой коллектив настоящей командой. Они считают, что работая вместе можно достичь большего. В коллективе у них есть коллеги, на которых они могут полностью положиться. И они, в свою очередь, не подводят команду."
end
### 9 question ###
q_9 = Question.create! opinion_subject: "Я", audience: "management", number: 9,
  criterion: "Доверие к руководству"
LeftStatement.create! do |left|
  left.question_id = q_9.id
  left.title = "Трудно застать"
  left.text = "Мой руководитель очень редко бывает на рабочем месте, поэтому его трудно застать, чтобы поговорить или обсудить проблему."
end
RightStatement.create! do |right|
  right.question_id = q_9.id
  right.title = "В любой момент"
  right.text = "Я могу в любой момент прийти к своему руководителю и поделиться проблемой. Мое руководство доступно для общения и готово меня выслушать."
end
### 10 question ###
q_10 = Question.create! opinion_subject: "Я", audience: "management", number: 10,
  criterion: "Доверие к руководству"
LeftStatement.create! do |left|
  left.question_id = q_10.id
  left.title = "Не понимаю"
  left.text = "Я не понимаю, почему мои руководители принимают те или иные решения. Они не думают ни о клиентах, ни о работниках компании. Я думаю, что компания может быстро развалиться с такими руководителями."
end
RightStatement.create! do |right|
  right.question_id = q_10.id
  right.title = "Поддерживаю"
  right.text = "Я понимаю, как мои руководители принимают управленческие решения, с большинством из них я полностью согласен. Руководство заинтересовано в развитии компании и думает о своих работниках. Большинство решений направлено на удовлетворение потребностей клиентов компании (жителей, потребителей)."
end
### 11 question ###
q_11 = Question.create! opinion_subject: "Я", audience: "management", number: 11,
  criterion: "Доверие к руководству"
LeftStatement.create! do |left|
  left.question_id = q_11.id
  left.title = "О деньгах, не о людях"
  left.text = "У меня сложилось стойкое ощущение, что руководство компании уделяет внимание не людям, а прибыли. Я не чувствую, что руководство заботится о нас, что им важно, в каких условиях мы работаем, чем мы живем."
end
RightStatement.create! do |right|
  right.question_id = q_11.id
  right.title = "О людях, а не о деньгах"
  right.text = "Я вижу, что руководству важно знать, в каких условиях люди работают, чем они живут, какие у них проблемы. Руководство заботится о том, чтобы люди чувствовали себя на работе  комфортно."
end
### 12 question ###
q_12 = Question.create! opinion_subject: "Я", audience: "management", number: 12,
  criterion: "Доверие к руководству"
LeftStatement.create! do |left|
  left.question_id = q_12.id
  left.title = "Подчинение, но не уважение"
  left.text = "Я вижу, что руководство неуважительно относится к своим подчиненным: не прислушивается к нашему мнению, не советуется при принятии решений, не выполняет обещания. Мне трудно уважать людей, когда они так себя ведут."
end
RightStatement.create! do |right|
  right.question_id = q_12.id
  right.title = "Взаимное уважение"
  right.text = "Я доверяю своему руководству и уважаю своих руководителей за то, что они выполняют данные обещания и прислушиваются к моему мнению. Я чувствую, что это уважение взаимное."
end
### 13 question ###
q_13 = Question.create! opinion_subject: "Я", audience: "management", number: 13,
  criterion: "Доверие к руководству"
LeftStatement.create! do |left|
  left.question_id = q_13.id
  left.title = "Начальник"
  left.text = 'Мои руководители никак не лидеры, а просто начальники. Они требуют выполнения заданий, даже не объясняя, зачем его делать. Они не умеют "зажечь", вдохновить людей на работу. Просто отдают "приказы".'
end
RightStatement.create! do |right|
  right.question_id = q_13.id
  right.title = "Лидер"
  right.text = "Моих руководителей можно назвать харизматичными лидерами. Они ставят задачу так, что хочется ее выполнить. Они умеют мотивировать людей, поднимать командный дух, сплотить команду."
end
### 14 question ###
q_14 = Question.create! opinion_subject: "Я", audience: "management", number: 14,
  criterion: "Понимание собственных полномочий(потребность в автономии)"
LeftStatement.create! do |left|
  left.question_id = q_14.id
  left.title = "Работа как работа"
  left.text = "Скучная и неинтересная работа приводит к тому, что время течет слишком медленно для меня. Я с охотой поменял бы эту работу на что-то более интересное. Честно сказать, я уже занимаются поиском новой работы."
end
RightStatement.create! do |right|
  right.question_id = q_14.id
  right.title = "Я нахожусь на своем месте"
  right.text = "Я считаю, что у меня есть возможность заниматься на работе тем, что я люблю и лучше всего умею. Я чувствую себя на своем месте. Я считаю свою работу интересной, сложной и важной. Я с радостью иду утром на работу, полон энергии и энтузиазма."
end
### 15 question ###
q_15 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 15,
  criterion: "Понимание собственных полномочий(потребность в автономии)"
LeftStatement.create! do |left|
  left.question_id = q_15.id
  left.title = "Работа как работа"
  left.text = "Скучная и неинтересная работа приводит к тому, что время течет слишком медленно для большинства моих коллег. Они бы с охотой поменяли эту работу на что-то более интересное. Я знаю, что они уже занимаются поиском новой работы."
end
RightStatement.create! do |right|
  right.question_id = q_15.id
  right.title = "Я нахожусь на своем месте"
  right.text = "Большинство моих коллег считают, что у них есть возможность заниматься на работе тем, что они любят и лучше всего умеют. Они чувствуют себя на своем месте. Они считают свою работу интересной, сложной и важной. Они с радостью идут утром на работу, полны энергии и энтузиазма."
end
### 16 question ###
q_16 = Question.create! opinion_subject: "Я", audience: "management", number: 16,
  criterion: "Субъективная клиенториентированность"
LeftStatement.create! do |left|
  left.question_id = q_16.id
  left.title = "Мы не всемогущие!"
  left.text = "Я считаю, что клиенты требуют всегда больше, чем положено. В идеале я бы вообще не хотел работать напрямую с жителями. Меня раздражает вечные жалобы и недовольство."
end
RightStatement.create! do |right|
  right.question_id = q_16.id
  right.title = "Клиент - наше все!"
  right.text = "Я испытываю радость и удовольствие, когда могу решить проблемы своих клиентов. У меня есть и возможности, и полномочия, чтобы помогать жителям. Я четко понимаю, чего хотят наши клиенты, и способна формировать в них лояльное отношение."
end
### 17 question ###
q_17 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 17,
  criterion: "Субъективная клиенториентированность"
LeftStatement.create! do |left|
  left.question_id = q_17.id
  left.title = "Мы не всемогущие!"
  left.text = '"Клиенты требуют слишком многого", - считают мои коллеги. В идеале, они вообще не хотели бы общаться напрямую с жителями. Их раздражают слишком навязчивые клиенты.'
end
RightStatement.create! do |right|
  right.question_id = q_17.id
  right.title = "Клиент - наше все!"
  right.text = "Большинство моих коллег испытывают радость и удовольствие от того, что могут решить проблемы своих клиентов. У таких работников есть все возможности и полномочия, чтобы помогать жителям. Они четко понимают, чего хотят их клиенты, и способны формировать в них лояльное отношение."
end
### 18 question ###
q_18 = Question.create! opinion_subject: "Я", audience: "management", number: 18,
  criterion: "Брэнд работодателя"
LeftStatement.create! do |left|
  left.question_id = q_18.id
  left.title = "Не советую"
  left.text = "Я не рекомендую свои друзьям, ищущим работу,  идти на работу в нашу компанию. В разговорах я иногда стесняются говорить, что работают здесь. Компания в целом имеет не очень хорошую репутацию в городе, и в нее неохотно идут новые сотрудники."
end
RightStatement.create! do |right|
  right.question_id = q_18.id
  right.title = "Рекомендую"
  right.text = "Я считаю, что наша организация является одним из лучших мест работы в городе, поскольку имеет хорошую репутацию. Я с радостью рекомендую свою компанию друзьям, которые ищут работу."
end
### 19 question ###
q_19 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 19,
  criterion: "Брэнд работодателя"
LeftStatement.create! do |left|
  left.question_id = q_19.id
  left.title = "Не советую"
  left.text = "Большинство моих коллег не рекомендуют свои друзьям, ищущим работу, свою компанию. В разговорах они стесняются говорить, что работают здесь. Компания в целом имеет не очень хорошую репутацию в городе, и в неё неохотно идут новые сотрудники."
end
RightStatement.create! do |right|
  right.question_id = q_19.id
  right.title = "Рекомендую"
  right.text = "Мои коллеги считают, что наша организация является одним из лучших мест работы в городе, поскольку имеет хорошую репутацию. Многие из них с радостью рекомендуют свою компанию друзьям, которые ищут работу."
end
### 20 question ###
q_20 = Question.create! opinion_subject: "Я", audience: "management", number: 20,
  criterion: "Удовлетворенность условиями труда"
LeftStatement.create! do |left|
  left.question_id = q_20.id
  left.title = "В условиях дефицита"
  left.text = "Я считаю условия труда в нашей компании неудовлетворительными. Моя зарплата не соответствует вкладу в компанию. Оборудование и материалы, с которыми приходится работать, устарели, но даже  их недостаточно."
end
RightStatement.create! do |right|
  right.question_id = q_20.id
  right.title = "Все есть для работы"
  right.text = "Я доволен и зарплатой, и условиями труда. У меня удобное рабочее место и достаточное обеспечение всем необходимым для работы."
end
### 21 question ###
q_21 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 21,
  criterion: "Удовлетворенность условиями труда"
LeftStatement.create! do |left|
  left.question_id = q_21.id
  left.title = "В условиях дефицита"
  left.text = "Условия труда неудовлетворительны и зарплата не соответствует вкладу в компанию. Оборудование и материалы, с которыми приходится работать, устарели, но даже  их недостаточно. В целом условия труда трудно назвать удовлетворительными."
end
RightStatement.create! do |right|
  right.question_id = q_21.id
  right.title = "Все есть для работы"
  right.text = "Такие работники довольны и зарплатой, и условиями труда. У них удобное рабочее место и достаточное обеспечение всем необходимым для работы."
end
### 22 question ###
q_22 = Question.create! opinion_subject: "Я", audience: "management", number: 22,
  criterion: "Удовлетворенность качеством коммуникаций(информированность)"
LeftStatement.create! do |left|
  left.question_id = q_22.id
  left.title = "Неосведомленный"
  left.text = "Я практически ничего не знаю о событиях, происходящих в компании. Я не знаю, кто и чем занимается. По компании вместо информации ходят слухи и домыслы. В компании очень сложно получить какую-либо информацию от другой службы или подразделения."
end
RightStatement.create! do |right|
  right.question_id = q_22.id
  right.title = "В курсе событий"
  right.text = "Я получаю информацию о делах компании от руководителей, в курсе всех основных событий. Если мне нужна какая-то информация из другого отдела или службы – ее предоставляют быстро и по первому требованию. Службы и отделы в нашей компании работают согласованно и вовремя предоставляют все необходимые данные."
end
### 23 question ###
q_23 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 23,
  criterion: "Удовлетворенность качеством коммуникаций(информированность)"
LeftStatement.create! do |left|
  left.question_id = q_23.id
  left.title = "Неосведомленный"
  left.text = "Большинство моих коллег практически ничего не знают о событиях, происходящих в компании, они не знают, кто и чем занимается. По компании вместо информации ходят слухи и домыслы. В компании очень сложно получить какую-либо информацию от другой службы или подразделения."
end
RightStatement.create! do |right|
  right.question_id = q_23.id
  right.title = "В курсе событий"
  right.text = "Большинство моих коллег получают информацию о делах компании от руководителей, в курсе всех основных событий. Если им нужна какая-то информация из другого отдела или службы – ее предоставляют быстро по первому требованию. Службы и отделы в такой компании работают согласованно и вовремя предоставляют все необходимые данные."
end
### 24 question ###
q_24 = Question.create! opinion_subject: "Я", audience: "management", number: 24,
  criterion: "Удовлетворенность атмосферой в коллективе"
LeftStatement.create! do |left|
  left.question_id = q_24.id
  left.title = "Прохладная обстановка"
  left.text = "Коллектив, в котором я работаю, трудно назвать дружелюбным. Все тайно радуются, если коллега совершит ошибку. Я редко хожу на корпоративные мероприятия, так как считают это пустой тратой времени."
end
RightStatement.create! do |right|
  right.question_id = q_24.id
  right.title = "Почти как дома"
  right.text = "Я могу назвать коллектив, в котором работаю, дружным и сплоченным. В нем всегда можно получить необходимую поддержку и помощь. Я доверяю своим коллегам, мы все  увлечены одним делом. Мы с удовольствием собираемся вместе и в нерабочей атмосфере, обсуждая как рабочие, так и личные дела."
end
### 25 question ###
q_25 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 25,
  criterion: "Удовлетворенность атмосферой в коллективе"
LeftStatement.create! do |left|
  left.question_id = q_25.id
  left.title = "Прохладная обстановка"
  left.text = "Коллектив, в котором мы работаем, большинство моих коллег не могут  назвать дружелюбным. Все тайно радуются, если коллега совершит ошибку. Большинство моих коллег редко ходят на корпоративные мероприятия, так как считают это пустой тратой времени."
end
RightStatement.create! do |right|
  right.question_id = q_25.id
  right.title = "Почти как дома"
  right.text = "Большинство моих коллег могут назвать коллектив, в котором работают, дружным и сплоченным. В нем всегда можно получить необходимую поддержку и помощь. Коллеги доверяют друг другу и увлечены одним делом. Они с удовольствием собираются вместе и в нерабочей атмосфере, обсуждая как рабочие, так и личные дела."
end
### 26 question ###
q_26 = Question.create! opinion_subject: "Я", audience: "management", number: 26,
  criterion: "Удовлетворенность потребности в компетентности"
LeftStatement.create! do |left|
  left.question_id = q_26.id
  left.title = "Непризнанный"
  left.text = "Я считаю себя профессионалом, но в мои  дела постоянно вмешиваются, указывая, как работать. Мне редко доверяют серьезные участки работы, показывая, что не совсем доверяют. Мне неприятно, что меня считают некомпетентным. Если бы мне больше доверяли, я бы мог больше показать в своей работе."
end
RightStatement.create! do |right|
  right.question_id = q_26.id
  right.title = "Мастер своего дела"
  right.text = "Меня уважают руководители и коллеги, считая Профессионалом. Мне поручают сложные задачи, потому что уверены в результате. Я редко допускаю ошибки, способен самостоятельно организовать любой рабочий процесс. Тем не менее, я постоянно чему-то учусь, и могу научить менее опытных коллег."
end
### 27 question ###
q_27 = Question.create! opinion_subject: "Мои коллеги", audience: "management", number: 27,
  criterion: "Удовлетворенность потребности в компетентности"
LeftStatement.create! do |left|
  left.question_id = q_27.id
  left.title = "Непризнанный"
  left.text = "В дела большинства моих коллег постоянно вмешиваются, указывая, как работать. Им редко доверяют серьезные участки работы. Им постоянно показывают, что они ничего не смогут сделать качественно и самостоятельно. Им неприятно, что их считают некомпетентными. Если бы им больше доверяли, они бы большего достигли."
end
RightStatement.create! do |right|
  right.question_id = q_27.id
  right.title = "Мастер своего дела"
  right.text = "Большинство моих коллег уважают руководители и коллеги, считая их профессионалами. Они редко допускают ошибки, способны самостоятельно организовать любой рабочий процесс. Тем не менее, они постоянно чему-то учатся, и у них есть всегда чему поучиться."
end
### 28 question ###
q_28 = Question.create! opinion_subject: "Я", audience: "management", number: 28,
  criterion: "Шкала социальной желательности"
LeftStatement.create! do |left|
  left.question_id = q_28.id
  left.title = ""
  left.text = "У меня бывают в работе взлеты и падения, удачи и неудачи. Мне что-то нравится в работе, что-то не нравится. Я считаю, что хорошие рабочие отношения возникают тогда, когда  люди слышат друг друга и умеют договариваться, а не молчат и копят обиды."
end
RightStatement.create! do |right|
  right.question_id = q_28.id
  right.title = ""
  right.text = "Все свои дела на работе я довожу до конца. Никогда ни с кем не вступаю в конфликт. Никогда не обсуждаю с коллегами неправильные решения руководства. Меня никогда не раздражают люди, которые обращаются ко мне с просьбами."
end
### 29 question ###
q_29 = Question.create! opinion_subject: "Я", audience: "management", number: 29,
  criterion: "Шкала социальной желательности"
LeftStatement.create! do |left|
  left.question_id = q_29.id
  left.title = ""
  left.text = "Мне бывает трудно признавать свои ошибки. Мне неприятно, когда со мной спорят. Я раздражаюсь, когда слышу критику в свой адрес."
end
RightStatement.create! do |right|
  right.question_id = q_29.id
  right.title = ""
  right.text = "Я охотно признаю свои ошибки. У меня не бывает досады, когда высказывают мнение, противоположное моему. Я с радостью воспринимаю любую критику."
end

questions_2_criterion = "Свободные ответы"
### 2_1 question ###
Question.create! opinion_subject: "Я", audience: "management", number: 201,
  sentence: "Я считаю, что основными проблемами в компании являются",
  criterion: questions_2_criterion
### 2_2 question ###
Question.create! opinion_subject: "Я", audience: "management", number: 202,
  sentence: "Если бы я был назначен генеральным директором своей компании, в первую очередь я изменил бы",
  criterion: questions_2_criterion
### 2_3 question ###
Question.create! opinion_subject: "Я", audience: "management", number: 203,
  sentence: "Я чувствовал гордость за свою компанию, когда",
  criterion: questions_2_criterion
### 2_4 question ###
Question.create! opinion_subject: "Я", audience: "management", number: 204,
  sentence: "Чтобы работники компании работали с большей душой и отдачей, руководству компании нужно сделать следующее",
  criterion: questions_2_criterion
### 2_5 question ###
Question.create! opinion_subject: "Я", audience: "management", number: 205,
  sentence: "В целом я посоветовал бы нашему руководству",
  criterion: questions_2_criterion
### 2_6 question ###
Question.create! opinion_subject: "Я", audience: "management", number: 206,
  sentence: "Назовите 2-3 имени Ваших коллег, точку зрения которых Вы уважаете, к мнению которых прислушиваетесь:",
  criterion: questions_2_criterion

### User takes a survey ###
survey = Survey.create! do |s|
  s.user_id = user.id
  s.user_agreement = "я полностью согласен со своим результатом"
  s.user_email = "user@email.com"
  s.completed = true
end

(1..29).each do |n|
  Response.create! do |resp|
    resp.survey_id = survey.id
    resp.question_number = n
    resp.answer = (rand(5) + 1).to_s
  end
end

(1..6).each do |n|
  question_number = "20#{n}".to_i
  Response.create! do |resp|
    resp.survey_id = survey.id
    resp.question_number = question_number
    resp.answer = "Затрудняюсь ответить"
  end
end
