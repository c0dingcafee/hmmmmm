extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXFALLSPEED = 300
const MAXSPEED = 160
const JUMPFORCE = 400
const ACCEL = 10
var motion = Vector2()
var facing_right = true

func _ready():
	pass


func _physics_process(delta):
		motion.y += GRAVITY
		if motion.y > MAXFALLSPEED:
			motion.y = MAXFALLSPEED

		motion.x = clamp(motion.x,-MAXSPEED,MAXSPEED)

		if Input.is_action_pressed("right"):
			motion.x += ACCEL
			facing_right = true
			$AnimatedSprite.play("walk")
		elif Input.is_action_pressed("left"):
			motion.x -= ACCEL
			facing_right = false
			$AnimatedSprite.play("walk")
		else:
			motion.x = lerp(motion.x,0,0.2)
			$AnimatedSprite.play("idle")

		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				motion.y = -JUMPFORCE
		if !is_on_floor():
			if motion.y < 0:
				$AnimatedSprite.play("jump")
			elif motion.y > 0:
				$AnimatedSprite.play("fall")

		motion = move_and_slide(motion,UP)
