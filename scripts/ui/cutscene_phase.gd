class_name CutscenePhase
extends BasePhase

## Apresentação de quadros em HQ.
## Cada fase concreta fornece painéis e o caminho da próxima cena.

var panels: Array[Dictionary] = []
var next_scene := ""
var panel_index := 0
var panel_image: TextureRect
var narrative_label: Label
var progress_label: Label

func _ready() -> void:
	super._ready()
	_build_story_ui()
	_render_panel()

func _build_story_ui() -> void:
	var layer := CanvasLayer.new()
	layer.layer = 10
	add_child(layer)
	var backdrop := ColorRect.new()
	backdrop.color = Color("#080b12")
	backdrop.position = Vector2.ZERO
	backdrop.size = Vector2(1152, 648)
	layer.add_child(backdrop)
	var frame := PanelContainer.new()
	frame.position = Vector2(74, 55)
	frame.size = Vector2(1004, 430)
	frame.add_theme_stylebox_override("panel", _frame_style())
	layer.add_child(frame)
	panel_image = TextureRect.new()
	panel_image.position = Vector2(90, 70)
	panel_image.size = Vector2(972, 400)
	panel_image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	panel_image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	panel_image.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	layer.add_child(panel_image)
	var text_frame := PanelContainer.new()
	text_frame.position = Vector2(115, 493)
	text_frame.size = Vector2(922, 112)
	text_frame.add_theme_stylebox_override("panel", _frame_style())
	layer.add_child(text_frame)
	narrative_label = _label("", 21, PAPER)
	narrative_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	narrative_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	narrative_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	text_frame.add_child(narrative_label)
	progress_label = _label("", 14, MUTED)
	progress_label.position = Vector2(990, 26)
	layer.add_child(progress_label)
	set_hint("E/Enter/clique: avançar  •  Esc: pausa")

func _frame_style() -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#0d111c")
	style.border_color = Color("#d7e1e2")
	style.set_border_width_all(3)
	style.set_corner_radius_all(4)
	style.content_margin_left = 18
	style.content_margin_right = 18
	style.content_margin_top = 12
	style.content_margin_bottom = 12
	return style

func _render_panel() -> void:
	if panels.is_empty():
		return
	var panel: Dictionary = panels[panel_index]
	panel_image.texture = load(str(panel.get("image", "")))
	narrative_label.text = str(panel.get("text", ""))
	progress_label.text = "%02d / %02d" % [panel_index + 1, panels.size()]

func _unhandled_input(event: InputEvent) -> void:
	super._unhandled_input(event)
	if event is InputEventKey and event.pressed and not event.echo and event.keycode in [KEY_E, KEY_ENTER, KEY_SPACE]:
		advance_panel()
		get_viewport().set_input_as_handled()
	elif event is InputEventMouseButton and event.pressed:
		advance_panel()

func advance_panel() -> void:
	panel_index += 1
	if panel_index >= panels.size():
		GameState.change_phase(next_scene)
	else:
		_render_panel()
