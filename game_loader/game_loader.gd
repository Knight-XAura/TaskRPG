extends Control


# I will need to consider in the future how this method will work with updates to scenes as they won't load them.
# This likely won't work at release time. 


var loaded_scene_counter: int = 0
var loading_node_parent: Node
var game_loader_data: Dictionary = {
	0: {
		"Loaded": false,
		"User Folder Path": null,
		"Parent Node Path": "/root",
		"Scene": "res://main.tscn",
		"Game Load Complete": false
	},
	1: {
		"Loaded": false,
		"User Save Path": "user://save/game/game.scn",
		"Parent Node Path": "/root/Main/HUD",
		"Scene": "res://game/game.tscn",
		"Game Load Complete": false
	},
	2: {
		"Loaded": false,
		"User Save Path": "user://save/world/world.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer/SVPContainer/SubViewport",
		"Scene": "res://world/world.tscn",
		"Game Load Complete": false
	},
	3: {
		"Loaded": false,
		"User Save Path": "user://save/player/player.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer/SVPContainer/SubViewport/World",
		"Scene": "res://player/player.tscn",
		"Game Load Complete": false
	},
	4: {
		"Loaded": false,
		"User Save Path": "user://save/menu/tasks/tasks.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer",
		"Scene": "res://menu/tasks/tasks.tscn",
		"Game Load Complete": false
	},
	5: {
		"Loaded": false,
		"User Save Path": "user://save/menu/tasks/habits/habits.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer/Tasks/ViewContainer",
		"Scene": "res://menu/tasks/habits/habits.tscn",
		"Game Load Complete": false
	},
	6: {
		"Loaded": false,
		"User Save Path": "user://save/menu/tasks/dailies/dailies.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer/Tasks/ViewContainer",
		"Scene": "res://menu/tasks/dailies/dailies.tscn",
		"Game Load Complete": false
	},
	7: {
		"Loaded": false,
		"User Save Path": "user://save/menu/tasks/todos/todos.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer/Tasks/ViewContainer",
		"Scene": "res://menu/tasks/todos/todos.tscn",
		"Game Load Complete": false
	},
	8: {
		"Loaded": false,
		"User Save Path": "user://save/menu/stats/stats.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer",
		"Scene": "res://menu/stats/stats.tscn",
		"Game Load Complete": false
	},
	9: {
		"Loaded": false,
		"User Save Path": "user://save/menu/quests/quest.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer",
		"Scene": "res://menu/quests/quests.tscn",
		"Game Load Complete": false
	},
	10: {
		"Loaded": false,
		"User Save Path": "user://save/menu/inventory/inventory.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer",
		"Scene": "res://menu/inventory/inventory.tscn",
		"Game Load Complete": false
	},
	11: {
		"Loaded": false,
		"User Save Path": "user://save/menu/settings/settings.scn",
		"Parent Node Path": "/root/Main/HUD/Game/ViewContainer",
		"Scene": "res://menu/settings/settings.tscn",
		"Game Load Complete": true
	}
}
var loader_enteries = game_loader_data.size()


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if loaded_scene_counter < loader_enteries:
		if loaded_scene_counter > 0 and FileAccess.file_exists(game_loader_data[loaded_scene_counter]["User Save Path"]) == true:
			loading_node_parent = get_node(game_loader_data[loaded_scene_counter]["Parent Node Path"])
			loading_node_parent.add_child(load(game_loader_data[loaded_scene_counter]["User Save Path"]).instantiate())
			game_loader_data[loaded_scene_counter]["Loaded"] = true
			loaded_scene_counter += 1
			return
		loading_node_parent = get_node(game_loader_data[loaded_scene_counter]["Parent Node Path"])
		loading_node_parent.add_child(load(game_loader_data[loaded_scene_counter]["Scene"]).instantiate())
		game_loader_data[loaded_scene_counter]["Loaded"] = true
		loaded_scene_counter += 1
		return
	queue_free()
	get_parent().get_node("Main/HUD").show()
		
