extends CharacterBody2D





func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * 100
	move_and_slide()
