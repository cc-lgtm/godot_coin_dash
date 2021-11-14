extends Area2D

signal die
export(int) var screen_size

func _on_Hurt_area_entered(area):
	emit_signal('die')
