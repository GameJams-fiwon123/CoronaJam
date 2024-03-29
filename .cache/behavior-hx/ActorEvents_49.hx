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



class ActorEvents_49 extends ActorScript
{
	public var _startDie:Bool;
	public var _startQuarantine:Bool;
	public var _isInfected:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("startDie", "_startDie");
		_startDie = false;
		nameMap.set("startQuarantine", "_startQuarantine");
		_startQuarantine = false;
		nameMap.set("isInfected", "_isInfected");
		_isInfected = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		loopSoundOnChannel(getSound(60), 2);
		
		/* ======================== Actor of Type ========================= */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && sameAsAny(getActorType(33), event.otherActor.getType(),event.otherActor.getGroup()))
			{
				if(!(_startDie))
				{
					event.otherActor.setValue("PersonBehavior", "_isInfected", true);
					loopSoundOnChannel(getSound(59), 1);
					event.otherActor.moveToLayer(engine.getLayerById(7));
					recycleActor(actor);
				}
			}
		});
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(actor, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				if(((actor.getLayerID() > asNumber((getGameAttribute("layer")))) || ((actor.getLayerID() == ((getGameAttribute("layer")) : Dynamic)) && (actor.getZIndex() > asNumber((getGameAttribute("zOrder")))))))
				{
					setGameAttribute("layer", actor.getLayerID());
					setGameAttribute("zOrder", actor.getZIndex());
					if((((getGameAttribute("isUsingWater")) : Bool) && !(_startDie)))
					{
						actor.setAnimation("Die");
						_startDie = true;
						actor.setVelocity(0, 0);
						setGameAttribute("coronaDie", ((Engine.engine.getGameAttribute("coronaDie") : Float) + 1));
						playSound(getSound(56));
					}
					else if(!(_startDie))
					{
						playSound(getSound(58));
					}
				}
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(_startDie)
				{
					if(!(actor.isAnimationPlaying()))
					{
						recycleActor(actor);
						if((engine.getNumberOfActorsWithinLayer(engine.getLayerById(8)) == 0))
						{
							stopSoundOnChannel(2);
						}
					}
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}