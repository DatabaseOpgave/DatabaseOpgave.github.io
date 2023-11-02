extends KinematicBody2D

var gravity = 10
var velocity = Vector2(0,0)
var is_moving_right = true
var Health = 25

var speed = 32

func _ready():
	$AnimationPlayer.play("Walk")
	
func _process(delta):
	velocity.x = speed if is_moving_right else -speed
	velocity.y += gravity
	
	velocity = move_and_slide(velocity, Vector2.UP)
	detect_turn_around()
	
	die()

func detect_turn_around():
	if not $Blaaslime_raycast.is_colliding() and is_on_floor():
		is_moving_right = !is_moving_right
		scale.x = -scale.x
	
	if $Blaaslime_raycast_vaeg.is_colliding() and is_on_wall():
		is_moving_right = !is_moving_right
		scale.x = -scale.x
		$Sprite.flip_h = false
		
	
	
func die():
	if Health <= 0:
		queue_free()


func _on_hurtbox_area_entered(area):
	if area.name == "SwordHit":
		Health -= GlobalScript.player_damage


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		GlobalScript.player_Health -= 20
		print(GlobalScript.player_Health)
