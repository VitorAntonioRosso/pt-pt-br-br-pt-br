extends BasePhase

## Fase 1.3: mergulho lateral. Sem combate; o risco é oxigênio, corrente e ruína.

var diver: Sprite2D
var lantern_light: PointLight2D
var lantern_cone: Sprite2D
var last_direction := Vector2.RIGHT
var oxygen := 100.0
var oxygen_seconds := 120.0
var photo_points := [
	{"position": Vector2(320, 270), "label": "casco sem arranhões", "done": false},
	{"position": Vector2(594, 230), "label": "escotilhas lacradas", "done": false},
	{"position": Vector2(815, 390), "label": "portinhola de canhão", "done": false},
]
var entry_position := Vector2(1030, 450)
var speed := 150.0
var current_push := Vector2.ZERO

func _ready() -> void:
	super._ready()
	add_background("res://assets/generated/dive_exterior.png")
	diver = add_actor("res://assets/generated/tiago_dive.png", Vector2(135, 465), Vector2(1.15, 1.15))
	_build_lantern()
	add_oxygen_hud()
	set_objective("Fotografe os 3 pontos estranhos da caravela.")
	set_hint("WASD/setas: nadar  •  E/Enter: fotografar ou entrar  •  Esc: pausa")
	show_message("A âncora marca a descida. A caravela está encaixada na fenda, 45 metros abaixo.", 5.0)

func _process(delta: float) -> void:
	if pause_visible:
		return
	oxygen -= (100.0 / oxygen_seconds) * delta
	set_oxygen(oxygen, oxygen * oxygen_seconds / 100.0)
	if oxygen <= 0.0:
		show_message("O ar acabou. Você retorna ao último ponto seguro.", 3.0)
		oxygen = 100.0
		diver.position = Vector2(135, 465)
		return
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length() > 0.0:
		last_direction = direction.normalized()
		diver.position += (direction.normalized() * speed + current_push) * delta
		diver.position.x = clampf(diver.position.x, 80.0, 1080.0)
		diver.position.y = clampf(diver.position.y, 145.0, 575.0)
	current_push = Vector2.ZERO
	lantern_light.position = diver.position
	lantern_cone.position = diver.position + last_direction * 74.0
	lantern_cone.rotation = last_direction.angle()
	if diver.position.x > 500.0 and diver.position.x < 680.0 and diver.position.y > 170.0 and diver.position.y < 360.0:
		current_push = Vector2(-60.0, 22.0)
		show_message("A corrente bate no paredão. Controle o tanque para não raspar na rocha.", 1.2)
	if Input.is_action_just_pressed("interact"):
		_interact()
	queue_redraw()

func _interact() -> void:
	for point in photo_points:
		if not point["done"] and diver.position.distance_to(point["position"]) < 92.0:
			point["done"] = true
			var count := _photos_done()
			GameState.set_flag("photographs", count)
			show_message("Fotografia registrada: %s (%d/3)." % [point["label"], count], 2.0)
			if count == 3:
				set_objective("Encontre uma entrada no lado esquerdo do casco.")
			return
	if _photos_done() == 3 and diver.position.distance_to(entry_position) < 105.0:
		GameState.set_flag("box_marked", false)
		show_message("A abertura está entre o paredão e o casco. Suba pelo buraco estreito.", 3.0)
		await get_tree().create_timer(1.0).timeout
		GameState.change_phase("res://scenes/acto1/dive_1_4.tscn")

func _photos_done() -> int:
	var total := 0
	for point in photo_points:
		if point["done"]:
			total += 1
	return total

func _build_lantern() -> void:
	var darkness := CanvasModulate.new()
	darkness.color = Color("#173342")
	add_child(darkness)
	lantern_light = PointLight2D.new()
	lantern_light.texture = load("res://assets/generated/lantern.png")
	lantern_light.energy = 1.15
	lantern_light.texture_scale = 1.0
	lantern_light.position = diver.position
	add_child(lantern_light)
	lantern_cone = Sprite2D.new()
	lantern_cone.texture = load("res://assets/generated/lantern.png")
	lantern_cone.modulate = Color(0.76, 0.94, 0.92, 0.28)
	lantern_cone.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	lantern_cone.z_index = -1
	lantern_cone.position = diver.position + last_direction * 74.0
	add_child(lantern_cone)

func _draw() -> void:
	for point in photo_points:
		var color := Color("#78d9df") if not point["done"] else Color("#f0bb72")
		draw_circle(point["position"], 12.0, Color(color, 0.22))
		draw_arc(point["position"], 18.0, 0.0, TAU, 20, color, 2.0)
	draw_arc(entry_position, 22.0, 0.0, TAU, 24, Color("#f0bb72"), 2.0)
