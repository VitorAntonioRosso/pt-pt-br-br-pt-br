extends CutscenePhase

func _init() -> void:
	next_scene = "res://scenes/acto1/cutscene_1_6.tscn"
	panels = [
		{"image": "res://assets/generated/cutscene_15.png", "text": "Dias depois, a USPA trouxe o navio de volta à luz com balões laranja e cabos."},
		{"image": "res://assets/generated/cutscene_15.png", "text": "A proa cedeu. A caixa de prata se soltou e despencou de volta ao fundo."},
		{"image": "res://assets/generated/cutscene_15.png", "text": "No dia seguinte, a caixa foi recuperada e levada às docas. O que veio do fundo do mar não ficaria lá por muito tempo."},
	]
