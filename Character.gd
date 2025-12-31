extends Node2D
class_name Character

@export var is_player : bool 
@export var cur_hp : int = 25
@export var max_hp : int = 25
@export var combat_actions : Array # Formerly combat_action, changed to hopefully make accessing and memory easier
@export var opponents : Node
@export var target : Node
@onready var health_bar : ProgressBar = get_node("HealthBar")
@onready var health_text : Label = get_node("HealthBar/HealthText")
@export var flip_visual : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/BattleScene").character_begin_turn.connect(_on_character_begin_turn)
	health_bar.max_value = max_hp
	$Sprite.flip_h = flip_visual
	if is_player :
		print ("I'm player!")
	else:
		print("I'm no!")

func get_merked_idiot():
	print("WAIT WAIT WAIT AAUGH-")

func _update_health_bar():
	health_bar.value = cur_hp
	health_text.text = str(cur_hp, " / ", max_hp)

func _take_damage(damage):
	cur_hp -= damage
	_update_health_bar()
	if cur_hp <= 0 :
		get_node("root/BattleScene").character_died(self)
		queue_free() # Will be either game over or victory later

func heal (amount):
	cur_hp += amount
	if cur_hp > max_hp:
		cur_hp = max_hp
	_update_health_bar()


func _on_character_begin_turn(character):
	pass

func _on_character_end_turn(character):
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
