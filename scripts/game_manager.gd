extends Control

class_name GameManager

var question_manager: QuestionManager
var score_manager: ScoreManager
var turn: int

# Called when the node enters the scene tree for the first time.
func _ready():
	turn = 1
	question_manager = QuestionManager.new()
	question_manager.load_questions()
	question_manager.shuffle_questions()

	score_manager = ScoreManager.new()
	score_manager.score_initialize()

	print("-----------------preturn-------------------")
	score_manager.print_score()
	print("-------------------end-------------------")
	for iturn in 10:
		print("------------------turn: " + str(turn) + " ------------------")
		if score_manager.get_current_enviroment_score() < 0:
			print("triggered enviroment bias")
			question_manager.draw_question_with_bias(Question.ESG_GROUPS.ENVIROMENT, 5)
			print(str(question_manager.current.group_sum(Question.yes_enviroment)))
			print(str(question_manager.current.group_sum(Question.no_enviroment)))
		else:
			question_manager.draw_question()
		print(question_manager.current.id)
		score_manager.apply_cost(question_manager.current.cost)
		score_manager.apply_revenue()
		if turn % 2 == 0:
			score_manager.apply_scores(question_manager.current.esg, Question.yes_group)
		else:
			score_manager.apply_scores(question_manager.current.esg, Question.no_group)
		score_manager.print_score()
		$TextureRect/botaoE/progressBarE.value = score_manager.get_current_enviroment_score()
		print("------------------endturn: " + str(turn) + " ------------------")
		
		if score_manager.check_win_condition():
			print("---------------------Won-------------------")
			break
		await $TextureRect/botaoAvancaTurno.pressed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_botao_avanca_turno_pressed():
	print("Next turn pressed")
	turn += 1
	$TextureRect/Camera2D.set_position(Vector2(1098,529))
