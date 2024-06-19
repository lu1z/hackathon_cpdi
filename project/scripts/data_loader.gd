class_name DataLoader extends Object


enum {JSON_FILE, CONFIG_FILE, CSV_FILE}
var strategy = CONFIG_FILE


static var QUESTIONS_FILE_PATH = "res://questions.txt"
static var CHARACTERS_FILE_PATH = "res://characters.txt"
static var ACTIONS_FILE_PATH = "res://actions.txt"


func load_file():
	match strategy:
		CONFIG_FILE:
			return load_config_file()
		CSV_FILE:
			return load_csv_file()
		JSON_FILE:
			return load_json_file()

#outdated
func load_config_file():
	var q_data = []
	var config = ConfigFile.new()
	# Load data from a file.
	var err = config.load(QUESTIONS_FILE_PATH)
	# If the file didn't load, ignore it.
	if err != OK:
		print("Não foi possivel abrir o aquivo: ", QUESTIONS_FILE_PATH)
		return
	# Iterate over all sections.
	for q in config.get_sections():
		# Fetch the data for each section.
		var question = Question.new()
		question.id = StringName(q)
		question.actor = StringName("Sara")
		question.question = StringName(config.get_value(q, "PERGUNTA"))
		question.esg = config.get_value(q, "ESG")
		q_data.append(question)
	return q_data


func load_json_file():
	#TODO
	pass


func load_csv_file_characters():
	var file = FileAccess.open(CHARACTERS_FILE_PATH, FileAccess.READ)
	if file == null:
		print(FileAccess.get_open_error())
		return
	var q_data = {}
	while not file.eof_reached():
		var line = file.get_csv_line()
		if line.size() <= 1:
			continue
		var character = Character.new()
		character.id = line[0]
		character.display_name = line[1]
		character.asset_image = line[2]
		q_data.merge({ character.id: character })
	file.close()
	return q_data


func load_csv_file_actions():
	var file = FileAccess.open(ACTIONS_FILE_PATH, FileAccess.READ)
	if file == null:
		print(FileAccess.get_open_error())
		return
	var q_data = {}
	while not file.eof_reached():
		var line = file.get_csv_line()
		if line.size() <= 1:
			continue
		var action = []
		action.append(line[1])
		action.append(line[2])
		q_data.merge({ line[0]: action })
	file.close()
	return q_data


func load_csv_file():
	var characters = load_csv_file_characters()
	var actions = load_csv_file_actions()
	var file = FileAccess.open(QUESTIONS_FILE_PATH, FileAccess.READ)
	if file == null:
		print(FileAccess.get_open_error())
		return
	var q_data = []
	while not file.eof_reached():
		var line = file.get_csv_line()
		if line.size() <= 1:
			continue
		var question = Question.new()
		var last = line.size() - 1
		var action = Action.new()
		action.name = StringName(line[last])
		last -= 1
		action.arg4 = line[last]
		last -= 1
		action.arg3 = line[last]
		last -= 1
		action.arg2 = line[last]
		last -= 1
		action.arg1 = line[last]
		last -= 1
		var a = actions.get(action.name)
		action.text = a[0]
		action.icon = a[1]
		question.action = action
		question.id = StringName(line[last])
		last -= 1
		question.character = characters.get(line[last])
		last -= 1
		question.question = StringName(line[last])
		last -= 1
		question.yes = StringName(line[last])
		last -= 1
		question.no = StringName(line[last])
		last -= 1
		question.cost = int(line[last])
		var esg_table = []
		for i in last:
			esg_table.append(int(line[i]))
		var esg = ESG.new()
		esg.esg = esg_table
		question.esg = esg
		q_data.append(question)
	file.close()
	return q_data
