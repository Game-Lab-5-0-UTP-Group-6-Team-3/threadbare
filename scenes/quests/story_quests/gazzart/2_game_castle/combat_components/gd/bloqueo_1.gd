extends Node2D

@onready var sprite := $Sprite2D
@onready var collision := $Collider/CollisionShape2D

func _ready():
	# Asegurar que al inicio sea visible y colisionable
	if sprite:
		sprite.visible = true
	if collision:
		collision.disabled = false

# Este método lo llamará el Tablero cuando el puzzle se complete
func on_puzzle_completado():
	if sprite:
		sprite.visible = false
	if collision:
		collision.disabled = true  # Permite atravesarlo
	print("Celda1 desactivada tras victoria.")
