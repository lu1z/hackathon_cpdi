extends AudioStreamPlayer


const main_music = preload("res://assets/Audio/MUSIC - AXIS1006_24_Violet_And_Blue_Full.mp3")
const click_button_sound = preload("res://assets/Audio/botao.mp3")




func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	else:
		stream = music
		volume_db = SettingsManager.volume
		bus = "Musicbus"
		play()

func play_main_music():
	_play_music(main_music)
	

func play_button():
	var button_audio_streamplayer = AudioStreamPlayer.new()
	button_audio_streamplayer.stream = click_button_sound
	button_audio_streamplayer.bus = "SFXbus"
	button_audio_streamplayer.volume_db = SettingsManager.sfx_volume
	$".".add_child(button_audio_streamplayer)
	button_audio_streamplayer.play()
	await button_audio_streamplayer.finished
	button_audio_streamplayer.queue_free()

