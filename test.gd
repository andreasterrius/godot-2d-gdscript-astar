extends Node2D

var pathfind = preload("res://pathfind.gd").new()
var grid = {}
var path = []
var box_size = 20

var start = Vector2(0,0)
var end = Vector2(19, 19)

func _ready():
	for i in range(0, 20):
		for j in range(0, 20):
			grid[Vector2(i, j)] = {	
				path = false,
				traversable = true
			}
			
			
	# Obstacles
	grid[Vector2(7, 11)].traversable = false
	grid[Vector2(8,11)].traversable = false
	grid[Vector2(9,11)].traversable = false
	grid[Vector2(10,11)].traversable = false
	grid[Vector2(11,11)].traversable = false
	grid[Vector2(12,11)].traversable = false
	grid[Vector2(13,11)].traversable = false
	
	grid[Vector2(11,15)].traversable = false
	grid[Vector2(12,15)].traversable = false
	grid[Vector2(13,15)].traversable = false
	grid[Vector2(14,15)].traversable = false
	grid[Vector2(15,15)].traversable = false
	grid[Vector2(16,15)].traversable = false
	grid[Vector2(17,15)].traversable = false
	grid[Vector2(18,15)].traversable = false
	grid[Vector2(19,15)].traversable = false
	grid[Vector2(19,17)].traversable = false
	
	grid[Vector2(14,17)].traversable = false
	grid[Vector2(15,17)].traversable = false
	grid[Vector2(16,17)].traversable = false
	grid[Vector2(17,17)].traversable = false
	grid[Vector2(18,17)].traversable = false
	grid[Vector2(19,17)].traversable = false
	
	path = pathfind.astar(grid, Vector2(0,0), Vector2(19,19))
	for p in path:
		grid[p]['path'] = true
	update()


func _process(delta):
	pass	
	
func _draw():
	for key in grid.keys():
		var val = grid[key]
		var color = Color(0.0, 0.0, 0.0)
		if key == start:
			color = Color(0.0, 1.0, 0.0)
		elif key == end:
			color = Color(1.0, 0.0, 0.0)
		elif val.path:
			color = Color(1.0, 1.0, 0.0)
		elif !val.traversable:
			color = Color(0.0, 0.0, 1.0) 
		else:
			color = Color(0.7, 0.7, 0.7)
		draw_rect(Rect2(100+box_size*key.x,100+box_size*key.y,box_size,box_size), color, true)
	pass
	
#void draw_rect( Rect2 rect, Color color, bool filled=true )
#Draws a colored rectangle.

