extends Sprite3D

func _ready():
	$AnimationPlayer.play("Explode")
	$AudioStreamPlayer3D.pitch_scale = randf_range(0.9,1.1)
	$AudioStreamPlayer3D.play()
	

func _on_audio_stream_player_3d_finished():
	queue_free()
	pass # Replace with function body.
