/* ***********************************************************************
Flash CS4 tutorial by Doug Ensley and Barbara Kaskosz

http://www.flashandmath.com/

Last modified: October, 2010
************************************************************************ */

package flashandmath.as3 {
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldType;
	import flash.geom.Point;
	import flash.geom.PerspectiveProjection;
	
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
	import fl.transitions.easing.*;
	
    public class PlayingCard extends Sprite {
		
	    private var bdFirst:BitmapData;
		private var bdSecond:BitmapData;
		  
		private var _isFaceUp:Boolean;
		private var _value:String;
		private var _numValue:int;
		private var _suit:String;
		
		private var picWidth:Number;
		private var picHeight:Number;
		
		private var holder:Sprite;  
		private var side0:Sprite;
  		private var side1:Sprite;
		
		private var side0Img:Bitmap;
  		private var side1Img:Bitmap;
		
		private var twx:Tween;
		private var twy:Tween;
		private var twz:Tween;
		
		private var pp:PerspectiveProjection;
		  
	    public function PlayingCard(bmdFace:BitmapData,bmdBack:BitmapData){	
		
			twx = new Tween(this, "x", None.easeIn, 0, 1, 1, true);
			twy = new Tween(this, "y", None.easeIn, 0, 1, 1, true);
			twz = new Tween(this, "z", None.easeIn, 0, 1, 1, true);
			
			side0Img=new Bitmap(bmdFace);
			side1Img=new Bitmap(bmdBack);
			
  			picWidth=side0Img.width;
		  	picHeight=side0Img.height;
			
			holder=new Sprite();
		  	this.addChild(holder);
			
			holder.x=picWidth/2;
			holder.y=picHeight/2;
			
		  	side0=new Sprite();
		  	holder.addChild(side0);
			
		  	side0Img.x=-picWidth/2;
		  	side0Img.y=-picHeight/2;
			
			side0.x=0;
			side0.y=0;
			
			side0.addChild(side0Img);
			side1=new Sprite();
			
		  	holder.addChild(side1);
			
		  	side1Img.x=-picWidth/2;
		  	side1Img.y=-picHeight/2;
			
			side1.x=0;
			side1.y=0;
			
			side1.addChild(side1Img);
			
			//In order to appear correctly after a flip, the back side has to be
			//rotated initially.
			
			side1.rotationX = 180;
		  
			_isFaceUp = true;
			_value = "";
			_numValue = 0;
			_suit = "";
			
			//Each instance of the class has its own PerspectiveProjection object.
			
			pp=new PerspectiveProjection();
			pp.fieldOfView=60;
			pp.projectionCenter=new Point(picWidth/2,picHeight/2);
			this.transform.perspectiveProjection=pp;
			
		  	rotateView(0,"horizontal");	
		}
		
		//End of constructor.
		
		public function tweenMotion(sx:Number,sy:Number,sz:Number,fx:Number,fy:Number,fz:Number,sec:Number):void {
			
			twx.stop();
			twx.rewind();
			twx.begin = sx;
			twx.finish = fx;
			twx.duration = sec;
			
			twy.stop();
			twy.rewind();
			twy.begin = sy;
			twy.finish = fy;
			twy.duration = sec;

			twz.stop();
			twz.rewind();
			twz.begin = sz;
			twz.finish = fz;
			twz.duration = sec;

			twx.start();
			twy.start();
			twz.start();
		}
		
		//The function InitApp is running after images are successfully loaded.
		public function switchSideUp():void {
			_isFaceUp = !_isFaceUp;
		}
		
		public function get isFaceUp():Boolean {
			return _isFaceUp;
		}
		
		public function get value():String {
			return _value;
		}
		
		public function set value(v:String):void {
			_value = v;
		}
		
		public function get numValue():int {
			return _numValue;
		}
		
		public function set numValue(v:int):void {
			_numValue = v;
		}
				
		public function get suit():String {
			return _suit;
		}
		
		public function set suit(s:String):void {
			_suit = s;
		}

		public function makeFaceUp():void {
			rotateView(0,"horizontal");
			_isFaceUp = true;
		}

		public function makeFaceDown():void {
			rotateView(180,"horizontal");
			_isFaceUp = false;
		}

		public function rotateView(t:Number,spinType:String="vertical"):void {
			if ( (t < 90) || (t > 270) ) {
				side0.visible = true;
				side1.visible = false;
			}
			else {
				side0.visible = false;
				side1.visible = true;
			}
			
			if(spinType=="vertical") {
				holder.rotationX = 0;
			 	holder.rotationY = t; } 
			else {
				holder.rotationY = 0;
				holder.rotationX = t;
			}
			//trace("     visible 0:", side0.visible, "visible 1:", side1.visible);
  		}
	}
}