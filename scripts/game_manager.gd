extends Control

class_name GameManager

static var myself = new()
static var question_manager: QuestionManager
static var score_manager: ScoreManager
static var turn: int

signal turn_advanced

# Called when the node enters the scene tree for the first time.
func _ready():
	initialize_game()
	print("-----------------preturn-------------------")
	score_manager.print_score()
	print("-------------------end-------------------")
	#Action.change_revenue(100000, 3)
	#var qqqq = question_manager.questions.filter(func(q): return q.id == "q1")[0]
	#qqqq.action.execute()
	#qqqq.action.execute()
	#var m_callable = Callable(Action, "change_revenue")
	#m_callable.call("100000", "3")
	turn_pipeline()
	for iturn in 10:
		print(question_manager.current.id)
		score_manager.apply_revenue()
		if turn % 2 == 0:
			question_manager.current.action.execute()
			score_manager.apply_cost(question_manager.current.cost)
			score_manager.apply_scores(question_manager.current.esg, Question.yes_group)
		else:
			score_manager.apply_scores(question_manager.current.esg, Question.no_group)
		score_manager.print_score()
		$TextureRect/botaoE/progressBarE.value = score_manager.get_current_enviroment_score()
		print("------------------endturn: " + str(turn) + " ------------------")
		
		await $TextureRect/botaoAvancaTurno.pressed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func initialize_game():
	turn = 0

	question_manager = QuestionManager.new()
	question_manager.load_questions()
	question_manager.shuffle_questions()

	score_manager = ScoreManager.new()
	score_manager.score_initialize()

func turn_pipeline():
	pre_turn()
	turn_processing()
	post_turn()

func pre_turn():
	turn += 1
	myself.turn_advanced.emit()
	print("------------------turn: " + str(turn) + " ------------------")

func turn_processing():
	var bad_luck_protection = score_manager.check_bias_necessity()
	if bad_luck_protection < 0:
		return question_manager.draw_question()
	question_manager.draw_question_with_bias(
		bad_luck_protection,
		score_manager.DEFAULT_BIAS_MAGNITUDE
	)
	match bad_luck_protection: #debug purposes
		0:
			print("-------Triggered Enviroment bias---------")
			print("Enviroment yes sum: " + str(question_manager.current.group_sum(Question.yes_enviroment) ) )
			print("Enviroment no  sum: " + str(question_manager.current.group_sum(Question.no_enviroment) ) )
			print("-------TURN: " + str(turn % 2))
		1:
			print("-------Triggered Social bias---------")
			print("Social yes sum: " + str(question_manager.current.group_sum(Question.yes_social) ) )
			print("Social no  sum: " + str(question_manager.current.group_sum(Question.no_social) ) )
			print("-------TURN: " + str(turn % 2))
		2:
			print("-------Triggered Governance bias---------")
			print("Governance yes sum: " + str(question_manager.current.group_sum(Question.yes_governance) ) )
			print("Governance no  sum: " + str(question_manager.current.group_sum(Question.no_governance) ) )
			print("-------TURN: " + str(turn % 2))

func post_turn():
	if score_manager.check_win_condition():
		print("---------------------Won-------------------")
	if score_manager.check_lose_condition():
		print("---------------------Lost-------------------")

func _on_botao_avanca_turno_pressed():
	print("Next turn pressed")
	turn_pipeline()
