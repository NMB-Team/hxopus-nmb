package hxopus;

import cpp.Lib;
import haxe.io.Bytes;
import openfl.media.Sound;
import openfl.utils.Assets;
import openfl.utils.ByteArray;

class Opus {
	public static function getVersionString():String {
		return _getVersionString();
	}

	public static function toOpenFL(bytes:Bytes) {
		var sound:Sound = new Sound();

		var bytesPerSample:Int = 2;
		var channels:Int = 2;
		var rate:Int = 48000;

		var bytes:Bytes = Bytes.ofData(decode(bytes.getData(), rate));

		trace(bytes);

		sound.loadPCMFromByteArray(ByteArray.fromBytes(bytes), Std.int(bytes.length / (bytesPerSample * channels)), "short", (channels == 2), rate);

		return sound;
	}

	static var _getVersionString = Lib.load("hxopus", "hxopus_get_version_string", 0);
	static var decode = Lib.load("hxopus", "hxopus_to_bytes_data", 2);
}
