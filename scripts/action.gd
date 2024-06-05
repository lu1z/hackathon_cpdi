extends Object

class_name Action

static var action_templates = {
	
}

func do_nothing():
	pass

func change_revenue(value, period):
	GameManager.score_manager.revenue += value
	if period == 0:
		return
	var turn_timer = func(tt, period):
						GameManager.myself.turn_advanced.disconnect(tt)
						if period <= 1:
							GameManager.score_manager.revenue -= value
						else:
							GameManager.myself.turn_advanced.connect(
								tt.bind(tt, period - 1)
							)
	GameManager.myself.turn_advanced.connect(
		turn_timer.bind(turn_timer, period)
	)
