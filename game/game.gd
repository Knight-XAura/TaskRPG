extends VBoxContainer
# would need to rewrite some code of coruse for the navigation bar pressed function
# this would also require editing of the pack function

@onready var view: Control = $View as Control
@onready var world: SubViewportContainer = $View/SVPContainer as SubViewportContainer
@onready var current_tab: Control = world

var current_tab_eid: MAIN_NAVIGATION_TABS = MAIN_NAVIGATION_TABS.WORLD
var main_navigation_views: Array[PackedScene] = []

enum MAIN_NAVIGATION_TABS {
	WORLD = 0,
	TASKS = 1,
	STATS = 2,
	INVENTORY = 3,
	SETTINGS = 4
}


func _ready() -> void:
	if not world.visible:
		world.visible = true

# Signals disappeared on me again
func _on_main_navigation_bar_pressed(tab_to_show_eid: int) -> void:
	if current_tab_eid != tab_to_show_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show = main_navigation_views[tab_to_show_eid]
		current_tab = tab_to_show
		current_tab_eid = tab_to_show_eid as MAIN_NAVIGATION_TABS
		tab_to_show.show()
		tab_to_hide.hide()


func _exit_tree() -> void:
	pass # Save data to file
