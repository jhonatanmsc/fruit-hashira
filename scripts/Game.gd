extends Node2D

onready var fruits = $Fruits

var avocado = preload("res://scenes/fruits/Avocado.tscn")
var banana = preload("res://scenes/fruits/Banana.tscn")
var lemon = preload("res://scenes/fruits/Lemon.tscn")
var orange = preload("res://scenes/fruits/Orange.tscn")
var pear = preload("res://scenes/fruits/Pear.tscn")
var pineapple = preload("res://scenes/fruits/PineApple.tscn")
var tomato = preload("res://scenes/fruits/Tomato.tscn")
var watermelon = preload("res://scenes/fruits/Watermelon.tscn")
var bomb = preload("res://scenes/Bomb.tscn")

var score = 0
var lifes = 3

var fruit_list = [
		avocado, banana, lemon, 
		orange, pear, pineapple, 
		tomato, watermelon, bomb
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
		
func inc_score():
	if lifes == 0:
		return
	score += 1
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