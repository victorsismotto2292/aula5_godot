extends CanvasLayer

var coins = 0

@onready var coin_label = $Control/CoinLabel

func _ready():
	# Inicializa o texto
	update_coin_text()

func update_coin_text():
	coin_label.text = "Moedas: " + str(coins)

# Função que será chamada quando o sinal 'collected' da moeda for emitido
func _on_coin_collected():
	coins += 1
	update_coin_text()
	print("HUD atualizada: ", coins)
