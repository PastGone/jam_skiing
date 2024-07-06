extends CharacterBody2D
@export var is_editor:bool
@onready var shape_cast_2d: ShapeCast2D = $ShapeCast2D

const SPEED = 600.0
const JUMP_VELOCITY = -800.0
@onready var getitem: AudioStreamPlayer = $"../sound_manger/getitem"
@onready var jump: AudioStreamPlayer = $"../sound_manger/jump"
@onready var crash_s: AudioStreamPlayer = $"../sound_manger/crash_s"
@onready var sprite_2d: Sprite2D = $Sprite2D


var happy:Texture=preload("res://assets/textures/tset/雪球_开心.PNG")
var sad:Texture=preload("res://assets/textures/tset/雪球_伤心.PNG")

var other:=preload("res://build/other_snowball.tscn")
#子节点等于数量。 
var other_index:int=1

var add_other_num=1


var max_scale:=Vector2(4,4)
var scale_num:float=1
var display_current_scale=Vector2(1,1)

@onready var label: Label = $Label


func _physics_process(delta: float) -> void:
	if scale>max_scale:
		scale=max_scale

	scale_num=display_current_scale.x/Vector2(1,1).x
	if scale_num<0.5:
		label.self_modulate=Color(255,0,0,255)
	if scale_num<0.2:
		get_tree().change_scene_to_packed(load("res://main_interface.tscn"))
	label.text=str("X","%.1f" % scale_num)
	if not is_on_floor():
		velocity += get_gravity() * delta
		pass
	
	velocity.x = SPEED
	move_and_slide()
	
	
func _input(event:InputEvent):
	if event is InputEventMouseButton and shape_cast_2d.is_colliding():
		if event.button_index==MOUSE_BUTTON_LEFT and event.is_pressed() :
			mjump()
			return
	
#	合并在这里
	if Input.is_action_just_pressed("ui_accept") and shape_cast_2d.is_colliding()  :
		combine()
		return

#	分裂在这里。 
	if event is InputEventMouseButton and self.scale>Vector2(2,2) :
		if event.button_index==MOUSE_BUTTON_RIGHT and event.is_pressed() :
				split()
				pass
		pass

func mjump():
	velocity.y = JUMP_VELOCITY
	jump.play()


func split():
	self.scale/=2
	display_current_scale/=2
	for i in range(0,add_other_num):
		var a:CharacterBody2D=other.instantiate()
		a.position.x=other_index*-200
		other_index+=1
		self.add_child(a)
		add_other_num*=2
func combine():
	for c in self.get_children():
			if c.is_in_group("snow_ball"):
				c.queue_free()
				
			pass
	display_current_scale=self.scale*other_index  
	# 缩放不能超过最大值
	if self.scale*other_index >max_scale:
		self.scale=max_scale
	else:
		self.scale*=other_index
	# 重置其他数量
	other_index=1
	add_other_num=1
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("gold"):
		print(body)
		getitem.play()
		sprite_2d.texture=happy
		if scale<Vector2(10,10):
			#self.scale+=Vector2(1,1)
			self.scale+=Vector2(0.05/other_index,0.05/other_index)
			display_current_scale+=Vector2(0.05/other_index,0.05/other_index)
		
		body.queue_free()
	
	
	
	elif body.is_in_group("tree")and scale>Vector2(2.5,2.5):
		crash_s.play()
		sprite_2d.texture=happy
		self.scale+=Vector2(0.1/other_index,0.1/other_index)
		display_current_scale+=Vector2(0.1/other_index,0.1/other_index)
		body.q_f()
		
	elif body.is_in_group("house") :
		if scale<Vector2(2.5,2.5):
			body.open_door()
		else:
			crash_s.play()
			sprite_2d.texture=happy
			self.scale+=Vector2(0.2/other_index,0.2/other_index)
			display_current_scale+=Vector2(0.2/other_index,0.2/other_index)
			body.q_f()

#减的逻辑 
	elif body.is_in_group("pitfall"):
		print(body)
		crash_s.play()
		sprite_2d.texture=sad
		self.scale-=Vector2(0.1/other_index,0.1/other_index)
		display_current_scale-=Vector2(0.1/other_index,0.1/other_index)
		body.queue_free()
	pass # Replace with function body.


func _on_up_button_up() -> void:
	if shape_cast_2d.is_colliding():
		mjump()
	pass # Replace with function body.


func _on_combine_button_up() -> void:
	combine()
	pass # Replace with function body.


func _on_split_button_up() -> void:
	split()
	pass # Replace with function body.
