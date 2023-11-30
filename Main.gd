extends VBoxContainer


@onready var view: Control = $View as Control
@onready var world: SubViewportContainer = $View/SVPContainer as SubViewportContainer
@onready var current_tab: Control = world

var current_tab_eid: MAIN_NAVIGATION_TABS = MAIN_NAVIGATION_TABS.WORLD
# Need to fix this not able to use if statement to pull what set of data I want (making type Array fixes this, but isn't as strongly statically typed
var main_navigation_scenes: Array[PackedScene] = [
		null,
		load("user://user_tasks.scn"),
		preload("res://menu/stats/stats.tscn"),
		preload("res://menu/inventory/inventory.tscn"),
		preload("res://menu/settings/settings.tscn")
]	if FileAccess.open("user://user_tasks.scn", FileAccess.READ) != null \
	else [
		null,
		preload("res://menu/tasks/tasks.tscn"),
		preload("res://menu/stats/stats.tscn"),
		preload("res://menu/inventory/inventory.tscn"),
		preload("res://menu/settings/settings.tscn")
	]

enum MAIN_NAVIGATION_TABS {
	WORLD = 0,
	TASKS = 1,
	STATS = 2,
	INVENTORY = 3,
	SETTINGS = 4
}


func _init() -> void:
	pass # Need code to pull last saved data

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
		if current_tab_eid == MAIN_NAVIGATION_TABS.TASKS:
			current_tab.user_tasks_updated.connect("_on_user_tasks_updated")
		if current_tab_eid == MAIN_NAVIGATION_TABS.WORLD:
			current_tab.show()
		tab_to_hide.hide()
		if tab_to_hide != world:
			tab_to_hide.queue_free()


func _exit_tree() -> void:
	pass # Save data to file


func _on_user_tasks_updated() -> void:
	main_navigation_scenes[MAIN_NAVIGATION_TABS.TASKS] = load("user://user_tasks.scn")
	print("UPDATED")
