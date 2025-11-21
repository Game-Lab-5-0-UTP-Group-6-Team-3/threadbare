# SPDX-FileCopyrightText: The Threadbare Authors
# SPDX-License-Identifier: MPL-2.0
extends Cinematic

@export var required_items: Array[InventoryItem] = []   # Puedes asignarlos desde el editor
@export var puerta_dialogue: DialogueResource            # gazzart_puerta_condicion.dialogue


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.clear_inventory()
	
	if not GameState.intro_dialogue_shown:
		DialogueManager.show_dialogue_balloon(dialogue, "", [self])
		await DialogueManager.dialogue_ended
		GameState.intro_dialogue_shown = true


var dialogo_mostrado := false
var dialogo_en_progreso := false
var estaba_en_zona := false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var player: Player = $"../Player"
	
	
	var pos = player.global_position

	var en_zona_puerta : bool = (
		pos.x > 3630 and pos.x < 3730 and
		pos.y > 299  and pos.y < 399
	)
	
	if estaba_en_zona and not en_zona_puerta:
		dialogo_mostrado = false

	estaba_en_zona = en_zona_puerta

	if en_zona_puerta and not dialogo_en_progreso:
		_check_conditions_and_transition()



func _check_conditions_and_transition() -> void:
	# --- Verificar si tiene los 3 CollectibleItem ---
	var items := GameState.items_collected()

	var tiene_tres_items: bool = items.size() == 3

	if tiene_tres_items:
		if next_scene:
			SceneSwitcher.change_to_file(
				next_scene,
				spawn_point_path 
			)
	else:
		if puerta_dialogue and not dialogo_mostrado:
			dialogo_mostrado = true
			dialogo_en_progreso = true
			
			DialogueManager.show_dialogue_balloon(
				puerta_dialogue,
				"", 
				[self]
			)
			await DialogueManager.dialogue_ended
			dialogo_en_progreso = false  
