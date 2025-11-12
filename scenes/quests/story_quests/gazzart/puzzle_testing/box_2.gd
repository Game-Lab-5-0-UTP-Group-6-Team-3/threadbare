extends RigidBody2D

var caja1: RigidBody2D = null

func _ready() -> void:
	# Obtener referencia a Box1
	caja1 = get_node_or_null("../Box1")
	
	if caja1:
		# Conectar la señal de Box1 para que Box2 se mueva cuando Box1 se mueva
		caja1.caja_movida.connect(_caja1_movimiento)
		
		# Posicionar Box2 inicialmente relativo a Box1
		_update_position()
	else:
		print("Error: No se encontró Box1")


func _caja1_movimiento(new_position: Vector2) -> void:
	# Esta función se llama cada vez que Box1 se mueve
	_update_position()


func _update_position() -> void:
	if caja1:
		# Obtener la posición actual de Box1
		var posicion_box1 = caja1.global_position
		
		# Calcular nueva posición sumando valores (360 en X, 0 en Y)
		var nueva_posicion = posicion_box1 + Vector2(360, 0)
		
		# Mover Box2 a la nueva posición
		global_position = nueva_posicion
	
