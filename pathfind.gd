func astar(grid, start_idxv, end_idxv):
	var pq = preload("res://pq.gd").new()
	pq.make()
	var traversed = {}	
	var result = _evaluate_grid_samethread(pq, traversed, grid, start_idxv.x, start_idxv.y, 
		start_idxv.x, start_idxv.y, end_idxv.x, end_idxv.y)
	return result
	

func _distance(a, b):
	var ab_x = abs(b.x-a.x)
	var ab_y = abs(b.y-a.y)
	return sqrt(abs(ab_x*ab_x+ab_y*ab_y))
	
func _grid_traverse_queue(pq, traversed, grid, curr, prev, to):

	if !grid.has(curr):
		return
	
	if grid[curr].has('traversable'):
		if grid[curr]['traversable'] == false:
			return
	
	var gx = _distance(prev, curr)
	var hx = _distance(curr, to) 
	var curr_weight = -(gx+hx)
	
	## Weights could never be lower, because of priority_queue
	var already_visited = traversed.has(curr) # || (traversed[curr] != null && traversed[curr].weight > curr_weight)
	
	if already_visited:
		return
		
	traversed[curr] = {
		curr = curr,	
		prev = prev,
		weight = curr_weight,
	}
	
	pq.push({
		curr = curr,
		prev = prev,
		pqval = curr_weight
	})
	

func _evaluate_grid_samethread(pq, traversed, grid, i, j, start_i, start_j, end_i, end_j):
	return _evaluate_grid( 
		[{
			pq = pq, 
			traversed = traversed, 
			grid = grid, 
			i = i,
			j = j,
			start_i = start_i,
			start_j = start_j,
			end_i = end_i,
			end_j = end_j
		}])

func _evaluate_grid(userdata):
	var pq = userdata[0].pq
	var traversed = userdata[0].traversed
	var grid = userdata[0].grid
	var start_i = userdata[0].start_i
	var start_j = userdata[0].start_j
	var current_probe = 0
	var maximum_probe = 100000
	
	## TCO
	while true:
		var i = userdata[0].i
		var j = userdata[0].j
		var end_i = userdata[0].end_i
		var end_j = userdata[0].end_j

		var curr = Vector2(i, j)
		var end = Vector2(end_i, end_j)
		_grid_traverse_queue(pq, traversed, grid, Vector2(i-1,j), curr, end)
		_grid_traverse_queue(pq, traversed, grid, Vector2(i+1,j), curr, end)
		_grid_traverse_queue(pq, traversed, grid, Vector2(i,j-1), curr, end)
		_grid_traverse_queue(pq, traversed, grid, Vector2(i,j+1), curr, end)	
		
		_grid_traverse_queue(pq, traversed, grid, Vector2(i-1,j-1), curr, end)
		_grid_traverse_queue(pq, traversed, grid, Vector2(i-1,j+1), curr, end)
		_grid_traverse_queue(pq, traversed, grid, Vector2(i+1,j+1), curr, end)
		_grid_traverse_queue(pq, traversed, grid, Vector2(i+1,j-1), curr, end)
		
		if pq.empty():
			return []
			
		var top = pq.top()
		pq.pop()
		current_probe += 1
		
		if i == end_i and j == end_j:
			var result = []
			var start = Vector2(start_i, start_j)
			var begin = Vector2(end.x, end.y)
			_get_path(grid, traversed, start, end, begin, result)
			return result
		elif current_probe > maximum_probe:
			return []
		else:			
			userdata[0].i = top.curr.x
			userdata[0].j = top.curr.y

func _get_path(grid, traversed, start, end, curr, result):
	while true:
		if curr == start:
			result.push_front(curr)
			return
		result.push_front(curr)
		curr = traversed[curr].prev		
	
	