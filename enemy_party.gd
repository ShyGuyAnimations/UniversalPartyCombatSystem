extends Node2D

@export var enemies: Array = []
@export var index : int = 0

var lizardman = preload("res://chara/lizardman.tscn").instantiate()
var bore = preload("res://chara/battlecatsguythatIhate.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lizardman.flip_visual = true
	bore.flip_visual = true
	_add_chara(lizardman)
	_add_chara(bore)
	enemies = get_children()
	for i in enemies.size():
		enemies[i].position = Vector2(0, i*180)
		enemies[i].is_player = false
		enemies[i].flip_visual = true
		enemies[i].opponents = get_parent().get_node("PlayerParty")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _add_chara(newChar):
	add_child(newChar)
