extends Object

class_name QuestionManager

var questions: Array
var current: Question

func load_questions():
	var loader = DataLoader.new()
	loader.strategy = loader.CSV_FILE
	questions = loader.load_file()

func shuffle_questions():
	questions.shuffle()

func draw_question():
	current = questions.pop_back()

func is_group_sum_grater_than(q: Question, yes_section: Array, no_section, magnitude: int):
	return q.group_sum(yes_section) > magnitude or q.group_sum(no_section) > magnitude

func find_elegibles_pick_one(yes_section: Array, no_section, magnitude: int):
	var positives = questions.filter(
		func(q): return is_group_sum_grater_than(
			q,
			yes_section,
			no_section,
			magnitude
		)
	)
	current = positives.pick_random()
	questions.erase(current)

func draw_question_with_bias(bias: Question.ESG_GROUPS, magnitude: int):
	match bias:
		Question.ESG_GROUPS.ENVIROMENT:
			return find_elegibles_pick_one(Question.yes_enviroment, Question.no_enviroment, magnitude)
		Question.ESG_GROUPS.SOCIAL:
			return find_elegibles_pick_one(Question.yes_social, Question.no_social, magnitude)
		Question.ESG_GROUPS.GOVERNANCE:
			return find_elegibles_pick_one(Question.yes_governance, Question.no_governance, magnitude)

func print_ESG(idxs, group, score):
	for i in idxs:
		print(
			str(i) +
			" ESG: " +
			Question.indexedNames[i % len(Question.indexedNames)] +
			group +
			str(score[i])
		)

func print_ESGs():
	print_ESG(Question.yes_enviroment, " --- Yes on Enviroment Score: ", current.esg)
	print_ESG(Question.yes_social, " --- Yes on Social Score: ", current.esg)
	print_ESG(Question.yes_governance, " --- Yes on Governance Score: ", current.esg)
	print_ESG(Question.no_enviroment, " --- No on Enviroment Score: ", current.esg)
	print_ESG(Question.no_social, " --- No on Social Score: ", current.esg)
	print_ESG(Question.no_governance, " --- Yes on Governance Score: ", current.esg)
