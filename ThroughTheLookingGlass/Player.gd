extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 65.0

# Get the gravity from the project settings to be synced with RigidDynamicBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var animation_locked : bool = false
var direction : Vector2 = Vector2.ZERO
var glasses : bool = false


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("walk_left", "walk_right",  "", "")
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
	update_glasses()
	update_animation()
	update_direction()

func update_animation():
	if not glasses:
		if not animation_locked:
			if direction != Vector2.ZERO:
				animated_sprite.play("walk")
			else:
				animated_sprite.play("idle")
	else:
		if not animation_locked:
			if direction != Vector2.ZERO:
				animated_sprite.play("glasses_walk")
			else:
				animated_sprite.play("glasses_idle")
			
func update_direction():
	if direction.x < 0:
		animated_sprite.flip_h = true
	elif direction.x > 0:
		animated_sprite.flip_h = false

func update_glasses():
	if Input.is_action_just_pressed("glasses"):
		glasses = not glasses

