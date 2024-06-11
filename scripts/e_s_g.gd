class_name ESG extends Object


var esg: Array

enum ESG_GROUPS {ENVIROMENT, SOCIAL, GOVERNANCE}


static var yes_group = range(0, 24)
static var yes_enviroment = range(0, 8)
static var yes_social = range(8, 14)
static var yes_governance = range(14, 24)

static var no_group = range(24, 48)
static var no_enviroment = range(24, 32)
static var no_social = range(32, 38)
static var no_governance = range(38, 48)


static var enviroment_table = [
	"Combate ao desmatamento",
	"Preservação da biodiversidade",
	"Descarte adequado de dejetos e reciclagem",
	"Combate ao aquecimento global e redução da emissão de carbono",
	"Gestão de resíduos",
	"Diminuição da poluição",
	"Consumo consciente da água",
	"Uso de energias renováveis",
]

static var social_table = [
	"Representatividade e inclusão de minorias",
	"Valorização dos funcionários",
	"Combate a questões como preconceitos, misoginia, assédio sexual...",
	"Cumprimento das leis trabalhistas e dos direitos humanos",
	"Combate a trabalhos infantis e análogos à escravidão",
	"Criação e desenvolvimento de projetos sociais",
]

static var governance_table = [
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


static var esg_half_table = [
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


func is_group_sum_larger_than(group: ESG_GROUPS, magnitude: int):
	match group:
		ESG_GROUPS.ENVIROMENT:
			return group_sum(esg, yes_enviroment) > magnitude or group_sum(esg, no_enviroment)
		ESG_GROUPS.SOCIAL:
			return group_sum(esg, yes_social) > magnitude or group_sum(esg, no_social)
		ESG_GROUPS.GOVERNANCE:
			return group_sum(esg, yes_governance) > magnitude or group_sum(esg, no_governance)


static func group_sum(location: Array, section: Array):
	var sum = 0
	for i in section:
		sum += location[i]
	return sum


func self_group_sum(section: Array):
	return group_sum(esg, section)


func print_ESG(section, group_identification_str):
	for i in section:
		print(
			str(i) +
			" ESG: " +
			esg_half_table[i % len(esg_half_table)] +
			group_identification_str +
			str(esg[i])
		)


func print_ESGs():
	print_ESG(yes_enviroment, " --- Yes on Enviroment Score: ")
	print_ESG(yes_social, " --- Yes on Social Score: ")
	print_ESG(yes_governance, " --- Yes on Governance Score: ")
	print_ESG(no_enviroment, " --- No on Enviroment Score: ")
	print_ESG(no_social, " --- No on Social Score: ")
	print_ESG(no_governance, " --- Yes on Governance Score: ")
