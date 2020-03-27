package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;
import com.stencyl.graphics.ScaleMode;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Config;
import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.motion.*;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_0 extends SceneScript
{
	public var _posSpawn:Float;
	public var _posSpawnY:Float;
	public var _dirSpawn:Float;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("posSpawnX", "_posSpawn");
		_posSpawn = 0.0;
		nameMap.set("posSpawnY", "_posSpawnY");
		_posSpawnY = 0.0;
		nameMap.set("dirSpawn", "_dirSpawn");
		_dirSpawn = 0.0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		loopSound(getSound(41));
		hideCursor();
		setGameAttribute("isPlaying", true);
		setGameAttribute("isUsingWater", true);
		setGameAttribute("jailPerson", 0);
		setGameAttribute("savePersons", 0);
		setGameAttribute("coronaDie", 0);
		setGameAttribute("level", 1);
		setGameAttribute("zOrder", -1);
		setGameAttribute("layer", -1);
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.drawString("" + ((getGameAttribute("totalSpawn")) : Dynamic), 540, 540);
			}
		});
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * randomFloatBetween(1, 4), function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if(((getGameAttribute("isPlaying")) : Bool))
				{
					setGameAttribute("totalSpawn", (asNumber((getGameAttribute("totalSpawn"))) + 1));
					if((((asNumber((getGameAttribute("totalSpawn"))) % 30) == 0) && (asNumber((getGameAttribute("level"))) < asNumber((getGameAttribute("maxLevel"))))))
					{
						setGameAttribute("" + (getGameAttribute("level")), (asNumber((getGameAttribute("level"))) + 1));
					}
					for(index0 in 0...Std.int(asNumber((getGameAttribute("level")))))
					{
						_dirSpawn = randomInt(0, 3);
						if((_dirSpawn == 0))
						{
							_posSpawn = randomInt(0, 1080);
							_posSpawnY = 0;
							createRecycledActorOnLayer(getActorType(33), _posSpawn, _posSpawnY, engine.getLayerById(6));
						}
						else if((_dirSpawn == 1))
						{
							_posSpawn = 1080;
							_posSpawnY = randomInt(0, 1080);
							createRecycledActorOnLayer(getActorType(33), _posSpawn, _posSpawnY, engine.getLayerById(6));
						}
						else if((_dirSpawn == 2))
						{
							_posSpawn = randomInt(0, 1080);
							_posSpawnY = 1080;
							createRecycledActorOnLayer(getActorType(33), _posSpawn, _posSpawnY, engine.getLayerById(6));
						}
						else if((_dirSpawn == 3))
						{
							_posSpawn = 0;
							_posSpawnY = randomInt(0, 1080);
							createRecycledActorOnLayer(getActorType(33), _posSpawn, _posSpawnY, engine.getLayerById(6));
						}
					}
				}
			}
		}, null);
		
		/* ======================= Every N seconds ======================== */
		runPeriodically(1000 * randomFloatBetween(1, 4), function(timeTask:TimedTask):Void
		{
			if(wrapper.enabled)
			{
				if(((getGameAttribute("isPlaying")) : Bool))
				{
					setGameAttribute("totalSpawn", (asNumber((getGameAttribute("totalSpawn"))) + 1));
					if((((asNumber((getGameAttribute("totalSpawn"))) % 30) == 0) && (asNumber((getGameAttribute("level"))) < asNumber((getGameAttribute("maxLevel"))))))
					{
						setGameAttribute("" + (getGameAttribute("level")), (asNumber((getGameAttribute("level"))) + 1));
					}
					for(index0 in 0...Std.int(asNumber((getGameAttribute("level")))))
					{
						_dirSpawn = randomInt(0, 3);
						if((_dirSpawn == 0))
						{
							_posSpawn = randomInt(0, 1080);
							_posSpawnY = 0;
							createRecycledActorOnLayer(getActorType(49), _posSpawn, _posSpawnY, engine.getLayerById(8));
						}
						else if((_dirSpawn == 1))
						{
							_posSpawn = 1080;
							_posSpawnY = randomInt(0, 1080);
							createRecycledActorOnLayer(getActorType(49), _posSpawn, _posSpawnY, engine.getLayerById(8));
						}
						else if((_dirSpawn == 2))
						{
							_posSpawn = randomInt(0, 1080);
							_posSpawnY = 1080;
							createRecycledActorOnLayer(getActorType(49), _posSpawn, _posSpawnY, engine.getLayerById(8));
						}
						else if((_dirSpawn == 3))
						{
							_posSpawn = 0;
							_posSpawnY = randomInt(0, 1080);
							createRecycledActorOnLayer(getActorType(49), _posSpawn, _posSpawnY, engine.getLayerById(8));
						}
					}
				}
			}
		}, null);
		
		/* ============================ Click ============================= */
		addMouseReleasedListener(function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				setGameAttribute("layer", -1);
				setGameAttribute("zOrder", -1);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}