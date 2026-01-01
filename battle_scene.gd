extends Node2D

@onready var player_party = preload("res://parties/player_party.tscn").instantiate()
@onready var enemy_party = preload("res://parties/enemy_party.tscn").instantiate()
@export var player_char : Character # may need to be changed to allow for multiple party members in the future
@export var enemy_char : Character # see above
@export var player_group : Node2D # Will amalgamate party scripts in the future to allow "Party" class
@export var enemy_group : Node2D
@export var next_turn_delay : float = 1.0
@export var cur_char : Character # Probably don't need to change this one, but build around it.
var game_over : bool = false
var fight_over : bool = false
var char_count = 0
var focus_count = 0

@export var player_partyScene : PackedScene
signal character_begin_turn(character)
signal character_end_turn(character)


# Called when the node enters the scene tree for the first time.
func _ready():
	$Placeholder.get_merked_idiot()
	$Placeholder.queue_free()
	add_child(player_party)
	add_child(enemy_party)
	player_group = $PlayerParty
	enemy_group = $EnemyParty
	for i in $PlayerParty.players.size():
		player_group.players[i].opponents = get_node("EnemyParty")
	$PlayerParty.position.x -= 180 
	$EnemyParty.position.x += 180
	$PlayerParty.position.y -= 125
	$EnemyParty.position.y -= 125
	await get_tree().create_timer(0.5).timeout
	cur_char = player_group.players[0]
	begin_next_turn()
	pick_target(0)

func begin_next_turn(): # Needs review for true party system
	
	if char_count > 0 and cur_char != null:
		
		if cur_char.is_player :
			if  char_count <= player_group.players.size() :
				cur_char = player_group.players[char_count]
				char_count =+1
			else:
				cur_char = enemy_group.enemies[0]
				char_count =1
	elif cur_char.is_player == false:
		if char_count <= enemy_group.enemies.size :
			cur_char = enemy_group.enemies[char_count]
			char_count =+1
		else :
			cur_char = player_group.players[0]
			char_count =1
	else:
		cur_char = player_group.players[char_count]
		char_count =+1
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

func pick_target(guynumber):
	if cur_char.is_player :
		enemyUnfocus()
		enemy_group.enemies[guynumber].focus()
		cur_char.target = enemy_group.enemies[guynumber]
		print (guynumber)
	else:
		pass

func enemyUnfocus():
	for i in enemy_party.enemies.size():
		enemy_party.enemies[i].nofocus()
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enemyChooserUp") :
		if focus_count <= 0 :
			pick_target(enemy_group.enemies.size()-1)
			focus_count = (enemy_group.enemies.size()-1)
		else:
			focus_count = (focus_count)-1
			pick_target(focus_count)
