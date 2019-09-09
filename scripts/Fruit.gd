extends RigidBody2D

onready var shape = get_node("Shape")
onready var sprite0 = get_node("Sprite0")
onready var body1 = get_node("Body1")
onready var body2 = get_node("Body2") 
onready var sprite1 = body1.get_node("Sprite1")
onready var sprite2 = body2.get_node("Sprite2")
var cortada = false

signal life
signal score

func _ready():
	set_process(true)
	randomize()

func _process(delta):
	if self.position.y > 700:
		emit_signal("life")
		queue_free()
	if body1.position.y > 700 and body2.position.y > 700:
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
	emit_signal("score")
	body1.get_node("Shape1").disabled = false
	body2.get_node("Shape2").disabled = false
	set_mode(MODE_KINEMATIC)
	sprite0.queue_free()
	shape.queue_free()
	body1.set_mode(MODE_RIGID)
	body2.set_mode(MODE_RIGID)
	body1.apply_impulse(Vector2(0,0), Vector2(-300, 0).rotated(self.rotation))
	body2.apply_impulse(Vector2(0,0), Vector2(300, 0).rotated(self.rotation))
	body1.set_angular_velocity(get_angular_velocity())
	body2.set_angular_velocity(get_angular_velocity())
