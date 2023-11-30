extends VBoxContainer

signal user_tasks_updated

@onready var task_view: ScrollContainer = $View as ScrollContainer

var current_tab_eid: TASK_NAVIGATION_TABS
var current_tab: Control

# Maybe an array or even a dictionary here?
var previously_open_tab_scene: PackedScene
var previously_open_tab: Control

const TASK_SCENES: Array[PackedScene] = [
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

# Below this point needs reconstructing
# Also need to figure out tasks for inheritance scenes vs scene containing users tasks
func _ready() -> void:
	if previously_open_tab != null:
		current_tab = previously_open_tab # Need to finish completing this

# Might be able to emit signals to improve this and the _ready function
func _on_task_navigation_bar_pressed(new_tab_eid: int) -> void:
	if current_tab_eid != new_tab_eid:
		var tab_to_hide: Control = current_tab
		#current_tab = tab_to_show
		current_tab_eid = new_tab_eid as TASK_NAVIGATION_TABS
		if previously_open_tab != null: # Same as tab_to_hide node check
			tab_to_hide.hide()


func _exit_tree() -> void:
	get_children_recursively(self)
	var user_tasks_scene: PackedScene = PackedScene.new()
	user_tasks_scene.pack(self)
	ResourceSaver.save(user_tasks_scene, "user://user_tasks.scn")
	user_tasks_updated.emit()


func get_children_recursively(parent: Node) -> void:
	for node in parent.get_children():
		get_children_recursively(node)
		node.owner = self
