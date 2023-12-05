extends Node


# I will need to consider in the future how this method will work with updates to scenes as they won't load them.
# This likely won't work at release time. 


var saving_node: Node
var game_saver_data: Dictionary = {
	0: {
		"Saved": false,
		"User Folder Path": "user://save/menu/settings/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Settings",
		"Scene": "user://save/menu/settings/settings.scn",
		"Game Save Complete": false
	},
	1: {
		"Saved": false,
		"User Folder Path": "user://save/menu/inventory/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Inventory",
		"Scene": "user://save/menu/inventory/inventory.scn",
		"Game Save Complete": false
	},
	2: {
		"Saved": false,
		"User Folder Path": "user://save/menu/quests/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Quests",
		"Scene": "user://save/menu/quests/quests.scn",
		"Game Save Complete": false
	},
	3: {
		"Saved": false,
		"User Folder Path": "user://save/menu/stats/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Stats",
		"Scene": "user://save/menu/stats/stats.scn",
		"Game Save Complete": false
	},
	4: {
		"Saved": false,
		"User Folder Path": "user://save/menu/tasks/todos/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Tasks/ViewContainer/Todos",
		"Scene": "user://save/menu/tasks/todos/todos.scn",
		"Game Save Complete": false
	},
	5: {
		"Saved": false,
		"User Folder Path": "user://save/menu/tasks/dailies/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Tasks/ViewContainer/Dailies",
		"Scene": "user://save/menu/tasks/dailies/dailies.scn",
		"Game Save Complete": false
	},
	6: {
		"Saved": false,
		"User Folder Path": "user://save/menu/tasks/habits/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Tasks/ViewContainer/Habits",
		"Scene": "user://save/menu/tasks/habits/habits.scn",
		"Game Save Complete": false
	},
	7: {
		"Saved": false,
		"User Folder Path": "user://save/menu/tasks/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/Tasks",
		"Scene": "user://save/menu/tasks/tasks.scn",
		"Game Save Complete": false
	},
	8: {
		"Saved": false,
		"User Folder Path": "user://save/player/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/SVPContainer/SubViewport/World/Player",
		"Scene": "user://save/player/player.scn",
		"Game Save Complete": false
	},
	9: {
		"Saved": false,
		"User Folder Path": "user://save/world/",
		"Node Path": "/root/Main/HUD/Game/ViewContainer/SVPContainer/SubViewport/World",
		"Scene": "user://save/world/world.scn",
		"Game Save Complete": false
	},
	10: {
		"Saved": false,
		"User Folder Path": "user://save/game/",
		"Node Path": "/root/Main/HUD/Game",
		"Scene": "user://save/game/game.scn",
		"Game Save Complete": true
	},
}


func _ready() -> void:
	for saved_scene_counter in game_saver_data.size():
		if FileAccess.file_exists(game_saver_data[saved_scene_counter]["User Folder Path"]) == false:
			DirAccess.make_dir_recursive_absolute(game_saver_data[saved_scene_counter]["User Folder Path"])
		saving_node = get_node(game_saver_data[saved_scene_counter]["Node Path"])
		get_children_recursively(saving_node)
		var user_packed_scene: PackedScene = PackedScene.new()
		user_packed_scene.pack(saving_node)
		ResourceSaver.save(user_packed_scene, game_saver_data[saved_scene_counter]["Scene"])
		game_saver_data[saved_scene_counter]["Saved"] = true
		saving_node.queue_free()
		await saving_node.tree_exited


func get_children_recursively(parent: Node) -> void:
	for node in parent.get_children():
		get_children_recursively(node)
		node.owner = saving_node
