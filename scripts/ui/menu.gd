extends Node2D

## Menu inicial e créditos do protótipo do Ato 1.

var credits_panel: PanelContainer
var status_label: Label

func _ready() -> void:
	var background := Sprite2D.new()
	background.texture = load("res://assets/generated/menu_bg.png")
	background.position = Vector2(576, 324)
	background.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(background)

	var shade := ColorRect.new()
	shade.color = Color(0.01, 0.02, 0.04, 0.38)
	shade.position = Vector2.ZERO
	shade.size = Vector2(1152, 648)
	add_child(shade)

	var title := Label.new()
	title.text = "OS SETE"
	title.position = Vector2(82, 82)
	title.add_theme_font_size_override("font_size", 62)
	title.add_theme_color_override("font_color", Color("#d7e1e2"))
	add_child(title)
	var subtitle := Label.new()
	subtitle.text = "A DESCOBERTA  •  ATO 1"
	subtitle.position = Vector2(88, 154)
	subtitle.add_theme_font_size_override("font_size", 18)
	subtitle.add_theme_color_override("font_color", Color("#78d9df"))
	add_child(subtitle)

	var card := PanelContainer.new()
	card.position = Vector2(82, 230)
	card.size = Vector2(360, 300)
	card.add_theme_stylebox_override("panel", _style())
	add_child(card)
	var buttons := VBoxContainer.new()
	buttons.add_theme_constant_override("separation", 12)
	card.add_child(buttons)
	var new_button := _button("Novo jogo")
	new_button.pressed.connect(GameState.start_new_game)
	buttons.add_child(new_button)
	var continue_button := _button("Continuar")
	continue_button.disabled = not GameState.has_save()
	continue_button.pressed.connect(GameState.continue_game)
	buttons.add_child(continue_button)
	var settings_button := _button("Configurações")
	settings_button.pressed.connect(_toggle_settings)
	buttons.add_child(settings_button)
	var credits_button := _button("Créditos")
	credits_button.pressed.connect(_toggle_credits)
	buttons.add_child(credits_button)

	status_label = Label.new()
	status_label.text = "Sem combate. Sem inimigos. Apenas o que o mar esconde."
	status_label.position = Vector2(82, 580)
	status_label.add_theme_font_size_override("font_size", 15)
	status_label.add_theme_color_override("font_color", Color("#8aa2a9"))
	add_child(status_label)
	_build_credits()

func _button(text_value: String) -> Button:
	var button := Button.new()
	button.text = text_value
	button.custom_minimum_size = Vector2(0, 48)
	button.add_theme_font_size_override("font_size", 18)
	return button

func _style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.02, 0.035, 0.06, 0.94)
	style.border_color = Color("#36545c")
	style.set_border_width_all(2)
	style.set_corner_radius_all(12)
	style.content_margin_left = 20
	style.content_margin_right = 20
	style.content_margin_top = 18
	style.content_margin_bottom = 18
	return style

func _build_credits() -> void:
	credits_panel = PanelContainer.new()
	credits_panel.position = Vector2(520, 230)
	credits_panel.size = Vector2(500, 250)
	credits_panel.visible = false
	credits_panel.add_theme_stylebox_override("panel", _style())
	add_child(credits_panel)
	var text := Label.new()
	text.text = "OS SETE — A DESCOBERTA\n\nUma homenagem não comercial ao autor André Vianco.\n\nProjeto Godot 4 • pixel art autoral • Ato 1\n\nBaseado nas notas de adaptação e no romance de referência."
	text.add_theme_font_size_override("font_size", 17)
	text.add_theme_color_override("font_color", Color("#d7e1e2"))
	text.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	credits_panel.add_child(text)

func _toggle_credits() -> void:
	credits_panel.visible = not credits_panel.visible
	status_label.text = "Feche Créditos para voltar ao menu." if credits_panel.visible else "Sem combate. Sem inimigos. Apenas o que o mar esconde."

func _toggle_settings() -> void:
	GameState.settings["reduced_motion"] = not GameState.settings.get("reduced_motion", false)
	GameState.save_progress()
	status_label.text = "Movimento reduzido: %s" % ("ligado" if GameState.settings["reduced_motion"] else "desligado")
