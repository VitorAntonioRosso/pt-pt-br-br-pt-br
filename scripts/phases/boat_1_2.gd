extends BasePhase

## Fase 1.2: lancha em vista de cima. O objetivo é chegar à boia e lançar a âncora.

var boat: Sprite2D
var anchor_point := Vector2(936, 420)
var anchored := false
var speed := 190.0

func _ready() -> void:
	super._ready()
	add_background("res://assets/generated/boat_map.png")
	boat = add_actor("res://assets/generated/boat.png", Vector2(240, 370), Vector2(1.45, 1.45))
	set_objective("Leve a lancha até o ponto de mergulho.")
	set_hint("WASD/setas: conduzir  •  E/Enter: lançar a âncora  •  Esc: pausa")
	show_message("Dois quilômetros de mar calmo. O ponto da fenda está marcado pela boia.", 5.0)

func _process(delta: float) -> void:
	if pause_visible:
		return
	if not anchored:
		var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
		boat.position += direction * speed * delta
		boat.position.x = clampf(boat.position.x, 110.0, 1040.0)
		boat.position.y = clampf(boat.position.y, 140.0, 560.0)
		if boat.position.distance_to(anchor_point) < 88.0:
			anchored = true
			GameState.set_flag("boat_anchored", true)
			set_objective("A lancha está no ponto. Lance a âncora.")
			show_message("A fenda está logo abaixo. O mar parece calmo demais.", 3.0)
	else:
		if Input.is_action_just_pressed("interact"):
			show_message("Âncora lançada. Tiago, César e Olavo descem juntos.", 2.8)
			await get_tree().create_timer(1.2).timeout
			GameState.change_phase("res://scenes/acto1/dive_1_3.tscn")

func _draw() -> void:
	if not anchored:
		draw_circle(anchor_point, 28.0, Color(0.35, 0.86, 0.88, 0.14))
		draw_arc(anchor_point, 32.0, 0.0, TAU, 32, Color("#78d9df"), 2.0)
		draw_line(anchor_point + Vector2(-12, -12), anchor_point + Vector2(12, 12), Color("#78d9df"), 2.0)
