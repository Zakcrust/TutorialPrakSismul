extends Control

func _ready():
	$Buttons.hide()
	$Label.hide()


func _on_TryAgain_pressed():
	get_tree().change_scene("res://Scenes/MainScene.tscn")
	GameManager.reset()


func _on_Player_win_ui():
	$Label.text = "You win"
	$Buttons.show()
	$Label.show()

	
func _on_Player_lose_ui():
	$Buttons.show()
	$Label.text = "You lose"
	$Label.show()



func _on_MainMenu_pressed():
	get_tree().change_scene("res://Scenes/UI/MainMenu.tscn")
