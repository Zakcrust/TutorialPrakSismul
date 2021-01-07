extends Control

var player : Player

var time : float = 60

func _ready():
	$Lives.text = "Lives : %s " % GameManager.life
	player = get_parent().get_parent().get_node("Player")
	set_time_ui(time)
	$Timer.start()


func set_time_ui(value) -> void:
	$Time.text = "Time : %s" % value

func set_score_ui(value) -> void:
	$Score.text = "Score : %s" % value


func _on_Timer_timeout():
	time -= $Timer.wait_time
	set_time_ui(time)
	if time <= 0:
		$Timer.stop()
		player.lose()


func _on_Player_update_score_ui():
	set_score_ui(GameManager.score)


func _on_Player_lose_ui():
	$Timer.stop()


func _on_Player_win_ui():
	$Timer.stop()


func _on_Player_update_life_ui():
	$Lives.text = "Lives : %s " % GameManager.life
