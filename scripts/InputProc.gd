extends Node2D

onready var inter = $Inter
onready var limit = $Limit

var pressed = false
var drag = false
var curpos = Vector2(0,0)
var prepos = Vector2(0,0) 
var acabou = false

func _ready():
	set_process_input(true)
	set_physics_process(true)
	pass
	
func _physics_process(delta):
	update()
	if drag and curpos.distance_to(prepos) > 0 and prepos != Vector2(0,0) and not acabou:
		var space_state = get_world_2d().get_direct_space_state()
		var result = space_state.intersect_ray(prepos, curpos)
		if not result.empty():
			if result.collider.has_method("cut"):
				result.collider.cut()
	
func _input(event):
	event = make_input_local(event)
	if event is InputEventScreenTouch:
		if event.pressed:
			pressed(event.position)
		else:
			released()
	elif event is InputEventScreenDrag:
		drag(event.position)

func pressed(pos):
	pressed = true
	prepos = pos
	limit.start()
	inter.start()

func released():
	pressed = false
	drag = false
	limit.stop()
	inter.stop()
	curpos = Vector2(0,0)
	prepos = Vector2(0,0)

func drag(pos):
	curpos = pos
	drag = true

func _on_Inter_timeout():
	prepos = curpos

func _on_Limit_timeout():
	released()
	
func _draw():
	if drag and curpos.distance_to(prepos) > 0 and prepos != Vector2(0,0) and not acabou:
		draw_line(curpos, prepos, Color(1,0,0), 10)
