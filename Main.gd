extends VBoxContainer

@onready var svp_container: SubViewportContainer = $SVPContainer

var tasks_scene: PackedScene = preload("res://menu/tasks/tasks.tscn")

enum MENU_TABS {
	SVPCONTAINER = 0,
	TASKS = 1
}

var current_tab: int = MENU_TABS.SVPCONTAINER

@onready var cached_tab: Control = svp_container

func _on_tasks_pressed() -> void:
	if current_tab != MENU_TABS.TASKS:
		var tasks: VBoxContainer = tasks_scene.instantiate()
		add_child(tasks, true)
		move_child(tasks, 1)
		cached_tab.hide()
		cached_tab = tasks
		current_tab = MENU_TABS.TASKS
# This needs more work with the variables and see if we can remove move_child
