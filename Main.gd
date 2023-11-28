extends VBoxContainer

@onready var svp_container: SubViewportContainer = $SVPContainer

var tasks_scene: PackedScene = preload("res://menu/tasks/tasks.tscn")

@onready var current_tab: Control = svp_container

func _on_tasks_pressed() -> void:
	var tasks: VBoxContainer = tasks_scene.instantiate()
	add_child(tasks, true) #Need to make this move or be added to the top above or below SVPContainer
	current_tab.hide()
	current_tab = tasks
	
