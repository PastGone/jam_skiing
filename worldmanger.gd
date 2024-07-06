extends Node
var a=preload("res://way.tscn")

var 最远点的位置:Vector2=Vector2.ZERO
var 当前最新地形编号:int=0
@onready var player: CharacterBody2D = $"../Player"

var viewport_x:int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#视口大小
	var viewport = get_viewport()
	
	viewport_x=viewport.size.x
	
	
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if player.global_position.x>最远点的位置.x-viewport_x:
		g_a_next_way(最远点的位置)
		pass
	pass

func g_a_next_way(ori: Vector2) -> void:
	var node:=a.instantiate() as Node2D
	node.global_position=ori
	self.add_child(node)
	pass # Replace with function body.
