package org.zamedev.particles.internal;

import openfl.display.Tilemap;
#if !flash
import openfl.display.DisplayObject;

class TilemapExt extends Tilemap {
	#if (openfl >= "9.0.0")
	private override function __hitTest(x:Float, y:Float, shapeFlag:Bool, stack:Array<DisplayObject>, interactiveOnly:Bool, hitObject:DisplayObject):Bool {
		return false;
	}
	#else
	private override function __hitTest(x:Float, y:Float, shapeFlag:Bool, stack:Array<DisplayObject>, interactiveOnly:Bool, hitObject:DisplayObject,
			hitTestWhenMouseDisabled:Bool = false):Bool {
		return false;
	}
	#end
}
#else
typedef TilemapExt = Tilemap;
#end
