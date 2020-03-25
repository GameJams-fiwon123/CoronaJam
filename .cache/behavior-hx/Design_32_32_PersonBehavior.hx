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



class Design_32_32_PersonBehavior extends ActorScript
{
	public var _isInfected:Bool;
	public var _DiagonalSpeed:Float;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("isInfected", "_isInfected");
		_isInfected = false;
		nameMap.set("DiagonalSpeed", "_DiagonalSpeed");
		_DiagonalSpeed = 0;
		
	}
	
	override public function init()
	{
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				_DiagonalSpeed = Utils.DEG * (Math.atan2(actor.getYVelocity(), actor.getXVelocity()));
				if((((_DiagonalSpeed >= -45) && (_DiagonalSpeed <= 45)) || (((_DiagonalSpeed >= 315) && (_DiagonalSpeed <= 360)) || ((_DiagonalSpeed >= -360) && (_DiagonalSpeed <= -315)))))
				{
					if(_isInfected)
					{
						actor.setAnimation("RightDoente");
					}
					else
					{
						actor.setAnimation("RightSaudavel");
					}
				}
				else if((((_DiagonalSpeed >= -225) && (_DiagonalSpeed <= -135)) || ((_DiagonalSpeed >= 135) && (_DiagonalSpeed <= 225))))
				{
					if(_isInfected)
					{
						actor.setAnimation("LeftDoente");
					}
					else
					{
						actor.setAnimation("LeftSaudavel");
					}
				}
				else if((((_DiagonalSpeed >= -134) && (_DiagonalSpeed <= -46)) || ((_DiagonalSpeed >= 226) && (_DiagonalSpeed <= 314))))
				{
					if(_isInfected)
					{
						actor.setAnimation("UpDoente");
					}
					else
					{
						actor.setAnimation("UpSaudavel");
					}
				}
				else if((((_DiagonalSpeed >= -314) && (_DiagonalSpeed <= -226)) || ((_DiagonalSpeed >= 46) && (_DiagonalSpeed <= 134))))
				{
					if(_isInfected)
					{
						actor.setAnimation("DownDoente");
					}
					else
					{
						actor.setAnimation("DownSaudavel");
					}
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.drawString("" + _DiagonalSpeed, 0, 0);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}