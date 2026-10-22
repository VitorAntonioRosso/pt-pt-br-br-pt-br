extends SceneTree

## Smoke test sem interface: carrega e instancia todas as cenas do Ato 1.
## Ele não substitui jogar a sequência, mas captura recursos ausentes e erros de _ready.

const SCENES := [
	"res://scenes/boot.tscn",
	"res://scenes/acto1/cutscene_1_1.tscn",
	"res://scenes/acto1/boat_1_2.tscn",
	"res://scenes/acto1/dive_1_3.tscn",
	"res://scenes/acto1/dive_1_4.tscn",
	"res://scenes/acto1/cutscene_1_5.tscn",
	"res://scenes/acto1/cutscene_1_6.tscn",
	"res://scenes/acto1/lab_1_7.tscn",
	"res://scenes/acto1/cutscene_1_8.tscn",
	"res://scenes/acto1/cutscene_1_9.tscn",
	"res://scenes/acto1/end_card.tscn",
]

func _init() -> void:
	call_deferred("_run")

func _run() -> void:
	var failures: Array[String] = []
	for scene_path in SCENES:
		var packed = load(scene_path)
		if packed == null:
			failures.append("recurso ausente: %s" % scene_path)
			continue
		var instance = packed.instantiate()
		if instance == null:
			failures.append("não instanciou: %s" % scene_path)
			continue
		root.add_child(instance)
		await process_frame
		instance.queue_free()
		await process_frame
	if failures.is_empty():
		print("SMOKE PASS: %d cenas do Ato 1 carregadas e instanciadas." % SCENES.size())
		quit(0)
	else:
		for failure in failures:
			push_error(failure)
		quit(1)
