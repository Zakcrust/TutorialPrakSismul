extends Node

var score : int = 0
var life : int = 3

var checkpoint

func reset() -> void:
	score = 0
	life = 3


func respawn() -> void:
	life -= 1
	checkpoint.spawn_player()
	
