extends Node2D

class_name MovingPlatform

export (float) var travel_time = 1.0
export (float) var wait_time = 1.0
var patrol_points : Array
var draw_points : Array
var draw_offset : Vector2 = Vector2(0, 32.0)
var current_index = 0

var path_drawer = load("res://Scenes/Props/PropsPathDrawer.tscn").instance()

func _ready():
	patrol_points.append(global_position)
	$Timer.wait_time = wait_time
	draw_points.append(global_position + draw_offset)
	for child in get_children():
		if child is Position2D:
			patrol_points.append(child.global_position)
			draw_points.append(child.global_position + draw_offset)
	path_drawer.draw_points = draw_points
	get_parent().call_deferred("add_child", path_drawer)


func start_platform() -> void:
	if patrol_points.size() == 1:
		return
	var destination_index = (current_index + 1) % patrol_points.size()
	var destination = patrol_points[destination_index]
	$Tween.interpolate_property(self, "position", $Platform.global_position, destination, travel_time)
	$Tween.start()
	yield($Tween, "tween_all_completed")
	current_index += 1
	$Timer.start()


func start_timer() -> void:
	$Timer.start()


func _on_Timer_timeout():
	start_platform()
