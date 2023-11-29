extends VBoxContainer


@onready var view_scroll_container: ScrollContainer = $ViewScrollContainer

const TASK_SCENES: Array[PackedScene] = [
	preload("res://menu/tasks/habit/habit.tscn"),
	preload("res://menu/tasks/daily/daily.tscn"),
	preload("res://menu/tasks/todo/todo.tscn")
]

enum TASK_TABS {
	HABITS = 0,
	DAILIES = 1,
	TODOS = 2
}

var current_tab_eid: TASK_TABS
var current_tab: Control


func _on_task_bar_tab_pressed(new_tab_eid: int) -> void:
	pass
