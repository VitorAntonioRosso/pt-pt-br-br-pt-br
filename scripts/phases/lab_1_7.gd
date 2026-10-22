extends BasePhase

## Fase 1.7: laboratório 3/4. A lâmina da serra é um Area2D real e dispara o corte.

var eliana: Area2D
var cleaned := false
var inscriptions_read: Array[String] = []
var saw_ready := false
var saw_triggered := false
var inscription_positions := {
	"Lobo": Vector2(370, 232),
	"Tempestade": Vector2(500, 232),
	"Inverno": Vector2(630, 232),
	"Gentil": Vector2(760, 232),
	"Espelho": Vector2(890, 232),
	"Acordador": Vector2(500, 390),
	"Sétimo": Vector2(760, 390),
}
var clean_position := Vector2(255, 475)
var saw_position := Vector2(1000, 430)
var box_position := Vector2(650, 300)

func _ready() -> void:
	super._ready()
	add_background("res://assets/generated/lab_map.png")
	set_objective("Limpe a caixa de prata para revelar as inscrições.")
	set_hint("WASD/setas: mover  •  E/Enter: interagir  •  Esc: pausa")
	show_message("Galpão da USPA. Cinco aquecedores foram espalhados, mas o frio vem do nada.", 4.5)
	_build_eliana_area()
	_build_saw_area()

func _build_eliana_area() -> void:
	eliana = Area2D.new()
	eliana.name = "Eliana"
	eliana.position = Vector2(180, 455)
	eliana.collision_layer = 1
	eliana.collision_mask = 2
	var shape := CollisionShape2D.new()
	var circle := CircleShape2D.new()
	circle.radius = 18.0
	shape.shape = circle
	eliana.add_child(shape)
	add_child(eliana)
	var sprite := Sprite2D.new()
	sprite.texture = load("res://assets/generated/eliana.png")
	sprite.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	eliana.add_child(sprite)

func _build_saw_area() -> void:
	var saw_area := Area2D.new()
	saw_area.name = "SawBladeTrigger_Area2D"
	saw_area.position = saw_position
	saw_area.collision_layer = 2
	saw_area.collision_mask = 1
	var shape := CollisionShape2D.new()
	var rectangle := RectangleShape2D.new()
	rectangle.size = Vector2(92, 90)
	shape.shape = rectangle
	saw_area.add_child(shape)
	saw_area.area_entered.connect(_on_saw_area_entered)
	add_child(saw_area)

func _process(delta: float) -> void:
	if pause_visible or saw_triggered:
		return
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	eliana.position += direction * 155.0 * delta
	eliana.position.x = clampf(eliana.position.x, 100.0, 1060.0)
	eliana.position.y = clampf(eliana.position.y, 145.0, 560.0)
	if Input.is_action_just_pressed("interact"):
		_interact()
	queue_redraw()

func _interact() -> void:
	if eliana.position.distance_to(clean_position) < 95.0 and not cleaned:
		cleaned = true
		GameState.set_flag("lab_cleaned", true)
		set_objective("Leia as 7 inscrições da caixa.")
		show_message("Mangueira, escova e sal. A prata devolve sete nomes ao galpão.", 3.2)
		return
	if cleaned:
		for name in inscription_positions:
			if eliana.position.distance_to(inscription_positions[name]) < 72.0 and not inscriptions_read.has(name):
				inscriptions_read.append(name)
				GameState.set_flag("inscriptions", inscriptions_read)
				show_message("Inscrição revelada: %s (%d/7)." % [name, inscriptions_read.size()], 2.0)
				if inscriptions_read.size() == 7:
					saw_ready = true
					set_objective("Aproxime-se da serra autorizada para abrir a caixa.")
				return
		if eliana.position.distance_to(box_position) < 110.0:
			show_message("A caixa é de prata. No topo, um sol de raios curvos; embaixo, um aviso para não abrir.", 3.5)
			return
	if eliana.position.distance_to(saw_position) < 120.0 and not saw_ready:
		show_message("Delvechio pede que a caixa seja documentada antes da abertura.", 2.5)

func _on_saw_area_entered(area: Area2D) -> void:
	if area != eliana or saw_triggered:
		return
	if not saw_ready:
		show_message("A serra está isolada. Ainda faltam inscrições para registrar.", 2.2)
		return
	saw_triggered = true
	GameState.set_flag("cut_triggered", true)
	show_message("A multidão empurra Eliana contra a lâmina.", 1.6)
	await get_tree().create_timer(1.4).timeout
	GameState.change_phase("res://scenes/acto1/cutscene_1_8.tscn")

func _draw() -> void:
	if cleaned:
		for name in inscription_positions:
			var color := Color("#f0bb72") if inscriptions_read.has(name) else Color("#78d9df")
			draw_circle(inscription_positions[name], 10.0, Color(color, 0.2))
			draw_arc(inscription_positions[name], 16.0, 0.0, TAU, 18, color, 2.0)
	draw_arc(clean_position, 22.0, 0.0, TAU, 20, Color("#78d9df"), 2.0)
	draw_arc(saw_position, 24.0, 0.0, TAU, 20, Color("#ee7670"), 2.0)
