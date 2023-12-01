extends VBoxContainer
# Move scenes into folders and when app loads we should go through main_navigation_scenes
#We should see what needs to be updated from the default or even setup this or that in the _init
#This would require packing scenes to hapen from this node vs just is tasks which is slightly cleaner feeling
# would need to rewrite some code of coruse for the navigation bar pressed function
# this would also require editing of the pack function

@onready var view: Control = $View as Control
@onready var world: SubViewportContainer = $View/SVPContainer as SubViewportContainer
@onready var current_tab: Control = world

var current_tab_eid: MAIN_NAVIGATION_TABS = MAIN_NAVIGATION_TABS.WORLD
var main_navigation_scenes: Array[PackedScene] = [
	null,
	load("res://menu/tasks/tasks.tscn"),
	load("res://menu/stats/stats.tscn"),
	load("res://menu/inventory/inventory.tscn"),
	load("res://menu/settings/settings.tscn")
]

enum MAIN_NAVIGATION_TABS {
	WORLD = 0,
	TASKS = 1,
	STATS = 2,
	INVENTORY = 3,
	SETTINGS = 4
}


func _init() -> void:
	if FileAccess.open("user://user_tasks/user_tasks.scn", FileAccess.READ) != null:
		main_navigation_scenes[MAIN_NAVIGATION_TABS.TASKS] = load("user://user_tasks/user_tasks.scn")

# Signals disappeared on me again
func _on_main_navigation_bar_pressed(tab_to_show_eid: int) -> void:
	if current_tab_eid != tab_to_show_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show = main_navigation_scenes[tab_to_show_eid].instantiate() as Control \
			if main_navigation_scenes[tab_to_show_eid] != null \
			else world
		if tab_to_show != world:
			view.add_child(tab_to_show, true)
		current_tab = tab_to_show
		current_tab_eid = tab_to_show_eid as MAIN_NAVIGATION_TABS
		if current_tab_eid == MAIN_NAVIGATION_TABS.WORLD:
			current_tab.show()
		if current_tab_eid == MAIN_NAVIGATION_TABS.TASKS:
			current_tab.pack_user_tasks_scene()
			main_navigation_scenes[MAIN_NAVIGATION_TABS.TASKS] = load("user://user_tasks/user_tasks.scn")
		tab_to_hide.hide()
		if tab_to_hide != world:
			tab_to_hide.queue_free()


func _exit_tree() -> void:
	pass # Save data to file
