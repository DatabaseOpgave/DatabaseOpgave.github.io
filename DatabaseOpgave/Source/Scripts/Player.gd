extends KinematicBody2D

var run_speed = 125
const JUMP_FORCE = -200
const JUMP_REALESE_FORCE = -300
const FALL_GRAVITY = 45

var state_machine

var dmg = 25

var velocity = Vector2.ZERO

func _ready():
	state_machine = $AnimationTree.get("parameters/playback")


	#ganger ikke med velocity med delta, da det allerede er indbygget i funktionen 
func _physics_process(_delta):
	apply_gravity()
	var input = Vector2.ZERO
	input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
	if !velocity.x == 0 and is_on_floor():
		state_machine.travel("Run")
	
	if input.x == 0:
		apply_friction()
		state_machine.travel("Idle")
	else:
		apply_acceleration(input.x)
	
	if input.x < 0:
		$Sprite.flip_h = true
	if input.x > 0:
		$Sprite.flip_h = false
	

	if is_on_floor(): 
		if Input.is_action_pressed("jump"):
			velocity.y = JUMP_FORCE
	#-y svarer til opad, is_on_floor sørger for man ikke kan hoppe som man vil. man kunne bruge "and"
		else:
			if Input.is_action_just_released("jump") and velocity.y < JUMP_REALESE_FORCE:
				velocity.y = JUMP_REALESE_FORCE
	#man kan lave nogle små hop, men det fikses med velocity.y < 0, da det er opad. ved at ændre 0 til andre værdier kan man stadig lave små hop til en hvis grænse
			if velocity.y > 0:
				velocity.y += FALL_GRAVITY
	#dette kode, gør så man falder hurtigere ned de positive tall er på vej ned, så man ikke gør det lige når man har noget makspunktet, 2. linje er det tal man lægger til gravity på vej ned
	if !is_on_floor():
		state_machine.travel("Jump")
	
	attack()
	die()
	velocity = move_and_slide(velocity, Vector2.UP)

func attack():
	if Input.is_action_pressed("Attack"):
		state_machine.travel("attack")

func apply_gravity():
	velocity.y += 4

func apply_friction():
	velocity.x = move_toward(velocity.x, 0, 15)
	
func apply_acceleration(amount):
	velocity.x = move_toward(velocity.x, 200 * amount, 15)
	
func hurt():
		state_machine.travel("Hurt")
	#skal tilføjes mere
	
func die():
	if GlobalScript.player_Health <= 0:
		state_machine.travel("die")
		position.x = 53
		position.y = 60
		GlobalScript.player_Health = 100

func give_damage():
	GlobalScript.player_damage

func _on_SwordHit_area_entered(area):
	if area.is_in_group("hurtbox"):
		area.give_damage()
