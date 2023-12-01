extends VBoxContainer


@onready var task_view: ScrollContainer = $View as ScrollContainer
@onready var task_views: Array[VBoxContainer] = [
	$View/ViewContainer/Habits,
	$View/ViewContainer/Dailies,
	$View/ViewContainer/Todos
]
@onready var current_tab: Control = task_views[TASK_NAVIGATION_TABS.HABITS] as Control
# To load the previous instances screen that was showing I may need to find a way to make these both dynamic at load time
var current_tab_eid: TASK_NAVIGATION_TABS = TASK_NAVIGATION_TABS.HABITS

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
	pass


func _ready() -> void:
	pass


func _on_task_navigation_bar_pressed(tab_to_show_eid: int) -> void:
	if current_tab_eid != tab_to_show_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show: VBoxContainer = task_views[tab_to_show_eid]
		tab_to_show.show()
		current_tab = tab_to_show
		current_tab_eid = tab_to_show_eid as TASK_NAVIGATION_TABS
		#if tab_to_hide != null:
		tab_to_hide.hide()


func _exit_tree() -> void:
	pass
	
# Want to find a way to determine if scene actually changes in any way, because if not why are we running this?
func pack_user_tasks_scene() -> void:
	get_children_recursively(self)
	var user_tasks_packed_scene: PackedScene = PackedScene.new()
	user_tasks_packed_scene.pack(self)
	if DirAccess.open("user://user_tasks") == null:
		DirAccess.make_dir_absolute("user://user_tasks")
	ResourceSaver.save(user_tasks_packed_scene, "user://user_tasks/user_tasks.scn")


func get_children_recursively(parent: Node) -> void:
	for node in parent.get_children():
		get_children_recursively(node)
		node.owner = self
