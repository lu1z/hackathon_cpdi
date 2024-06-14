extends Node


signal turn_advanced


var turn: int
var params
var game_id = 1


func initialize_game():
	QuestionManager.question_initialize()
	ScoreManager.score_initialize()
	turn = 0
	game_id += 1
# Debug purposes
	print("--------------------preturn----------------------")
	ScoreManager.print_score()
	print("-----------------preturn-ended-------------------")


func pre_turn():
	turn += 1
	GameManager.turn_advanced.emit()
	if ScoreManager.is_in_debt():
		ScoreManager.decrement_debt()
	ScoreManager.apply_revenue()
	print("------------------turn: " + str(turn) + " ------------------")


func present_question():
	var bad_luck_protection = ScoreManager.check_bias_necessity()
	if bad_luck_protection < 0:
		return QuestionManager.draw_question()
	QuestionManager.draw_question_with_bias(
		bad_luck_protection,
		ScoreManager.DEFAULT_BIAS_MAGNITUDE
	)
#debug purposes
	match bad_luck_protection:
		0:
			print("-------Triggered Enviroment bias---------")
			print("Enviroment yes sum: " + str(QuestionManager.current.esg.self_group_sum(ESG.yes_enviroment) ) )
			print("Enviroment no  sum: " + str(QuestionManager.current.esg.self_group_sum(ESG.no_enviroment) ) )
			print("-------TURN PARITY: " + str(turn % 2))
		1:
			print("-------Triggered Social bias---------")
			print("Social yes sum: " + str(QuestionManager.current.esg.self_group_sum(ESG.yes_social) ) )
			print("Social no  sum: " + str(QuestionManager.current.esg.self_group_sum(ESG.no_social) ) )
			print("-------TURN PARITY: " + str(turn % 2))
		2:
			print("-------Triggered Governance bias---------")
			print("Governance yes sum: " + str(QuestionManager.current.esg.self_group_sum(ESG.yes_governance) ) )
			print("Governance no  sum: " + str(QuestionManager.current.esg.self_group_sum(ESG.no_governance) ) )
			print("-------TURN PARITY: " + str(turn % 2))


func post_turn():
#Debug
	#change this to native signal value_changed(value)
	#$TextureRect/botaoE/progressBarE.value = score_manager.get_current_enviroment_score()
	print("------------------endturn: " + str(turn) + " ------------------")
	if ScoreManager.check_win_condition():
		print("---------------------Won-------------------")
	if ScoreManager.check_lose_condition():
		print("---------------------Lost-------------------")


func _on_botao_pergunta_skip_pressed():
	QuestionManager.rollback_question()
	present_question()
	

# connect to yes button
func _on_botao_pergunta_nao_pressed():
	ScoreManager.apply_scores(QuestionManager.current.esg.esg, ESG.no_group)
	post_turn()

# connect to yes button
func _on_botao_pergunta_sim_pressed():
	ScoreManager.apply_cost(QuestionManager.current.cost)
	ScoreManager.apply_scores(QuestionManager.current.esg.esg, ESG.yes_group)
	QuestionManager.current.action.execute()
	post_turn()


func _on_botao_avanca_turno_pressed():
	print("Next turn pressed")
	pre_turn()
	present_question()
	# Debug purposes
	print("Chosen question: " + QuestionManager.current.id)
