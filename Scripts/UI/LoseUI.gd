extends Control


func _on_TryAgain_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_Player_lose_ui():
	get_tree().paused = true
	show()
