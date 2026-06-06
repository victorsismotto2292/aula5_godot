extends Area2D

# Novo sinal criado
signal collected

@onready var particles = $Particles
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

func _ready():
	# Adiciona ao grupo para o level gerenciar os sinais
	add_to_group("coins")
	# Conecta o sinal de entrada de corpo
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	# Verifica se quem colidiu foi o Player
	if body.name == "Player":
		print("+1 moeda!")
		
		# Emite o sinal de que foi coletada (para a HUD)
		collected.emit()
		
		# Feedback visual e sonoro (opcional)
		# Deixa a moeda invisível e desabilita colisão
		sprite.visible = false
		collision.set_deferred("disabled", true)
		
		# Se houver partículas, ativa e espera terminar
		if particles:
			particles.emitting = true
			# Se as partículas forem "One Shot", podemos esperar o sinal 'finished'
			# Mas como o sandbox não roda o jogo, vamos usar um timer seguro ou await se disponível
			if particles.one_shot:
				await get_tree().create_timer(particles.lifetime).timeout
		
		# Remove a moeda da cena
		queue_free()
