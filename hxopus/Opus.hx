package hxopus;

import sys.io.File;
import haxe.io.BytesData;
import cpp.Lib;
import haxe.io.Bytes;
#if openfl
import openfl.media.Sound;
import openfl.utils.ByteArray;
#end
#if flixel
import flixel.sound.FlxSound;
#end

class Opus {
	/**
	 * Gets the current version of libopus.
	 * @return String
	 */
	public static inline function getVersionString():String {
		return _getVersion();
	}

	/**
	 * Decodes the audio data and returns it as bytes.
	 * @param encodedBytes 
	 * @return BytesData
	 */
	public static inline function getDecodedBytes(encodedBytes:Bytes):BytesData {
		return _decodeBytes(encodedBytes.getData());
	}

	#if openfl
	/**
	 * Returns a new OpenFL `Sound` object.
	 * @param bytes The raw bytes to decode.
	 * @return Sound
	 */
	public overload extern inline static function toOpenFL(bytes:Bytes):Sound {
		return returnSound(Bytes.ofData(getDecodedBytes(bytes)));
	}

	/**
	 * Returns a new OpenFL `Sound` object.
	 * @param file The name of the file to load.
	 * @return Sound
	 */
	public overload extern inline static function toOpenFL(file:String):Sound {
		return returnSound(Bytes.ofData(getDecodedBytes(File.getBytes(file))));
	}

	private static function returnSound(frames:Bytes):Sound {
		var sound:Sound = new Sound();
		// 4 because 2 channels (stereo) times 2 bytes per pcm frame (short16)
		var frameCount:Int = Math.floor(frames.length / 4);
		sound.loadPCMFromByteArray(ByteArray.fromBytes(frames), frameCount, "short", true, 48000);
		return sound;
	}
	#end

	#if flixel
	/**
	 * Returns a new `FlxSound` object.
	 * @param bytes The raw bytes to decode.
	 * @param looped Should the audio loop?
	 * @param autoDestroy Should the `FlxSound` instance should destroy on state close.
	 * @param onComplete Called when finished playing,
	 * @return FlxSound
	 */
	public overload extern inline static function toFlxSound(bytes:Bytes, looped:Bool = false, autoDestroy:Bool = false, ?onComplete:Void->Void):FlxSound {
		return new FlxSound().loadEmbedded(toOpenFL(bytes), looped, autoDestroy, onComplete);
	}

	/**
	 * Returns a new `FlxSound` object.
	 * @param file The name of the file to open.
	 * @param looped Should the audio loop?
	 * @param autoDestroy Should the `FlxSound` instance should destroy on state close.
	 * @param onComplete Called when finished playing,
	 * @return FlxSound
	 */
	public overload extern inline static function toFlxSound(file:String, looped:Bool = false, autoDestroy:Bool = false, ?onComplete:Void->Void):FlxSound {
		return new FlxSound().loadEmbedded(toOpenFL(file), looped, autoDestroy, onComplete);
	}
	#end

	private static var _getVersion:Dynamic = Lib.load("hxopus", "hxopus_get_version_string", 0);
	private static var _decodeBytes:Dynamic = Lib.load("hxopus", "hxopus_to_bytes", 1);
}
