extends BasePhase

## Encerramento do Ato 1 e ponto de entrada do próximo bloco.

func _ready() -> void:
	super._ready()
	var background := ColorRect.new()
	background.color = Color("#06080d")
	background.position = Vector2.ZERO
	background.size = Vector2(1152, 648)
	add_child(background)
	var title := _label("CAPÍTULO 2", 46, Color("#d7e1e2"))
	title.position = Vector2(390, 235)
	add_child(title)
	var subtitle := _label("O DESPERTAR", 28, Color("#78d9df"))
	subtitle.position = Vector2(446, 300)
	add_child(subtitle)
	var body := _label("O dedo se moveu.\n\nAto 1 concluído — A Descoberta", 18, Color("#8aa2a9"))
	body.position = Vector2(410, 365)
	body.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	add_child(body)
	set_hint("Enter/E: voltar ao menu  •  Esc: pausa")

func _unhandled_input(event: InputEvent) -> void:
	super._unhandled_input(event)
	if event is InputEventKey and event.pressed and not event.echo and event.keycode in [KEY_E, KEY_ENTER, KEY_SPACE]:
		GameState.return_to_menu()
