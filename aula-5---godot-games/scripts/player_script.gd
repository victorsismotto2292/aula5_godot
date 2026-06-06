extends CharacterBody2D

# Configurações de movimento
var speed = 300.0
const JUMP_VELOCITY = -400.0

# Controle de estado
var is_dead = false

# Referências aos nós
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var camera_2d: Camera2D = $Camera2D

func _ready() -> void:
	print("Player pronto para a aventura!")

func die():
	if is_dead:
		return
		
	is_dead = true
	print("O personagem morreu!")
	
	# Desativar processamento e colisão
	set_physics_process(false)
	# Ocultar o personagem para dar feedback de morte
	animated_sprite_2d.visible = false
	
	# Pequeno atraso para o jogador ver a morte
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	# Adiciona gravidade
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Pulo
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Direção e Movimento
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	# Gerenciamento de Animações
	update_animations(direction)
	
	# Inverter o Sprite
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
			
	move_and_slide()

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")

# Função para o bônus de velocidade (conforme o PDF)
func apply_speed_boost(multiplier: float, duration: float):
	var original_speed = speed
	speed *= multiplier
	print("Bônus de velocidade ativado!")
	await get_tree().create_timer(duration).timeout
	speed = original_speed
	print("Bônus de velocidade encerrado.")
