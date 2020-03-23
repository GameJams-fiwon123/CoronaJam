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



class Design_10_10_PlayerFollowMouse extends ActorScript
{
	public var _Player:Actor;
	public var _Up:String;
	public var _Right:String;
	public var _Down:String;
	public var _Left:String;
	public var _RegionUp:Region;
	public var _RegionRight:Region;
	public var _RegionDown:Region;
	public var _RegionLeft:Region;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Player", "_Player");
		nameMap.set("Up", "_Up");
		_Up = "";
		nameMap.set("Right", "_Right");
		_Right = "";
		nameMap.set("Down", "_Down");
		_Down = "";
		nameMap.set("Left", "_Left");
		_Left = "";
		nameMap.set("RegionUp", "_RegionUp");
		nameMap.set("RegionRight", "_RegionRight");
		nameMap.set("RegionDown", "_RegionDown");
		nameMap.set("RegionLeft", "_RegionLeft");
		
	}
	
	override public function init()
	{
		
		/* ========================== On Region =========================== */
		addMouseOverActorListener(_RegionUp, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 1 == mouseState)
			{
				_Player.setAnimation(_Up);
			}
		});
		
		/* ========================== On Region =========================== */
		addMouseOverActorListener(_RegionRight, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 1 == mouseState)
			{
				_Player.setAnimation(_Right);
			}
		});
		
		/* ========================== On Region =========================== */
		addMouseOverActorListener(_RegionDown, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 1 == mouseState)
			{
				_Player.setAnimation(_Down);
			}
		});
		
		/* ========================== On Region =========================== */
		addMouseOverActorListener(_RegionLeft, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 1 == mouseState)
			{
				_Player.setAnimation(_Left);
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}