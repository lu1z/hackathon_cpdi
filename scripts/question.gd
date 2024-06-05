extends Object

class_name Question

var id: StringName
var actor: StringName
var question: StringName
var yes: StringName
var no: StringName
var esg: Array
var cost: int
var action: Callable

static var yes_group = range(0, 24)
static var yes_enviroment = range(0, 8)
static var yes_social = range(8, 14)
static var yes_governance = range(14, 24)

static var no_group = range(24, 48)
static var no_enviroment = range(24, 32)
static var no_social = range(32, 38)
static var no_governance = range(38, 48)

static var yes_str = "Yes"
static var no_str = "No"

static var enviroment_str = "Ambiental"
static var social_str = "Social"
static var governance_str = "Governança"

enum ESG_GROUPS {ENVIROMENT, SOCIAL, GOVERNANCE}

static var esg_groups = [enviroment_str, social_str, governance_str]

static var enviroment = [
	"Combate ao desmatamento",
	"Preservação da biodiversidade",
	"Descarte adequado de dejetos e reciclagem",
	"Combate ao aquecimento global e redução da emissão de carbono",
	"Gestão de resíduos",
	"Diminuição da poluição",
	"Consumo consciente da água",
	"Uso de energias renováveis",
]

static var social = [
	"Representatividade e inclusão de minorias",
	"Valorização dos funcionários",
	"Combate a questões como preconceitos, misoginia, assédio sexual...",
	"Cumprimento das leis trabalhistas e dos direitos humanos",
	"Combate a trabalhos infantis e análogos à escravidão",
	"Criação e desenvolvimento de projetos sociais",
]

static var governance = [
	"Adoção de boas práticas administrativas",
	"Criação de canais de denúncia",
	"Independência do conselho administrativo",
	"Política de transparência",
	"Apresentação de relatórios financeiros",
	"Diversidade no conselho",
	"Responsabilidade fiscal",
	"Combate a corrupção",
	"Gestão de riscos",
	"Critérios transparentes sobre remuneração e planos de carreira"
]

static var esg_table_strs = [
	[enviroment_str, enviroment],
	[social_str, social],
	[governance_str, governance],
]

static var esg_map_table_strs = [
	[yes_str, esg_table_strs],
	[no_str, esg_table_strs],
]

static func build_esg_map():
	var map = []
	map.append_array(enviroment)
	map.append_array(social)
	map.append_array(governance)
	map.append_array(enviroment)
	map.append_array(social)
	map.append_array(governance)
	return map

static var esg_map_strs = build_esg_map()

static var indexedNames = [
	"Combate ao desmatamento",
	"Preservação da biodiversidade",
	"Descarte adequado de dejetos e reciclagem",
	"Combate ao aquecimento global e redução da emissão de carbono",
	"Gestão de resíduos",
	"Diminuição da poluição",
	"Consumo consciente da água",
	"Uso de energias renováveis",
	"Representatividade e inclusão de minorias",
	"Valorização dos funcionários",
	"Combate a questões como preconceitos, misoginia, assédio sexual...",
	"Cumprimento das leis trabalhistas e dos direitos humanos",
	"Combate a trabalhos infantis e análogos à escravidão",
	"Criação e desenvolvimento de projetos sociais",
	"Adoção de boas práticas administrativas",
	"Criação de canais de denúncia",
	"Independência do conselho administrativo",
	"Política de transparência",
	"Apresentação de relatórios financeiros",
	"Diversidade no conselho",
	"Responsabilidade fiscal",
	"Combate a corrupção",
	"Gestão de riscos",
	"Critérios transparentes sobre remuneração e planos de carreira"
]

func group_sum(section):
	var sum = 0
	for i in section:
		sum += esg[i]
	return sum
