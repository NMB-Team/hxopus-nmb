package hxopus;

import cpp.Lib;
import haxe.io.Bytes;
import openfl.media.Sound;
import openfl.utils.ByteArray;

class Opus {
	public static function getVersionString():String {
		return _getVersion();
	}

	public static function toOpenFL(bytes:Bytes):Sound {
		var sound:Sound = new Sound();
		var frames:Bytes = Bytes.ofData(_decodeBytes(bytes.getData()));

		// 4 because 2 channels (stereo) times 2 bytes per pcm frame (short16)
		var frameCount:Int = Math.floor(frames.length / 4);
		sound.loadPCMFromByteArray(ByteArray.fromBytes(frames), frameCount, "short", true, 48000);
		return sound;
	}

	private static var _getVersion:Dynamic = Lib.load("hxopus", "hxopus_get_version_string", 0);
	private static var _decodeBytes:Dynamic = Lib.load("hxopus", "hxopus_to_bytes", 1);
}
