extends Node2D

var player_party = preload("res://parties/player_party.tscn").instantiate()
var enemy_party = preload("res://parties/enemy_party.tscn").instantiate()
@export var player_char : Character # may need to be changed to allow for multiple party members in the future
@export var enemy_char : Character # see above
@export var player_group : Node2D # Will amalgamate party scripts in the future to allow "Party" class
@export var enemy_group : Node2D
@export var next_turn_delay : float = 1.0
var cur_char : Character # Probably don't need to change this one, but build around it.
var game_over : bool = false
var fight_over : bool = false

@export var player_partyScene : PackedScene
signal character_begin_turn(character)
signal character_end_turn(character)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Placeholder.get_merked_idiot()
	$Placeholder.queue_free()
	add_child(player_party)
	add_child(enemy_party)
	var pparty = $PlayerParty
	for i in $PlayerParty.players.size():
		pparty.players[i].opponents = get_node("EnemyParty")
	$PlayerParty.position.x -= 180 
	$EnemyParty.position.x += 180
	$PlayerParty.position.y -= 125
	$EnemyParty.position.y -= 125
	await get_tree().create_timer(0.5).timeout
	begin_next_turn()

func player_want_enemy():
	pass

func begin_next_turn(): # Needs review for true party system
	
	if cur_char == player_char:
		cur_char = enemy_char
	elif cur_char == enemy_char:
		cur_char = player_char
	else:
		cur_char = player_char
	character_begin_turn.emit(cur_char)

func end_current_turn():
	character_end_turn.emit(cur_char)
	if game_over == false:
		await get_tree().create_timer(next_turn_delay).timeout
		begin_next_turn()

func character_died(character):
	fight_over = true
	#If character/character_party equals player:
		#game_over = true
	#Else :
		#print("victory")
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass 
