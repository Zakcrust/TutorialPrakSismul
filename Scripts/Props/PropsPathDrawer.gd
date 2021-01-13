extends Node2D

var draw_points : Array
var line_color : Color = Color.white
var circle_color : Color = Color.blue


func _ready():
	update()

func _on_Drawer_draw():
	if draw_points.size() <= 1:
		return
	for i in range(draw_points.size() -1):
		draw_line(draw_points[i], draw_points[i + 1],line_color ,4.0)
		draw_circle(draw_points[i], 8.0, circle_color)
	draw_circle(draw_points.back(), 8.0 , circle_color)
