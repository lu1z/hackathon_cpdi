extends Object

class_name QuestionManager

var questions: Array
var current: Question

func load_questions():
	pass

func shuffle_questions():
	questions.shuffle()

func draw_question():
	current = questions.pop_back()

func draw_question_with_bias(bias):
	pass

