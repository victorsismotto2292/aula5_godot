extends Node2D

@onready var hud = $HUD

func _ready():
	# Procurar por todas as moedas na cena e conectar o sinal à HUD
	# Isso é uma forma automática de fazer o que o PDF pede via editor
	var coins = get_tree().get_nodes_in_group("coins")
	for coin in coins:
		coin.collected.connect(hud._on_coin_collected)

# Se novas moedas forem instanciadas dinamicamente, você pode chamar esta função
func connect_coin(coin):
	if not coin.collected.is_connected(hud._on_coin_collected):
		coin.collected.connect(hud._on_coin_collected)
