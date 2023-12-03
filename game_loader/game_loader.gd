extends Control


var main_exists: bool = false

var game_loader_counter: int = 0

var game_loader_data: Dictionary = {
	0: {
		"Resource Folder Path": null,
		"User Folder Path": null,
		"Parent Node Path": null,
		"Scene": "res://main.tscn"
	},
	1: {
		"Resource Folder Path": "Resource Folder Path",
		"User Folder Path": "User Folder Path",
		"Parent Node Path": "Parent Node Path",
		"Scene": "Scene"
	},
}


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if main_exists == false:
		add_sibling(load(game_loader_data[0]["Scene"]).instantiate()) # Replace 0 with En
		main_exists = true
	
	call_deferred("queue_free")
	get_parent().get_node("Main/HUD").show()
