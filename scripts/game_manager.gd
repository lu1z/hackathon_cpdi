extends Control

class_name GameManager

var current_questions: QuestionManager
var current_score: ScoreManager


func print_ESG(idxs, group, score):
	for i in idxs:
		print(
			str(i) +
			" ESG: " +
			Question.indexedNames[i % len(Question.indexedNames)] +
			group +
			str(score[i])
		)


# Called when the node enters the scene tree for the first time.
func _ready():
	var loader = DataLoader.new()
	loader.strategy = loader.CONFIG_FILE
	var questions = loader.load_file()
	for q in questions:
		print(q.id)
		print(q.question)
		print_ESG(Question.yes_enviroment, " --- Yes on Enviroment Score: ", q.esg)
		print_ESG(Question.yes_social, " --- Yes on Social Score: ", q.esg)
		print_ESG(Question.yes_governance, " --- Yes on Governance Score: ", q.esg)

		print_ESG(Question.no_enviroment, " --- No on Enviroment Score: ", q.esg)
		print_ESG(Question.no_social, " --- No on Social Score: ", q.esg)
		print_ESG(Question.no_governance, " --- Yes on Governance Score: ", q.esg)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
