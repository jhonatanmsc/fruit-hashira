extends Node2D

onready var fruits = get_node("Fruits")

var avocado = preload("res://scenes/fruits/Avocado.tscn")
var banana = preload("res://scenes/fruits/Banana.tscn")
var lemon = preload("res://scenes/fruits/Lemon.tscn")
var orange = preload("res://scenes/fruits/Orange.tscn")
var pear = preload("res://scenes/fruits/Pear.tscn")
var pineapple = preload("res://scenes/fruits/PineApple.tscn")
var tomato = preload("res://scenes/fruits/Tomato.tscn")
var watermelon = preload("res://scenes/fruits/Watermelon.tscn")
var bomb = preload("res://scenes/fruits/Bomb.tscn")

var fruit_list = [
		avocado, banana, lemon, 
		orange, pear, pineapple, 
		tomato, watermelon
	]

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Generator_timeout():
	for i in range(0, rand_range(2, 5)):
		var obj = fruit_list[randi() % fruit_list.size()].instance()
		obj.born(Vector2(rand_range(400, 900), 700))
		fruits.add_child(obj)
