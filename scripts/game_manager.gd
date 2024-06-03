extends Control

class_name GameManager

var question_manager: QuestionManager
var score_manager: ScoreManager

# Called when the node enters the scene tree for the first time.
func _ready():
	question_manager = QuestionManager.new()
	question_manager.load_questions()
	question_manager.shuffle_questions()

	score_manager = ScoreManager.new()
	score_manager.score_initialize()

	score_manager.print_score()
	for turn in 5:
		question_manager.draw_question()
		print(question_manager.current.id)
		score_manager.apply_cost(question_manager.current.cost)
		score_manager.apply_revenue()
		score_manager.print_score()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
