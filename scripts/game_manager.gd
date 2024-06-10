class_name GameManager extends Control


signal turn_advanced


static var myself = new()
static var question_manager: QuestionManager
static var score_manager: ScoreManager
static var turn: int

@onready var lpergunta = $paginaPergunta/PPergunta/Lpergunta
@onready var anima_pagina_pergunta = $paginaPergunta/animaPaginaPergunta


# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func initialize_game():
	turn = 0
	question_manager = QuestionManager.new()
	score_manager = ScoreManager.new()
	$paginaPrincipal/botaoAvancaTurno.pressed.connect(
		_on_botao_avanca_turno_pressed, CONNECT_ONE_SHOT
	)
# Debug purposes
	print("--------------------preturn----------------------")
	score_manager.print_score()
	print("-----------------preturn-ended-------------------")


func pre_turn():
	turn += 1
	myself.turn_advanced.emit()
	score_manager.apply_revenue()
	print("------------------turn: " + str(turn) + " ------------------")


func present_question():
	var bad_luck_protection = score_manager.check_bias_necessity()
	if bad_luck_protection < 0:
		return question_manager.draw_question()
	question_manager.draw_question_with_bias(
		bad_luck_protection,
		score_manager.DEFAULT_BIAS_MAGNITUDE
	)
#debug purposes
	match bad_luck_protection:
		0:
			print("-------Triggered Enviroment bias---------")
			print("Enviroment yes sum: " + str(question_manager.current.esg.self_group_sum(ESG.yes_enviroment) ) )
			print("Enviroment no  sum: " + str(question_manager.current.esg.self_group_sum(ESG.no_enviroment) ) )
			print("-------TURN PARITY: " + str(turn % 2))
		1:
			print("-------Triggered Social bias---------")
			print("Social yes sum: " + str(question_manager.current.esg.self_group_sum(ESG.yes_social) ) )
			print("Social no  sum: " + str(question_manager.current.esg.self_group_sum(ESG.no_social) ) )
			print("-------TURN PARITY: " + str(turn % 2))
		2:
			print("-------Triggered Governance bias---------")
			print("Governance yes sum: " + str(question_manager.current.esg.self_group_sum(ESG.yes_governance) ) )
			print("Governance no  sum: " + str(question_manager.current.esg.self_group_sum(ESG.no_governance) ) )
			print("-------TURN PARITY: " + str(turn % 2))


func post_turn():
#Debug
	#change this to native signal value_changed(value)
	#$TextureRect/botaoE/progressBarE.value = score_manager.get_current_enviroment_score()
	print("------------------endturn: " + str(turn) + " ------------------")
	if score_manager.check_win_condition():
		print("---------------------Won-------------------")
	if score_manager.check_lose_condition():
		print("---------------------Lost-------------------")


func rollback_question():
	var old = question_manager.current
	present_question()
	question_manager.questions.append(old)
	question_manager.shuffle_questions()


func _on_botao_pergunta_skip_pressed():
	rollback_question()

# connect to yes button
func _on_botao_pergunta_nao_pressed():
	score_manager.apply_scores(question_manager.current.esg.esg, ESG.no_group)
	post_turn()


# connect to yes button
func _on_botao_pergunta_sim_pressed():
	score_manager.apply_cost(question_manager.current.cost)
	score_manager.apply_scores(question_manager.current.esg.esg, ESG.yes_group)
	question_manager.current.action.execute()
	post_turn()


func _on_botao_avanca_turno_pressed():
	print("Next turn pressed")
	pre_turn()
	present_question()
	# Debug purposes
	print("Chosen question: " + question_manager.current.id)
	lpergunta.text = str(question_manager.current.question)
	anima_pagina_pergunta.play("Abrepergunta")
	print(anima_pagina_pergunta.get_animation(name))



func _on_botao_aceita_pressed():
	anima_pagina_pergunta.play("FechaPergunta")
	score_manager.apply_cost(question_manager.current.cost)
	score_manager.apply_scores(question_manager.current.esg.esg, ESG.yes_group)
	question_manager.current.action.execute()
	post_turn()
	$paginaPrincipal/botaoE/progressBarE.value = score_manager.get_current_group_score(ESG.ESG_GROUPS.ENVIROMENT)
	$paginaPrincipal/botaoS/progressBarS.value = score_manager.get_current_group_score(ESG.ESG_GROUPS.SOCIAL)
	$paginaPrincipal/botaoG/progressBarG.value = score_manager.get_current_group_score(ESG.ESG_GROUPS.GOVERNANCE)


func _on_botao_declina_pressed():
	anima_pagina_pergunta.play("FechaPergunta")
	score_manager.apply_scores(question_manager.current.esg.esg, ESG.no_group)
	score_manager.apply_cost(question_manager.current.cost)
	post_turn()
	$paginaPrincipal/botaoE/progressBarE.value = score_manager.get_current_group_score(ESG.ESG_GROUPS.ENVIROMENT)
	$paginaPrincipal/botaoS/progressBarS.value = score_manager.get_current_group_score(ESG.ESG_GROUPS.SOCIAL)
	$paginaPrincipal/botaoG/progressBarG.value = score_manager.get_current_group_score(ESG.ESG_GROUPS.GOVERNANCE)

