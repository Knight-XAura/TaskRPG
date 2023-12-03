extends Node


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


func _notification(what) -> void:
	match what:
		NOTIFICATION_WM_CLOSE_REQUEST, NOTIFICATION_WM_GO_BACK_REQUEST:
			add_sibling(load("res://game_saver/game_saver.tscn").instantiate())
		
