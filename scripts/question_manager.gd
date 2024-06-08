class_name QuestionManager extends Object


var questions: Array
var current: Question


func _init():
	load_questions()
	shuffle_questions()


func load_questions():
	var loader = DataLoader.new()
	loader.strategy = loader.CSV_FILE
	questions = loader.load_file()


func shuffle_questions():
	questions.shuffle()


func draw_question():
	current = questions.pop_back()


func draw_question_with_bias(bias: ESG.ESG_GROUPS, magnitude: int):
	var elegibles = questions.filter(
		func(q): return q.esg.is_group_sum_larger_than(bias, magnitude)
	)
	current = elegibles.pick_random()
	questions.erase(current)
