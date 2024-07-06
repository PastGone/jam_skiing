extends CanvasGroup

@onready var line_2d: Line2D = $Line2D
@onready var collision_polygon_2d: CollisionPolygon2D = $StaticBody2D/CollisionPolygon2D

@onready var worldmanger: Node2D = $".."
@onready var game_system: Node = $"../../GameSystem"


var end_global_position:Vector2

var Tree1 = preload("res://build/tree_1.tscn")
var Tree2 = preload("res://build/tree_2.tscn")
var pitfall_sec=preload("res://build/pitfall.tscn")
var house_sec=preload("res://build/house.tscn")
var gold_sec=preload("res://build/gold.tscn")

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
	
	#当前最新地形编号
	if worldmanger.当前最新地形编号%10==0:
		draw_house()
	else :
		#试着绘制树
		var tree_num:int=randi_range(5, 8)
		for i in range(0,tree_num):
			draw_tree()
		#试着绘制陷阱
		draw_pitfall()
	
	##
	worldmanger.当前最新地形编号+=1
	
	##
	var gold_num:int=randi_range(5, 8)
	for i in range(0,gold_num):
		draw_gold()
	#试着绘制陷阱
	draw_pitfall()

func  _process(_delta: float) -> void:
	if worldmanger.最远点的位置.x > end_global_position.x+5000.0:
		self.queue_free()
		pass
		
	pass
	
	
func draw_pitfall() -> void:
	var random_point = get_random_point_on_line(line_2d.points)
	print(line_2d.points[-1])
	#var tree:Node2D = check_probability(0.5) ? Tree1.instance() : Tree2.instance()
	var pitfall:Node2D=pitfall_sec.instantiate()
		
	pitfall.position = random_point
	add_child(pitfall)
	
	pass
	
func draw_house() -> void:
	var random_point = get_random_point_on_line(line_2d.points)
	print(line_2d.points[-1])
	#var tree:Node2D = check_probability(0.5) ? Tree1.instance() : Tree2.instance()
	var house:Node2D=house_sec.instantiate()
		
	house.position = random_point
	add_child(house)
	
	pass


func draw_gold() -> void:
	var random_point = get_random_point_on_line(line_2d.points)
	print(line_2d.points[-1])
	#var tree:Node2D = check_probability(0.5) ? Tree1.instance() : Tree2.instance()
	var gold:Node2D=gold_sec.instantiate()
		
	gold.position = random_point
	add_child(gold)
	
	pass


func draw_tree():
	#试着绘制树
	#if check_probability(delta * tree_probability):
	if check_probability(randf_range(0.0, 2.0)):
		var random_point = get_random_point_on_line(line_2d.points)
		print(line_2d.points[-1])
		#var tree:Node2D = check_probability(0.5) ? Tree1.instance() : Tree2.instance()
		var tree:Node2D
		if check_probability(0.5)==true:
			tree=Tree1.instantiate()
		else :
			tree=Tree2.instantiate()
		tree.position = random_point
		add_child(tree)
	pass


func get_random_point_on_line(points):
	if points == null or points.size() < 2:
		push_error("点集不能为空，并且必须包含至少两个点。")

	# 计算每段线段的长度，并累计到一个总长度中
	var segment_lengths = []
	var total_length = 0.0

	for i in range(points.size() - 1):
		var segment_length = points[i].distance_to(points[i + 1])
		segment_lengths.append(segment_length)
		total_length += segment_length

	# 生成一个0到总长度之间的随机数
	var random_length = randf_range(0, total_length)

	# 找到随机长度对应的线段和相对位置
	var accumulated_length = 0.0
	for i in range(segment_lengths.size()):
		if accumulated_length + segment_lengths[i] >= random_length:
			var segment_start_length = accumulated_length
			var segment_length = segment_lengths[i]
			var segment_position = (random_length - segment_start_length) / segment_length

			# 计算在线段上的那个点
			var start_point = points[i]
			var end_point = points[i + 1]
			#var random_point = start_point.linear_interpolate(end_point, segment_position)
			var random_point= start_point + (end_point - start_point) * segment_position
			return random_point
			
		accumulated_length += segment_lengths[i]

	# 如果由于某种原因未能找到点，返回最后一个点
	return points[-1]



func check_probability(probability):
	var random_value = randf_range(0.0, 1.0)
	return random_value <= probability
