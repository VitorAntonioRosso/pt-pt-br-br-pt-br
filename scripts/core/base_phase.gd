class_name BasePhase
extends Node2D

## Base comum das fases jogáveis.
##
## Cria uma HUD discreta, a caixa de mensagem, pausa e pequenas ferramentas de
## apresentação. As fases concretas cuidam somente da mecânica do local.

const INK := Color("#10131c")
const PAPER := Color("#d7e1e2")
const MUTED := Color("#8aa2a9")
const CYAN := Color("#78d9df")
const AMBER := Color("#f0bb72")

var hud_layer: CanvasLayer
var hud: Control
var objective_label: Label
var hint_label: Label
var message_panel: PanelContainer
var message_label: Label
var message_timer: Timer
var pause_panel: PanelContainer
var pause_visible := false
var oxygen_bar: ProgressBar
var oxygen_label: Label

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	_build_hud()

func _build_hud() -> void:
	hud_layer = CanvasLayer.new()
	hud_layer.layer = 20
	add_child(hud_layer)
	hud = Control.new()
	hud.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	hud.mouse_filter = Control.MOUSE_FILTER_IGNORE
	hud_layer.add_child(hud)

	var top_bar := PanelContainer.new()
	top_bar.position = Vector2(24, 20)
	top_bar.size = Vector2(620, 76)
	top_bar.add_theme_stylebox_override("panel", _style(Color(0.02, 0.04, 0.07, 0.9), Color("#36545c"), 2, 12))
	hud.add_child(top_bar)
	var top_box := VBoxContainer.new()
	top_box.add_theme_constant_override("separation", 3)
	top_bar.add_child(top_box)
	objective_label = _label("OBJETIVO", 20, PAPER)
	objective_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	top_box.add_child(objective_label)
	hint_label = _label("WASD/setas: mover  •  E/Enter: interagir  •  Esc: pausa", 14, MUTED)
	top_box.add_child(hint_label)

	message_panel = PanelContainer.new()
	message_panel.position = Vector2(230, 530)
	message_panel.size = Vector2(692, 78)
	message_panel.visible = false
	message_panel.add_theme_stylebox_override("panel", _style(Color(0.015, 0.025, 0.04, 0.94), Color("#78d9df"), 1, 10))
	hud.add_child(message_panel)
	message_label = _label("", 18, PAPER)
	message_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	message_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	message_panel.add_child(message_label)

	message_timer = Timer.new()
	message_timer.one_shot = true
	message_timer.timeout.connect(func() -> void: message_panel.visible = false)
	add_child(message_timer)
	_build_pause()

func _build_pause() -> void:
	pause_panel = PanelContainer.new()
	pause_panel.position = Vector2(390, 150)
	pause_panel.size = Vector2(372, 342)
	pause_panel.visible = false
	pause_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	pause_panel.add_theme_stylebox_override("panel", _style(Color(0.02, 0.03, 0.05, 0.98), Color("#c2d5d2"), 2, 12))
	hud.add_child(pause_panel)
	var box := VBoxContainer.new()
	box.add_theme_constant_override("separation", 12)
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	pause_panel.add_child(box)
	var title := _label("PAUSA", 28, PAPER)
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(title)
	var divider := HSeparator.new()
	box.add_child(divider)
	var continue_button := Button.new()
	continue_button.text = "Continuar"
	continue_button.custom_minimum_size = Vector2(0, 46)
	continue_button.pressed.connect(toggle_pause)
	box.add_child(continue_button)
	var menu_button := Button.new()
	menu_button.text = "Salvar e voltar ao menu"
	menu_button.custom_minimum_size = Vector2(0, 46)
	menu_button.pressed.connect(func() -> void:
		GameState.save_progress()
		GameState.return_to_menu()
	)
	box.add_child(menu_button)
	var hint := _label("O progresso é salvo ao trocar de fase.", 13, MUTED)
	hint.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	box.add_child(hint)

func _style(background: Color, border: Color, width: int, radius: int) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = background
	style.border_color = border
	style.set_border_width_all(width)
	style.set_corner_radius_all(radius)
	style.content_margin_left = 16
	style.content_margin_right = 16
	style.content_margin_top = 10
	style.content_margin_bottom = 10
	return style

func _label(text_value: String, size: int, color: Color) -> Label:
	var label := Label.new()
	label.text = text_value
	label.add_theme_font_size_override("font_size", size)
	label.add_theme_color_override("font_color", color)
	return label

func add_background(texture_path: String) -> Sprite2D:
	var background := Sprite2D.new()
	background.texture = load(texture_path)
	background.position = Vector2(576, 324)
	background.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	background.z_index = -20
	add_child(background)
	return background

func add_actor(texture_path: String, actor_position: Vector2, actor_scale := Vector2.ONE) -> Sprite2D:
	var actor := Sprite2D.new()
	actor.texture = load(texture_path)
	actor.position = actor_position
	actor.scale = actor_scale
	actor.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	add_child(actor)
	return actor

func set_objective(text_value: String) -> void:
	if objective_label:
		objective_label.text = text_value

func set_hint(text_value: String) -> void:
	if hint_label:
		hint_label.text = text_value

func show_message(text_value: String, seconds := 3.5) -> void:
	if not message_panel:
		return
	message_label.text = text_value
	message_panel.visible = true
	message_timer.start(seconds)

func add_oxygen_hud() -> void:
	var panel := PanelContainer.new()
	panel.position = Vector2(850, 20)
	panel.size = Vector2(278, 76)
	panel.add_theme_stylebox_override("panel", _style(Color(0.02, 0.04, 0.07, 0.9), Color("#375f6b"), 2, 12))
	hud.add_child(panel)
	var box := VBoxContainer.new()
	panel.add_child(box)
	oxygen_label = _label("OXIGÊNIO", 14, CYAN)
	box.add_child(oxygen_label)
	oxygen_bar = ProgressBar.new()
	oxygen_bar.max_value = 100.0
	oxygen_bar.value = 100.0
	oxygen_bar.show_percentage = false
	oxygen_bar.custom_minimum_size = Vector2(238, 18)
	box.add_child(oxygen_bar)

func set_oxygen(value: float, seconds_left := 0.0) -> void:
	if not oxygen_bar:
		return
	var clamped := clampf(value, 0.0, 100.0)
	oxygen_bar.value = clamped
	var color := CYAN if clamped > 25.0 else AMBER
	if clamped <= 10.0:
		color = Color("#ee7670")
	oxygen_bar.modulate = color
	oxygen_label.text = "OXIGÊNIO  %02d%%  •  %02ds" % [roundi(clamped), roundi(seconds_left)]

func toggle_pause() -> void:
	pause_visible = not pause_visible
	pause_panel.visible = pause_visible
	get_tree().paused = pause_visible

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_ESCAPE:
		toggle_pause()
		get_viewport().set_input_as_handled()
