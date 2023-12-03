extends VBoxContainer


@onready var task_view: ScrollContainer = $View as ScrollContainer

var current_tab: Control
var current_tab_eid: TASK_NAVIGATION_TABS = TASK_NAVIGATION_TABS.HABITS
var task_views: Array[VBoxContainer] = []

enum TASK_NAVIGATION_TABS {
	HABITS = 0,
	DAILIES = 1,
	TODOS = 2
}


func _ready() -> void:
	if visible:
		visible = false


func _on_task_navigation_bar_pressed(tab_to_show_eid: int) -> void:
	if current_tab_eid != tab_to_show_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show: VBoxContainer = task_views[tab_to_show_eid]
		tab_to_show.show()
		current_tab = tab_to_show
		current_tab_eid = tab_to_show_eid as TASK_NAVIGATION_TABS
		tab_to_hide.hide()


func _on_view_container_child_entered_tree(child_task: VBoxContainer) -> void:
	if task_views.is_empty():
		current_tab = child_task
	task_views.append(child_task)
