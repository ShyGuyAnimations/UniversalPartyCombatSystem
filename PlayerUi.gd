extends HBoxContainer

@export var buttons : Array

func _on_character_begin_turn(character):
	
	
	if character.is_player:
		visible = character.is_player
		_display_combat_actions(character.combat_actions)
	pass

func _on_character_end_turn(character):
	visible = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("/root/BattleScene/").character_begin_turn.connect(_on_character_begin_turn)
	get_node("/root/BattleScene/").character_end_turn.connect(_on_character_end_turn)

func _display_combat_actions(combat_actions):
	for i in len(buttons):
		var button = get_node(buttons[i])
		if i < len(combat_actions):
			button.visible = true
			button.text = combat_actions[i].display_name
			button.combat_action = combat_actions[i]
		else:
			button.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
