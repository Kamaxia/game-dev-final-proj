extends Area3D





func _on_body_entered(body: Node3D) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
