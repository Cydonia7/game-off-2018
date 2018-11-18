extends Sprite

export var fireInterval = 0.5
export var bulletSpeed = 300.0

var screensize
var time = 0.0
var speed = 300

func _ready():
    screensize = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	var width = get_texture().get_width()
	
	position += velocity * delta * speed
	position.x = clamp(position.x, width / 2, screensize.x - width / 2)

	time += delta
	
	if time > fireInterval:
		time -= fireInterval
		
		if Input.is_key_pressed(KEY_SPACE):
			fire_all()

func fire_all():
	var missiles = get_number_of_missiles()
	
	if missiles != 2:
		fire('center')
	if missiles != 1:
		fire('left')
		fire('right')

func get_number_of_missiles():
	if get_game_manager().has_upgrade('three_missiles'):
		return 3
	
	if get_game_manager().has_upgrade('two_missiles'):
		return 2
	
	return 1

func fire(spawn):
	if spawn == 'left':
		spawn = $LeftSpawn
	elif spawn == 'right':
		spawn = $RightSpawn
	else:
		spawn = $Spawn
	
	var bullet = preload('res://Bullet.tscn').instance()
	bullet.set_position(spawn.get_global_transform_with_canvas().get_origin())
	bullet.set_rotation(spawn.get_global_transform_with_canvas().get_rotation())
	bullet.life = 10.0
	bullet.velocity = Vector2(0, -1) * bulletSpeed
	get_parent().add_child(bullet)

func get_game_manager():
	return get_tree().get_nodes_in_group("game_manager")[0]
