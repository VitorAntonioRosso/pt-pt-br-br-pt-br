extends Node

## Estado global do Ato 1.
##
## Este autoload é pequeno de propósito: guarda somente progresso, flags narrativas
## e a troca de cenas. O save usa JSON em user:// e nunca grava dados no repositório.

const SAVE_PATH := "user://os_sete_ato1_save.json"
const FIRST_SCENE := "res://scenes/acto1/cutscene_1_1.tscn"

var current_phase := ""
var flags: Dictionary = {}
var settings := {
	"reduced_motion": false,
	"subtitles": true,
}

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func start_new_game() -> void:
	flags = {
		"photographs": 0,
		"boat_anchored": false,
		"dive_item": false,
		"box_marked": false,
		"box_inspected": false,
		"lab_cleaned": false,
		"inscriptions": [],
		"cut_triggered": false,
	}
	change_phase(FIRST_SCENE)

func change_phase(scene_path: String) -> void:
	current_phase = scene_path
	save_progress()
	get_tree().change_scene_to_file(scene_path)

func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

func continue_game() -> void:
	if not has_save():
		start_new_game()
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		start_new_game()
		return
	var parsed = JSON.parse_string(file.get_as_text())
	if not parsed is Dictionary or not parsed.has("phase"):
		start_new_game()
		return
	current_phase = str(parsed.get("phase", FIRST_SCENE))
	flags = parsed.get("flags", {})
	settings = parsed.get("settings", settings)
	if not ResourceLoader.exists(current_phase):
		start_new_game()
		return
	get_tree().change_scene_to_file(current_phase)

func save_progress() -> void:
	if current_phase.is_empty():
		return
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify({
		"schema": 1,
		"phase": current_phase,
		"flags": flags,
		"settings": settings,
	}))

func set_flag(key: String, value) -> void:
	flags[key] = value
	save_progress()

func get_flag(key: String, fallback = null):
	return flags.get(key, fallback)

func return_to_menu() -> void:
	get_tree().change_scene_to_file("res://scenes/boot.tscn")
