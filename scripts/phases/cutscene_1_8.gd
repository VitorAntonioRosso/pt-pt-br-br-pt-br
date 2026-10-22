extends CutscenePhase

func _init() -> void:
	next_scene = "res://scenes/acto1/cutscene_1_9.tscn"
	panels = [
		{"image": "res://assets/generated/cutscene_18.png", "text": "A multidão se apertou quando a placa frontal saiu. Eliana foi empurrada contra a serra."},
		{"image": "res://assets/generated/cutscene_18.png", "text": "Metal raspando. Um grito curto. A lâmina abriu a mão direita."},
		{"image": "res://assets/generated/cutscene_18.png", "text": "O corte era pequeno, mas sangrava muito. Ela se apoiou na borda fria da caixa."},
		{"image": "res://assets/generated/cutscene_18.png", "text": "Um fio de sangue escorreu para dentro. O que estava selado começou a responder."},
	]
