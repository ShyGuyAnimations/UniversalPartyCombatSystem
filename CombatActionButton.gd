extends Button

var combat_action : CombatAction

func cast_combat_action (action):
	pass



func _on_pressed() -> void:
	get_node("/root/BattleScene").cur_char.cast_combat_action(combat_action)
