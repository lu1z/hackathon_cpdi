class_name ScoreManager extends Object


var score: Array
var money: int
var revenue: int
var skip: int


static var DEFAULT_INITIAL_SCORE = 0 #Valor inicial de cada topico dentro do esg
static var DEFAULT_INITIAL_MONEY = 1_000_000 #Dinheiro inicial
static var DEFAULT_INITIAL_REVENUE = int(DEFAULT_INITIAL_MONEY / 10) #Salário inical
static var DEFAULT_WIN_CONDITION = 5 # "E" > 5 and "S" > 5 and "G" > 5
static var DEFAULT_LOSE_CONDITION = -10 # "E" < -20 or "S" < -20 or "G" < -20
static var DEFAULT_BIAS_MAGNITUDE = 5 #Filtro de quanto a soma de um grupo deve ter para ser elegivel como anti bad luck
static var DEFAULT_BIAS_TRIGGER = int(DEFAULT_LOSE_CONDITION / 2) #Quão baixo o score do grupo deve estar para acionar a mecanica anti bad luck


func _init():
	score_initialize()


func score_initialize():
	money = DEFAULT_INITIAL_MONEY
	revenue = DEFAULT_INITIAL_REVENUE
	score = []
	score.resize(len(Question.indexedNames))
	score.fill(DEFAULT_INITIAL_SCORE)


func get_current_group_score(group: Array):
	var sum = 0
	for i in group:
		sum += score[i]
	return sum


func get_current_enviroment_score():
	return get_current_group_score(Question.yes_enviroment)


func get_current_social_score():
	return get_current_group_score(Question.yes_social)


func get_current_governance_score():
	return get_current_group_score(Question.yes_governance)


func apply_revenue():
	money += revenue


func apply_cost(cost):
	money += cost 


func print_score():
	print("Money: " + str(money) + " Revenue: " + str(revenue))
	print(" Enviroment Score: " + str(get_current_enviroment_score()) +
		" Social Score: " + str(get_current_social_score()) +
		" Governance Score: " + str(get_current_governance_score())
	)


func check_bias_necessity():
	if get_current_enviroment_score() < DEFAULT_BIAS_TRIGGER:
		return Question.ESG_GROUPS.ENVIROMENT
	if get_current_social_score() < DEFAULT_BIAS_TRIGGER:
		return Question.ESG_GROUPS.SOCIAL
	if get_current_governance_score() < DEFAULT_BIAS_TRIGGER:
		return Question.ESG_GROUPS.GOVERNANCE
	return -1


func apply_scores(esg: Array, group: Array):
	var index = 0
	for i in group:
		score[index] += esg[i]
		index += 1


func check_win_condition():
	var env = get_current_enviroment_score() >= DEFAULT_WIN_CONDITION
	var soc = get_current_social_score() >= DEFAULT_WIN_CONDITION
	var gov = get_current_governance_score() >= DEFAULT_WIN_CONDITION
	return env and soc and gov


func check_lose_condition():
	var env = get_current_enviroment_score() <= DEFAULT_LOSE_CONDITION
	var soc = get_current_social_score() <= DEFAULT_LOSE_CONDITION
	var gov = get_current_governance_score() <= DEFAULT_LOSE_CONDITION
	return env or soc or gov
