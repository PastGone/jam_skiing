extends CanvasGroup

@onready var line_2d: Line2D = $Line2D
@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D

@onready var worldmanger: Node2D = $".."

var end_global_position:Vector2

func _ready() -> void:
	var pre_adding_points:PackedVector2Array
	 
	var last:Vector2=Vector2.ZERO
	for i in range(0,10):
		if i==0:
			pre_adding_points.append(Vector2.ZERO)
			continue
		last+=Vector2(i*50.0,randf_range(50,100))
		pre_adding_points.append(last)
	line_2d.set_points(pre_adding_points)
	pass 
#	
	end_global_position=pre_adding_points[-1]+self.global_position
	if worldmanger.最远点的位置.x < end_global_position.x:
		worldmanger.最远点的位置=end_global_position
	
	
	#绘制碰撞区域，增加两个点，碰撞区域闭合
	var last_second_point=Vector2(pre_adding_points[-1]+Vector2(0,5000))
	var last_point=Vector2(pre_adding_points[0].x,last_second_point.y)
	pre_adding_points.append(last_second_point)
	pre_adding_points.append(last_point)
	collision_polygon_2d.set_polygon(pre_adding_points)
