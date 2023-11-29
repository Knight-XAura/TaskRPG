extends VBoxContainer


@onready var view: Control = $View
@onready var world: SubViewportContainer = $View/SVPContainer

const TAB_SCENES: Array[PackedScene] = [
	null,
	preload("res://menu/tasks/tasks.tscn"),
	preload("res://menu/stats/stats.tscn"),
	preload("res://menu/inventory/inventory.tscn"),
	preload("res://menu/settings/settings.tscn")
]

enum MENU_TABS {
	WORLD = 0,
	TASKS = 1,
	STATS = 2,
	INVENTORY = 3,
	SETTINGS = 4
}

var current_tab_eid: MENU_TABS = MENU_TABS.WORLD

@onready var current_tab: Control = world


func _on_navigation_bar_tab_pressed(new_tab_eid: int) -> void:
	if current_tab_eid != new_tab_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show = TAB_SCENES[new_tab_eid].instantiate() as Control if TAB_SCENES[new_tab_eid] else world
		if tab_to_show != world:
			view.add_child(tab_to_show, true)
		current_tab = tab_to_show
		current_tab_eid = new_tab_eid
		if current_tab_eid == MENU_TABS.WORLD:
			current_tab.show()
		tab_to_hide.hide()
		if tab_to_hide != world:
			tab_to_hide.queue_free()
