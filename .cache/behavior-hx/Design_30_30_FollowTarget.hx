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



class Design_30_30_FollowTarget extends ActorScript
{
	public var _TargetActor:Actor;
	public var _DistanceX:Float;
	public var _DistanceY:Float;
	public var _Distance:Float;
	public var _Direction:Float;
	public var _Speed:Float;
	public var _Margin:Float;
	public var _Easing:Bool;
	public var _MinimumEasingSpeed:Float;
	public var _ScreenDiagonal:Float;
	public var _StopwhenColliding:Bool;
	public var _Collided:Bool;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Target Actor", "_TargetActor");
		nameMap.set("Distance X", "_DistanceX");
		_DistanceX = 0.0;
		nameMap.set("Distance Y", "_DistanceY");
		_DistanceY = 0.0;
		nameMap.set("Distance", "_Distance");
		_Distance = 0.0;
		nameMap.set("Direction", "_Direction");
		_Direction = 0.0;
		nameMap.set("Speed", "_Speed");
		_Speed = 30.0;
		nameMap.set("Margin", "_Margin");
		_Margin = 0.0;
		nameMap.set("Easing", "_Easing");
		_Easing = true;
		nameMap.set("Minimum Easing Speed", "_MinimumEasingSpeed");
		_MinimumEasingSpeed = 5.0;
		nameMap.set("Screen Diagonal", "_ScreenDiagonal");
		_ScreenDiagonal = 0.0;
		nameMap.set("Stop when Colliding", "_StopwhenColliding");
		_StopwhenColliding = true;
		nameMap.set("Collided", "_Collided");
		_Collided = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_ScreenDiagonal = Math.sqrt((Math.pow(getScreenWidth(), 2) + Math.pow(getScreenHeight(), 2)));
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if(((hasValue(_TargetActor)) && _TargetActor.isAlive()))
				{
					_DistanceX = (_TargetActor.getXCenter() - actor.getXCenter());
					_DistanceY = (_TargetActor.getYCenter() - actor.getYCenter());
					_Distance = Math.sqrt((Math.pow(_DistanceX, 2) + Math.pow(_DistanceY, 2)));
					_Direction = Utils.DEG * (Math.atan2(_DistanceY, _DistanceX));
					if(((_Distance > _Margin) && !((_StopwhenColliding && _Collided))))
					{
						if(_Easing)
						{
							actor.setVelocity(_Direction, (_MinimumEasingSpeed + (_Speed * ((_Distance - _Margin) / _ScreenDiagonal))));
						}
						else
						{
							actor.setVelocity(_Direction, _Speed);
						}
					}
					else
					{
						actor.setVelocity(0, 0);
					}
					_Collided = false;
				}
			}
		});
		
		/* ======================== Specific Actor ======================== */
		addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && (_TargetActor == event.otherActor))
			{
				_Collided = true;
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}