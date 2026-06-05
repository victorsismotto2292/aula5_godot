extends CharacterBody2D # VARIÁVEL

# CHARACTERBODY2D VEM CÓDIGOS PRONTOS PARA SEREM REUTILIZADOS, COMO SE FOSSE UMA HERANÇA

# TIPOS DE VARIÁVEIS:
#var speed = 200 - Tipagem dinâmica
#var speed: int = 200 - Tipagem explícita
#var speed := 200 - Tipagem inferida (deduzida) pela Godot
#const speed = 200 - Constante, não pode ser alterada (geralmente padronizada com letras maíúsculas)


const SPEED = 300.0 # VARIÁVEL // CONSTANTE
const JUMP_VELOCITY = -400.0 # VARIÁVEL // CONSTANTE

@onready var camera_2d: Camera2D = $Camera2D  # FUNÇÃO REFERENCIAL À NÓ (CÂMERA)
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D # FUNÇÃO REFERENCIAL À NÓ (ANIMAÇÃO)

# @onready - só é inicializada quando a cena já está pronta
# @export - aparece no Inspector

# NOVO CÓDIGO A PARTIR DAQUI:

func _ready() -> void: # FUNÇÃO INICIAL DO JOGO, INICIA E REINICIA
	# NO JAVASCRIPT - CONSOLE.LOG, NO GDSACRIPT, USAMOS PRINT
	print("Player criado!") # ENVIA UMA MENSAGEM NA SAÍDA DO CONSOLE AO EXECUTAR O JOGO
	
	# TESTANDO VARIÁVEIS
	var vidas: int = 100 # CRIANDO UMA VARIÁVEL CHAMADA "VIDAS" DO TIPO "NÚMERO INTEIRO" COM O VALOR: 100
	# A VARIÁVEL PODE FICAR FORA DA FUNÇÃO
	print(vidas) # ENVIANDO VALOR PARA SER EXIBIDO NO CONSOLE
	# CONCATENANDO A VARIÁVEL:
	print("Vidas: " + str(vidas)) # EXIBINDO NO CONSOLE
	
 # TÉRMINO CÓDIGO NOVO
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	# ALTERA A ANIMAÇÃO
	if is_on_floor():
		if direction == 0:
			animated_sprite_2d.play("idle")
		else:
			animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("jump")
	
	# INVERTE O SPRITE
	if direction > 0:
		animated_sprite_2d.flip_h = false
	elif direction < 0:
		animated_sprite_2d.flip_h = true
			
	move_and_slide()
