extends Object

class_name ScoreManager

var score: Array
var money: int
var revenue: int

@export var DEFAULT_INITIAL_VALUE = 0
@export var DEFAULT_INITIAL_MONEY = 1000000
@export var DEFAULT_INITIAL_REVENUE = 27000

func score_initialize():
	money = DEFAULT_INITIAL_MONEY
	revenue = DEFAULT_INITIAL_REVENUE
	score = []
	score.resize(len(Question.indexedNames))
	score.fill(DEFAULT_INITIAL_VALUE)

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
