extends Control


var game: Node
var game_loaded_scene_counter: int = 0

var loading_node_parent: Node

var game_loader_data: Dictionary = {
	0: {
		"Loaded": false,
		"User Folder Path": null,
		"Parent Node Path": null,
		"Scene": "res://main.tscn",
		"Game Load Complete": false
	},
	1: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": ".",
		"Scene": "res://game/game.tscn",
		"Game Load Complete": false
	},
	2: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View/SVPContainer/SubViewport",
		"Scene": "res://menu/world/world.tscn",
		"Game Load Complete": false
	},
	3: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View/SVPContainer/SubViewport/World",
		"Scene": "res://player/player.tscn",
		"Game Load Complete": false
	},
	4: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View",
		"Scene": "res://menu/tasks/tasks.tscn",
		"Game Load Complete": false
	},
	5: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View/Tasks/View/ViewContainer",
		"Scene": "res://menu/tasks/habit/habit.tscn",
		"Game Load Complete": false
	},
	6: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View/Tasks/View/ViewContainer",
		"Scene": "res://menu/tasks/daily/daily.tscn",
		"Game Load Complete": false
	},
	7: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View/Tasks/View/ViewContainer",
		"Scene": "res://menu/tasks/todo/todo.tscn",
		"Game Load Complete": false
	},
	8: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View",
		"Scene": "res://menu/stats/stats.tscn",
		"Game Load Complete": false
	},
	9: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View",
		"Scene": "res://menu/quests/quests.tscn",
		"Game Load Complete": false
	},
	10: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View",
		"Scene": "res://menu/inventory/inventory.tscn",
		"Game Load Complete": false
	},
	11: {
		"Loaded": false,
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Game/View",
		"Scene": "res://menu/settings/settings.tscn",
		"Game Load Complete": true
	}
}


func _ready() -> void:
	await get_parent().ready
	add_sibling(load(game_loader_data[game_loaded_scene_counter]["Scene"]).instantiate())
	game_loader_data[game_loaded_scene_counter]["Loaded"] = true
	game = get_parent().get_node("Main/HUD")


func _process(delta: float) -> void:
	if game_loader_data[game_loaded_scene_counter]["Game Load Complete"] == false:
		game_loaded_scene_counter += 1
		loading_node_parent = game.get_node(game_loader_data[game_loaded_scene_counter]["Parent Node Path"])
		loading_node_parent.add_child(load(game_loader_data[game_loaded_scene_counter]["Scene"]).instantiate())
		game_loader_data[game_loaded_scene_counter]["Loaded"] = true
		return
	queue_free()
	get_parent().get_node("Main/HUD").show()
