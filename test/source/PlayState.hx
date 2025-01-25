package;
import sys.io.File;
import hxopus.Opus;
import flixel.sound.FlxSound;
import flixel.FlxState;

class PlayState extends FlxState {

	override public function create() {
		super.create();
		var time:Float = Sys.time();
		var sound:FlxSound = new FlxSound();
		sound.loadEmbedded(Opus.toOpenFL(File.getBytes("assets/music/shockwaveshuffle.opus")));
		sound.play();
		trace(Sys.time() - time);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
	}
}
