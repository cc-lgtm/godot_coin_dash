extends Area2D

signal pick_up
signal hurt
signal Pow

export(int) var speed = 250
export(PackedScene) var PickUpAudio
var scress_size = Vector2(480, 720)
var vector = Vector2()

func get_input():
	vector = Vector2()
	if Input.is_action_pressed("ui_right"):
		vector.x += 1
	if Input.is_action_pressed("ui_left"):
		vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		vector.y += 1
	if Input.is_action_pressed("ui_up"):
		vector.y -= 1
	if vector.length() > 0:
		vector = vector.normalized() * speed

func _process(delta):
	get_input()
	position += vector * delta
	position.x = clamp(position.x, 0, scress_size.x)
	position.y = clamp(position.y, 0, scress_size.y)
	if vector.length() > 0:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = vector.x < 0
	else:
		$AnimatedSprite.play("idle")

func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = 'idle'

func die():
	$AnimatedSprite.animation = 'hurt'
	set_process(false)


func _on_Player_area_entered(area):
	if area.is_in_group('coins'):
		area.pick_up()
		$Pick.play()
		emit_signal('pick_up')
	if area.is_in_group('obstacles'):
		emit_signal('hurt')
		$Die.play()
		die()
	if area.is_in_group('pow'):
		area.pick_up()
		$Pow.play()
		speed += 10
		emit_signal('Pow')
