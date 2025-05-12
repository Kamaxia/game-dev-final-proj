extends CanvasLayer


func _on_enter_button_down() -> void:
	get_tree().change_scene_to_file("res://scenes/le_game.tscn")
	pass # Replace with function body.


func _on_exit_button_down() -> void:
	get_tree().quit()
	pass # Replace with function body.
