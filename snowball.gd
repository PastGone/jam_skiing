extends CharacterBody2D
#@export var is_editor:bool

#@onready var shape_cast_2d: ShapeCast2D = $ShapeCast2D

const SPEED = 600.0
const JUMP_VELOCITY = -800.0

@onready var sprite_2d: Sprite2D = $Sprite2D


@onready var role_group: Node2D = $".."



func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		pass
	
	velocity.x = SPEED
	move_and_slide()
	
	
	

func mjump()->void:
	print("开始")
	
	await get_tree().create_timer(get_index()*0.15).timeout
	velocity.y = JUMP_VELOCITY
	print("结束")
	
	
	
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	var small_get=Vector2(0.05/role_group.other_index,0.05/role_group.other_index)
	var middle_get:=Vector2(0.1/role_group.other_index,0.1/role_group.other_index)
	var big_get:=Vector2(0.2/role_group.other_index,0.2/role_group.other_index)
	
	
	var lost:=Vector2(0.1/role_group.other_index,0.1/role_group.other_index)

	
	if GlobalParms.cur_mode==GlobalParms.mode.display:
		small_get=Vector2(0.5/role_group.other_index,0.5/role_group.other_index)
	if GlobalParms.cur_mode==GlobalParms.mode.hard:
		lost=Vector2(1.0/role_group.other_index,1.0/role_group.other_index)


	if body.is_in_group("gold"):
		
		if role_group.all_scale<Vector2(10,10):
			role_group.all_scale+=small_get
			role_group.display_current_scale+=small_get
		body.queue_free()
	
	
	
	elif body.is_in_group("tree")and role_group.all_scale>Vector2(2.5,2.5):
		if body.flag==false:
			role_group.all_scale+=middle_get
			role_group.display_current_scale+=middle_get
			body.q_f()
		
	elif body.is_in_group("house") :
		if body.flag==false:
			if role_group.all_scale<Vector2(2.5,2.5):
				body.open_door()
			else:
				role_group.all_scale+=big_get
				role_group.display_current_scale+=big_get
				body.q_f()

#减的逻辑 
	elif body.is_in_group("pitfall"):
		
		
		role_group.all_scale-=lost
		role_group.display_current_scale-=lost
		body.queue_free()
	pass # Replace with function body.
