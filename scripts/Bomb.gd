extends RigidBody2D

onready var shape = get_node("Shape")
onready var sprite = get_node("Sprite")
onready var anim = get_node("Animation")
var cortada = false

signal life

func _ready():
	set_process(true)
	randomize()
	pass # Replace with function body.
	
func _process(delta):
	if self.position.y > 700:
		queue_free()

func born(inipos):
	self.position = inipos
	var inivel = Vector2(0, rand_range(-1000, -800))
	if inipos.x < 640:
		inivel = inivel.rotated(deg2rad(rand_range(0, -30)))
	else:
		inivel = inivel.rotated(deg2rad(rand_range(0, 30)))
	
	set_linear_velocity(inivel)
	set_angular_velocity(rand_range(-10, 10))

func cut():
	if cortada:
		return
	cortada = true
	emit_signal("life")
	set_mode(MODE_KINEMATIC)
	anim.play("Explode")
	