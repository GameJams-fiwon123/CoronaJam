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



class Design_28_28_UIClicked extends ActorScript
{
	public var _Water:Actor;
	public var _Jail:Actor;
	public var _UiRegion:Region;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Water", "_Water");
		nameMap.set("Jail", "_Jail");
		nameMap.set("UiRegion", "_UiRegion");
		
	}
	
	override public function init()
	{
		
		/* ======================== When Creating ========================= */
		_Water.alpha = 100 / 100;
		_Jail.alpha = 50 / 100;
		
		/* ========================== On Region =========================== */
		addMouseOverActorListener(_UiRegion, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 1 == mouseState)
			{
				hideTileLayer(engine.getLayerById(2));
				showCursor();
			}
		});
		
		/* ========================== On Region =========================== */
		addMouseOverActorListener(_UiRegion, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && -1 == mouseState)
			{
				showTileLayer(engine.getLayerById(2));
				hideCursor();
			}
		});
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(_Jail, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				if(((actor.getLayerID() > asNumber((getGameAttribute("layer")))) && (actor.getZIndex() > asNumber((getGameAttribute("zOrder"))))))
				{
					setGameAttribute("layer", actor.getLayerID());
					setGameAttribute("zOrder", actor.getZIndex());
					_Water.alpha = 50 / 100;
					_Jail.alpha = 100 / 100;
					setGameAttribute("isUsingWater", false);
					playSound(getSound(55));
				}
			}
		});
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(_Water, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 3 == mouseState)
			{
				if(((actor.getLayerID() > asNumber((getGameAttribute("layer")))) || ((actor.getLayerID() == ((getGameAttribute("layer")) : Dynamic)) && (actor.getZIndex() > asNumber((getGameAttribute("zOrder")))))))
				{
					setGameAttribute("layer", actor.getLayerID());
					setGameAttribute("zOrder", actor.getZIndex());
					_Water.alpha = 100 / 100;
					_Jail.alpha = 50 / 100;
					setGameAttribute("isUsingWater", true);
					playSound(getSound(54));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}