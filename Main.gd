extends VBoxContainer


@onready var view: Control = $View as Control
@onready var world: SubViewportContainer = $View/SVPContainer as SubViewportContainer
@onready var current_tab: Control = world

var current_tab_eid: MAIN_NAVIGATION_TABS = MAIN_NAVIGATION_TABS.WORLD

const MAIN_NAVIGATION_SCENES: Array[PackedScene] = [
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


func _on_main_navigation_bar_pressed(new_tab_eid: int) -> void:
	if current_tab_eid != new_tab_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show = MAIN_NAVIGATION_SCENES[new_tab_eid].instantiate() as Control \
				if MAIN_NAVIGATION_SCENES[new_tab_eid] != null \
				else world
		if tab_to_show != world:
			view.add_child(tab_to_show, true)
		current_tab = tab_to_show
		current_tab_eid = new_tab_eid as MAIN_NAVIGATION_TABS
		if current_tab_eid == MAIN_NAVIGATION_TABS.WORLD:
			current_tab.show()
		tab_to_hide.hide()
		if tab_to_hide != world:
			tab_to_hide.queue_free()


func _exit_tree() -> void:
	pass # Save data to file
