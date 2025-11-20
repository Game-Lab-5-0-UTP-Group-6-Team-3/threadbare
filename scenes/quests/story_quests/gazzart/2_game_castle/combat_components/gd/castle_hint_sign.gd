# SPDX-FileCopyrightText: The Threadbare Authors
# SPDX-License-Identifier: MPL-2.0
extends StaticBody2D

@export var sign_dialogue: DialogueResource

var dialogo_en_progreso := false

@onready var interact_area: InteractArea = %InteractArea

func _ready() -> void:
	interact_area.disabled = false


func _on_interact_area_interaction_started(_player: Player, _from_right: bool) -> void:
	if dialogo_en_progreso:
		return

	dialogo_en_progreso = true

	DialogueManager.show_dialogue_balloon(
		sign_dialogue,
		"",
		[self]
	)

	await DialogueManager.dialogue_ended

	dialogo_en_progreso = false

	interact_area.end_interaction()
