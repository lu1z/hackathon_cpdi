extends Node


var score: Array
var money: int
var revenue: int
var skip: int
var debt: int


static var DEFAULT_INITIAL_SCORE = 0 #Valor inicial de cada topico dentro do esg
static var DEFAULT_INITIAL_MONEY = 200_0 #Dinheiro inicial
static var DEFAULT_INITIAL_REVENUE = int(DEFAULT_INITIAL_MONEY / 20) #Salário inical
static var DEFAULT_WIN_CONDITION = 50 # "E" > 5 and "S" > 5 and "G" > 5
static var DEFAULT_LOSE_CONDITION = -50 # "E" < -20 or "S" < -20 or "G" < -20
static var DEFAULT_BIAS_MAGNITUDE = 5 #Filtro de quanto a soma de um grupo deve ter para ser elegivel como anti bad luck
static var DEFAULT_BIAS_TRIGGER = int(DEFAULT_LOSE_CONDITION / 2) #Quão baixo o score do grupo deve estar para acionar a mecanica anti bad luck
static var DEFAULT_INITIAL_SKIP = 3 #Quantidade de skips inicial
static var DEFAULT_DEBT_TIMER = 3 #Consecutive turns on negative to lose


func score_initialize():
	money = DEFAULT_INITIAL_MONEY
	revenue = DEFAULT_INITIAL_REVENUE
	skip = DEFAULT_INITIAL_SKIP
	score = []
	score.resize(len(ESG.esg_half_table))
	score.fill(DEFAULT_INITIAL_SCORE)
	debt = -1


func debt_mechanic():
	if money >= 0:
		debt = -1
	else:
		if not is_in_debt():
			debt = DEFAULT_DEBT_TIMER


func decrement_debt():
	debt -= 1


func is_in_debt():
	return debt >= 0


func apply_revenue():
	money += revenue
	debt_mechanic()


func apply_cost(cost):
	money += cost
	debt_mechanic()


func cant_skip():
	return skip <= 0


func decrement_skip():
	skip -= 1


func get_current_group_score(group: ESG.ESG_GROUPS):
	match group:
		ESG.ESG_GROUPS.ENVIROMENT:
			return ESG.group_sum(score, ESG.yes_enviroment)
		ESG.ESG_GROUPS.SOCIAL:
			return ESG.group_sum(score, ESG.yes_social)
		ESG.ESG_GROUPS.GOVERNANCE:
			return ESG.group_sum(score, ESG.yes_governance)


func check_bias_necessity():
	if get_current_group_score(ESG.ESG_GROUPS.ENVIROMENT) < DEFAULT_BIAS_TRIGGER:
		return ESG.ESG_GROUPS.ENVIROMENT
	if get_current_group_score(ESG.ESG_GROUPS.SOCIAL) < DEFAULT_BIAS_TRIGGER:
		return ESG.ESG_GROUPS.SOCIAL
	if get_current_group_score(ESG.ESG_GROUPS.GOVERNANCE) < DEFAULT_BIAS_TRIGGER:
		return ESG.ESG_GROUPS.GOVERNANCE
	return -1


func apply_scores(esg: Array, group: Array):
	var index = 0
	for i in group:
		score[index] += esg[i]
		index += 1


func check_win_condition():
	var env = get_current_group_score(ESG.ESG_GROUPS.ENVIROMENT) >= DEFAULT_WIN_CONDITION
	var soc = get_current_group_score(ESG.ESG_GROUPS.SOCIAL) >= DEFAULT_WIN_CONDITION
	var gov = get_current_group_score(ESG.ESG_GROUPS.GOVERNANCE) >= DEFAULT_WIN_CONDITION
	return env and soc and gov


func check_lose_condition():
	var env = get_current_group_score(ESG.ESG_GROUPS.ENVIROMENT) <= DEFAULT_LOSE_CONDITION
	var soc = get_current_group_score(ESG.ESG_GROUPS.SOCIAL) <= DEFAULT_LOSE_CONDITION
	var gov = get_current_group_score(ESG.ESG_GROUPS.GOVERNANCE) <= DEFAULT_LOSE_CONDITION
	return env or soc or gov or debt == 0


func print_score():
	print("Money: " + str(money) + " Revenue: " + str(revenue))
	print(" Enviroment Score: " + str(get_current_group_score(ESG.ESG_GROUPS.ENVIROMENT)) +
		" Social Score: " + str(get_current_group_score(ESG.ESG_GROUPS.SOCIAL)) +
		" Governance Score: " + str(get_current_group_score(ESG.ESG_GROUPS.GOVERNANCE))
	)
