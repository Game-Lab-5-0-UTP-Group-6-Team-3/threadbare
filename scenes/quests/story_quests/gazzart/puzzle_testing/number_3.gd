extends RigidBody2D

## Señal emitida cuando el objeto es interactuado
signal interactuado3

@onready var interact_area: InteractArea = get_node("InteractArea") as InteractArea


func _ready() -> void:
	# Conectar la señal de interacción
	if interact_area:
		# Verificar que el InteractArea pertenece a este objeto
		if interact_area.get_parent() == self:
			interact_area.interaction_started.connect(_on_interaction_started)
			print("Number3: InteractArea encontrado y conectado correctamente")
		else:
			print("Number3: ERROR - InteractArea no pertenece a este objeto! Parent: ", interact_area.get_parent().name if interact_area.get_parent() else "null")
	else:
		print("Advertencia: No se encontró InteractArea en Number2")


func _on_interaction_started(_player: Player, _from_right: bool) -> void:
	# Esta función se llama cuando el jugador interactúa con el objeto
	print("Number3: _on_interaction_started llamado")
	interactuado3.emit()
	print("¡Number3 fue interactuado!")
	
	# Aquí puedes agregar tu lógica personalizada
	# Por ejemplo: cambiar sprite, reproducir sonido, etc.
	
	# Finalizar la interacción (usar call_deferred para asegurar que se ejecute después)
	call_deferred("_end_interaction")


func _end_interaction() -> void:
	if interact_area:
		print("Number3: Emitiendo interaction_ended")
		interact_area.interaction_ended.emit()
	else:
		print("Number3: ERROR - interact_area es null al intentar finalizar")
