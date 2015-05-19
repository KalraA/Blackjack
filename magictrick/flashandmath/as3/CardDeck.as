/* ***********************************************************************
AS3 Flash CS4 tutorial by Doug Ensley

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
	import flash.filters.DropShadowFilter;
	
	import flash.geom.Point;
	import flash.geom.PerspectiveProjection;
	
	//We will use our custom class, ImageLoader to load bitmaps at runtime.
	
	import flashandmath.as3.ImageLoader;

	import flash.utils.Timer;
	import flash.events.TimerEvent; 
	
	public class CardDeck extends Sprite {
		private var imgLoader:ImageLoader;
		private var arrCards:Array;
		
		public static const CARDS_LOADED:String = "imgsLoaded";
		public static const LOAD_ERROR:String = "loadError";

		public function CardDeck(arrImages:Array, stBackFile:String) {
			arrCards = new Array();
			imgLoader = new ImageLoader();
			imgLoader.addEventListener(ImageLoader.LOAD_ERROR,errorLoading);
		   	imgLoader.addEventListener(ImageLoader.IMGS_LOADED,allLoaded);
		   	imgLoader.loadImgs(arrImages.concat([ stBackFile ]));
		}
	
	    private function errorLoading(e:Event):void {
			dispatchEvent(new Event(CardDeck.LOAD_ERROR));
       	}
	
	   	private function allLoaded(e:Event):void {
			makeCards();
	   	}
		
		private function makeCards():void {
			var arrImages:Array = imgLoader.bitmapsArray;
			var n:int = arrImages.length - 1;
			var i:int;
			
			for (i=0; i<n; i++) {
				arrCards[i] = new PlayingCard(arrImages[i].bitmapData,arrImages[n].bitmapData);
			}
		
			layerCards();
			
			dispatchEvent(new Event(CardDeck.CARDS_LOADED));
		}
		
		private function layerCards():void {
			var i:int;
			
			while (this.numChildren > 0) {
				this.removeChildAt(0);
			}
			
			for (i=0; i<arrCards.length; i++) {
				arrCards[i].x = 15*i;
				arrCards[i].y = 0;
				this.addChildAt(arrCards[i],i);
			}
		}
		
		public function getCardArray():Array {
			return arrCards;
		}
		
		public function getCardAt(i:int):PlayingCard {
			return PlayingCard(arrCards[i]);
		}
		
		public function removeCardAt(i:int):PlayingCard {
			var pc:PlayingCard = arrCards.splice(i,1)[0] as PlayingCard;
			this.removeChild(pc);
			layerCards();
			return pc;
		}

		public function addCardAt(pc:PlayingCard, i:int):void {
			arrCards.splice(i,0,pc);
			this.addChildAt(pc,i);
			layerCards();
		}

		public function getCardIndex(pc:PlayingCard):int {			
			return arrCards.indexOf(pc);
		}

		public function setCardIndex(pc:PlayingCard, i:int):void {
			arrCards.splice(i,0,pc);
			this.setChildIndex(pc,i);
		}

		public function numCards():int {
			return arrCards.length;
		}
		
		
	}
	
}
