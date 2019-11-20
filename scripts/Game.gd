extends Node2D

onready var fruits = $Fruits

var peach = preload("res://scenes/fruits/Peach.tscn")
var pie_lemon = preload("res://scenes/fruits/PieLemon.tscn")
var honeycomb = preload("res://scenes/fruits/Honeycomb.tscn")
var apple = preload("res://scenes/fruits/Apple.tscn")
var strawberry = preload("res://scenes/fruits/Strawberry.tscn")
var piePumpkin = preload("res://scenes/fruits/PiePumpkin.tscn")
var chickenLeg = preload("res://scenes/ChickenLeg.tscn")

var score = 0
var lifes = 3

var fruit_list = [
		peach, 
		piePumpkin, 
		honeycomb, 
		apple, 
		pie_lemon,
		chickenLeg
	]

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Generator_timeout():
	if lifes <= 0:
		return
	for i in range(0, rand_range(2, 5)):
		var obj = fruit_list[randi() % fruit_list.size()].instance()
		
		obj.born(Vector2(rand_range(400, 900), 700))
		if obj.name != "bomb":
			obj.connect("score", self, "inc_score")
		obj.connect("life", self, "dec_life")
		fruits.add_child(obj)
		
func inc_score(value):
	if lifes == 0:
		return
	score += value
	$Control.get_node("Score").set_text(str(score))

func dec_life():
	lifes -= 1
	if lifes == 0:
		$GameOverScreen.start()
		$Control.get_node("Bomb3").set_modulate(Color(1, 0, 0))
		$InputProc.acabou = true
	elif lifes == 1:
		$Control.get_node("Bomb2").set_modulate(Color(1, 0, 0))
	elif lifes == 2:
		$Control.get_node("Bomb1").set_modulate(Color(1, 0, 0))