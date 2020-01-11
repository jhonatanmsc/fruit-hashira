extends Node2D

onready var fruits = $Fruits

var strawberry = preload("res://scenes/healthy/Strawberry.tscn")
var apple = preload("res://scenes/healthy/Apple.tscn")
var turnip = preload("res://scenes/healthy/Turnip.tscn")
var healthy_list = [strawberry, apple, turnip]

var bacon = preload("res://scenes/unhealthy/Bacon.tscn")
var piePumpkin = preload("res://scenes/unhealthy/PiePumpkin.tscn")
var pretzel = preload("res://scenes/unhealthy/Pretzel.tscn")
var unhealthy_list = [bacon, piePumpkin, pretzel]

var heart = preload("res://scenes/Heart.tscn")

var score = 0
var lifes = 3

var scenes_list = healthy_list + unhealthy_list

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Generator_timeout():
	if lifes <= 0:
		return
	for i in range(0, rand_range(2, 5)):
		var obj = scenes_list[randi() % scenes_list.size()].instance()
		
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
		$Control.get_node("Bomb3").set_modulate(Color(0, 1, 1))
		$InputProc.acabou = true
	elif lifes == 1:
		$Control.get_node("Bomb2").set_modulate(Color(0, 1, 1))
	elif lifes == 2:
		$Control.get_node("Bomb1").set_modulate(Color(0, 1, 1))