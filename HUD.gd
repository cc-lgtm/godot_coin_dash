extends CanvasLayer

signal start_game

export(int) var time_text = 30
export(int) var scroce_text = 0

func _ready():
	$Time.text = str(time_text)
	$scroce.text = str(scroce_text)
	
func update_scroce(scroce):
	$scroce.text = str(scroce)
	
func update_time_left(time_left):
	$Time.text = str(time_left)

func _on_GameStart_button_down():
	emit_signal('start_game')
