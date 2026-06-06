extends CharacterBody2D

const SPEED = 80.0
const GRAVITY = 800.0

var direction = 1

@onready var floor_left = $FloorLeft # mesmo nome do nó
@onready var floor_right = $FloorRight
@onready var anim = $AnimatedSprite2D

	func _physics_process(delta):
		# Física para o inimigo detectar o chão
		if not is_on_floor():
			velocity.y += GRAVITY * delta
			
		# Inverter ao detectar borda ou parede
		if is_on_wall() or (is_on_floor() and not floor_left.is_colliding() and direction == -1):
			direction = 1
		elif is_on_wall() or (is_on_floor() and not floor_right.is_colliding() and direction == 1):
			direction = -1
	# Aplicando velocidade no eixo x:
	velocity.x = direction * SPEED
	anim.flip_h = direction > 0
	anim.play("walk")
	
	move_and_slide()
