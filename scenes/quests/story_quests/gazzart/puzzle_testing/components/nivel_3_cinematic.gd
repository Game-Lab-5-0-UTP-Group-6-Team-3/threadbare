# SPDX-FileCopyrightText: The Threadbare Authors
# SPDX-License-Identifier: MPL-2.0
extends Cinematic

func _ready() -> void:
	if not GameState.intro_dialogue_shown:
		DialogueManager.show_dialogue_balloon(dialogue, "", [self])
		await DialogueManager.dialogue_ended
		GameState.intro_dialogue_shown = true

func _process(_delta: float) -> void:
	var player: Player = $"../OnTheGround/Player"
	
	# límite de mapa
	if player.position.y < 230:
		if next_scene:
			(
				SceneSwitcher.change_to_file(
				next_scene,
				spawn_point_path 
				)
			)
	
		
	
