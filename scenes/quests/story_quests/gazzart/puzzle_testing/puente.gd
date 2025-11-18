# SPDX-FileCopyrightText: The Threadbare Authors
# SPDX-License-Identifier: MPL-2.0
extends Node2D

## Señal emitida cuando el puente se activa (colisión desactivada)
signal puente_activado
## Señal emitida cuando el puente se desactiva (colisión activada)
signal puente_desactivado

## Si es true, el puente está activo (sin colisión, se puede cruzar)
## Si es false, el puente está desactivado (con colisión, no se puede cruzar)
@export var activo: bool = false

var static_body: StaticBody2D = null
var collision_shape: CollisionShape2D = null

func _ready() -> void:
	# Buscar el StaticBody2D hijo
	static_body = get_node_or_null("StaticBody2D")
	if not static_body:
		print("Advertencia: No se encontró StaticBody2D en el puente ", name)
		return
	
	# Buscar el CollisionShape2D dentro del StaticBody2D
	collision_shape = static_body.get_node_or_null("CollisionShape2D")
	if not collision_shape:
		print("Advertencia: No se encontró CollisionShape2D en el puente ", name)
		return
	
	# Configurar el estado inicial del puente
	_set_colision_activa(not activo)


## Activa el puente (desactiva la colisión, permite cruzar)
func activar() -> void:
	if activo:
		return
	activo = true
	_set_colision_activa(false)
	puente_activado.emit()


## Desactiva el puente (activa la colisión, bloquea el paso)
func desactivar() -> void:
	if not activo:
		return
	activo = false
	_set_colision_activa(true)
	puente_desactivado.emit()


## Alterna el estado del puente
func alternar() -> void:
	if activo:
		desactivar()
	else:
		activar()


func _set_colision_activa(activa: bool) -> void:
	if collision_shape:
		collision_shape.disabled = not activa

