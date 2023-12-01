extends Control


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if FileAccess.open("user://user_main.scn", FileAccess.READ) != null:
		get_tree().change_scene_to_packed(load("user://user_main.scn"))
		return
	get_tree().change_scene_to_packed(load("res://main.tscn"))
