extends BasePhase

## Fase 1.4: porão da caravela. O susto é o eco e o cardume, nunca um inimigo.

var diver: Sprite2D
var lantern_light: PointLight2D
var lantern_cone: Sprite2D
var last_direction := Vector2.RIGHT
var relic: Sprite2D
var box: Sprite2D
var oxygen := 100.0
var elapsed := 0.0
var item_collected := false
var box_inspected := false
var scare_shown := false
var speed := 125.0

func _ready() -> void:
	super._ready()
	add_background("res://assets/generated/dive_interior.png")
	diver = add_actor("res://assets/generated/tiago_dive.png", Vector2(145, 440), Vector2(1.05, 1.05))
	_build_lantern()
	relic = add_actor("res://assets/generated/relic.png", Vector2(475, 360), Vector2(1.2, 1.2))
	box = add_actor("res://assets/generated/silver_box.png", Vector2(858, 350), Vector2(1.8, 1.8))
	add_oxygen_hud()
	set_objective("Explore o porão. Recolha uma peça e encontre a caixa prateada.")
	set_hint("WASD/setas: nadar  •  E/Enter: investigar  •  Esc: pausa")
	show_message("O porão parece uma caixa acústica. O ar já caiu para menos de vinte minutos.", 4.0)

func _process(delta: float) -> void:
	if pause_visible:
		return
	elapsed += delta
	oxygen -= 0.62 * delta
	set_oxygen(oxygen, oxygen * 1.2)
	if not scare_shown and elapsed > 5.0:
		scare_shown = true
		var fish := add_actor("res://assets/generated/school_fish.png", Vector2(-120, 300), Vector2(1.2, 1.2))
		show_message("RANGIDO. O casco inteiro geme — e um cardume de espadinhas atravessa o porão.", 3.4)
		var tween := create_tween()
		tween.tween_property(fish, "position", Vector2(1250, 300), 2.4)
		tween.tween_callback(fish.queue_free)
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length() > 0.0:
		last_direction = direction.normalized()
	diver.position += direction * speed * delta
	diver.position.x = clampf(diver.position.x, 90.0, 1070.0)
	diver.position.y = clampf(diver.position.y, 145.0, 560.0)
	lantern_light.position = diver.position
	lantern_cone.position = diver.position + last_direction * 74.0
	lantern_cone.rotation = last_direction.angle()
	if oxygen <= 0.0:
		oxygen = 100.0
		diver.position = Vector2(145, 440)
		show_message("O ar acabou. Você retorna à abertura, sem perder o que encontrou.", 3.0)
	if Input.is_action_just_pressed("interact"):
		_interact()

func _interact() -> void:
	if not item_collected and diver.position.distance_to(relic.position) < 90.0:
		item_collected = true
		relic.visible = false
		GameState.set_flag("dive_item", true)
		set_objective("Inspecione a caixa de prata e leia o nome em relevo.")
		show_message("Você recolheu uma imagem de santo. Dez quilos de história presa ao pulso.", 3.0)
		return
	if diver.position.distance_to(box.position) < 125.0 and item_collected:
		if not box_inspected:
			box_inspected = true
			GameState.set_flag("box_marked", true)
			set_objective("Marque a caixa com o cabo-guia e volte à abertura.")
			show_message("A prata devolve o som oco. A inscrição parece dizer INFERNO... não: INVERNO.", 4.2)
		else:
			show_message("INVERNO. A palavra está gravada entre símbolos e correntes.", 2.5)
		return
	if box_inspected and diver.position.x < 190.0:
		show_message("O cabo-guia ficou preso à caixa. A madeira range como um animal ferido.", 3.0)
		await get_tree().create_timer(1.1).timeout
		GameState.change_phase("res://scenes/acto1/cutscene_1_5.tscn")

func _build_lantern() -> void:
	var darkness := CanvasModulate.new()
	darkness.color = Color("#101c24")
	add_child(darkness)
	lantern_light = PointLight2D.new()
	lantern_light.texture = load("res://assets/generated/lantern.png")
	lantern_light.energy = 1.2
	lantern_light.position = diver.position
	add_child(lantern_light)
	lantern_cone = Sprite2D.new()
	lantern_cone.texture = load("res://assets/generated/lantern.png")
	lantern_cone.modulate = Color(0.76, 0.94, 0.92, 0.3)
	lantern_cone.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	lantern_cone.z_index = -1
	lantern_cone.position = diver.position + last_direction * 74.0
	add_child(lantern_cone)
