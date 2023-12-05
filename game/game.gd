extends VBoxContainer


@onready var world: SubViewportContainer = $ViewContainer/SVPContainer as SubViewportContainer
@onready var current_tab: Control = world

var current_tab_eid: MAIN_NAVIGATION_TABS = MAIN_NAVIGATION_TABS.WORLD
var main_navigation_views: Array[Control] = []

enum MAIN_NAVIGATION_TABS {
	WORLD = 0,
	TASKS = 1,
	STATS = 2,
	INVENTORY = 3,
	SETTINGS = 4
}


func _ready() -> void:
	if world.visible == false:
		world.visible = true


func _on_main_navigation_bar_pressed(tab_to_show_eid: int) -> void:
	if current_tab_eid != tab_to_show_eid:
		var tab_to_hide: Control = current_tab
		var tab_to_show = main_navigation_views[tab_to_show_eid]
		tab_to_show.show()
		current_tab = tab_to_show
		current_tab_eid = tab_to_show_eid as MAIN_NAVIGATION_TABS
		tab_to_hide.hide()


func _on_view_child_entered_tree(child_view: Node) -> void:
	main_navigation_views.append(child_view)
