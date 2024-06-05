extends Object

class_name ScoreManager

var score: Array
var money: int
var revenue: int
var skip: int

@export var DEFAULT_INITIAL_SCORE = 0
@export var DEFAULT_INITIAL_MONEY = 1000000
@export var DEFAULT_INITIAL_REVENUE = 27000
@export var DEFAULT_WIN_CONDITION = 5
@export var DEFAULT_LOSE_CONDITION = -20

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
	return env and soc and gov
