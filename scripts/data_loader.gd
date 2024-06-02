extends Object

class_name DataLoader

enum {JSON_FILE, CONFIG_FILE, CSV_FILE}

static var QUESTIONS_FILE_PATH = "res://questions.txt"
var strategy = CONFIG_FILE

func load_file():
	if strategy == CONFIG_FILE:
		return load_config_file()
	if strategy == CSV_FILE:
		return load_csv_file()
	return load_json_file()

func save_file():
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("q1", "PERGUNTA", "Jonas, Lider de manutenção setor financeiro quer implementar paineis solares para a geração de energia da empresa, voce aceita?")
	config.set_value("q1", "ESG", [0,0,0,1,0,1,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,0,-3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
	config.set_value("q1", "AREA", "ENVIROMENT")
	config.set_value("q1", "SETOR", "MANUTENÇÃO")
	
	config.set_value("q2", "PERGUNTA", "Jonas, Lider de manutenção setor financeiro quer implementar paineis solares para a geração de energia da empresa, voce aceita?")
	config.set_value("q2", "ESG", [0,0,0,1,0,1,0,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,0,-1,0,-3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
	config.set_value("q2", "AREA", "ENVIROMENT")
	config.set_value("q2", "SETOR", "MANUTENÇÃO")

	# Save it to a file (overwrite if already exists).
	config.save(QUESTIONS_FILE_PATH)


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

func load_csv_file():
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
		question.id = StringName(line[last])
		last -= 1
		question.actor = StringName(line[last])
		last -= 1
		question.question = StringName(line[last])
		last -= 1
		question.yes = StringName(line[last])
		last -= 1
		question.no = StringName(line[last])
		last -= 1
		question.cost = int(line[last])
		var esg = []
		for i in last:
			esg.append(int(line[i]))
		question.esg = esg
		q_data.append(question)
	file.close()
	return q_data
