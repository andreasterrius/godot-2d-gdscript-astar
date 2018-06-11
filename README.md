A* implementation for a grid in godot, implemented using priority queue (based on heap)
A* = pathfind.gd
priority-queue = pq.gd

h(x) is distance between the current block to end point
g(x) is distance between the current block to it's neighbour

If the grid element wants to block the path, use grid[Vector2(0,0)].traversable = false, with 0,0 as your index

There's a demo scene you can play around in Node.tscn, tweak the values in in test.gd

![a-star](https://i.imgur.com/Xvdt5xN.png)
