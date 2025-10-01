extends CharacterBody2D

const MOVE_SPEED := 300
const ACCELERATION : = 5.0

func _physics_process(delta: float) -> void:
	var direction := Vector2.ZERO
	direction.x = Input.get_axis("Left", "Right")
	direction.y = Input.get_axis("Up", "Down")
	direction = direction.normalized()
	
	velocity = lerp(velocity, direction * MOVE_SPEED, delta * ACCELERATION) 
	
	move_and_slide()
