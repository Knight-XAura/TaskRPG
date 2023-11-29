extends VBoxContainer


@onready var view: Control = $View
@onready var world: SubViewportContainer = $View/SVPContainer

var tab_scenes: Array[PackedScene] = [null, preload("res://menu/tasks/tasks.tscn"), null]

enum MENU_TABS {
	WORLD = 0,
	TASKS = 1
}

var current_tab_eid: MENU_TABS = MENU_TABS.WORLD

@onready var current_tab: Control = world


func _on_menu_pressed(new_tab_eid: int) -> void:
	if current_tab_eid != new_tab_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show = tab_scenes[new_tab_eid].instantiate() as Control if tab_scenes[new_tab_eid] else world
		if tab_to_show != world:
			view.add_child(tab_to_show, true)
		current_tab = tab_to_show
		current_tab_eid = new_tab_eid
		if current_tab_eid == MENU_TABS.WORLD:
			current_tab.show()
		tab_to_hide.hide()
		if tab_to_hide != world:
			tab_to_hide.queue_free()
