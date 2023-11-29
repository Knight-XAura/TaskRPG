extends VBoxContainer


@onready var task_view: ScrollContainer = $View as ScrollContainer

var current_tab_eid: TASK_NAVIGATION_TABS
var current_tab: Control

# Maybe an array or even a dictionary here?
var previously_open_tab_scene: PackedScene
var previously_open_tab: Control

const TASK_NAVIGATION_SCENES: Array[PackedScene] = [
	preload("res://menu/tasks/habit/habit.tscn"),
	preload("res://menu/tasks/daily/daily.tscn"),
	preload("res://menu/tasks/todo/todo.tscn")
]

enum TASK_NAVIGATION_TABS {
	HABITS = 0,
	DAILIES = 1,
	TODOS = 2
}

func _init() -> void:
	pass # Need code to pull last saved tab


func _ready() -> void:
	if previously_open_tab != null:
		previously_open_tab = previously_open_tab_scene.instantiate()
		task_view.add_child(previously_open_tab, true) # Need to assign tabs eid to current_tab_eid
		current_tab = previously_open_tab

# Might be able to emit signals to improve this and the _ready function
func _on_task_navigation_bar_pressed(new_tab_eid: int) -> void:
	if current_tab_eid != new_tab_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show = TASK_NAVIGATION_SCENES[new_tab_eid].instantiate() as Control
		task_view.add_child(tab_to_show, true)
		current_tab = tab_to_show
		current_tab_eid = new_tab_eid as TASK_NAVIGATION_TABS
		if previously_open_tab != null:
			tab_to_hide.hide()
			tab_to_hide.queue_free()


func _exit_tree() -> void:
	pass # Save previously open tab to file or even keep in ram somewhere else and save later
