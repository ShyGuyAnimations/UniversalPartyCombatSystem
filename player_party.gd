extends Node2D


@export var players: Array = []
@export var index : int = 0
var dragonman = preload("res://chara/dragonman.tscn").instantiate()
var bad = preload("res://chara/baddragon.tscn").instantiate()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dragonman.is_player = true
	bad.is_player = true
	_add_chara(dragonman)
	_add_chara(bad)
	players = get_children()
	for i in players.size():
		players[i].position = Vector2(0, i*180)
		players[i].is_player = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _add_chara(newChar):
	add_child(newChar)
