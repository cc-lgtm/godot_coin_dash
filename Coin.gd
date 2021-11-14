extends Area2D

export(int) var screen_size

func pick_up():
	queue_free()

func _on_Coin_area_entered(area):
	pass
