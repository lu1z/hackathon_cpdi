extends Object

class_name Action

var name: StringName
var arg1: String
var arg2: String
var arg3: String
var arg4: String

func execute():
	Callable(Action, name).call(arg1, arg2, arg3, arg4)

static func do_nothing(_arg1, _arg2, _arg3, _arg4):
	pass

static func change_revenue(_arg1, _arg2, _arg3, _arg4):
	var value = int(_arg1)
	var period = int(_arg2)
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

static func change_skips(_arg1, _arg2, _arg3, _arg4):
	var value = int(_arg1)
	GameManager.score_manager.skip += value

static func change_skips_and_revenue(_arg1, _arg2, _arg3, _arg4):
	change_skips(_arg1, "", "", "")
	change_revenue(_arg2, _arg3, "", "")
