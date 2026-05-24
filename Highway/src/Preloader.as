package 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Preloader extends MovieClip 
	{
		[Embed(source = "../../_fixel/org/flixel/data/nokiafc22.ttf", fontFamily = "default", embedAsCFF = "false")]static public var defaultFont:String;
		[Embed(source = "../assets/character/player1.png")]private var player1PNG:Class;
		[Embed(source = "../assets/character/player2.png")]private var player2PNG:Class;
		[Embed(source = "../assets/UI/playDonw.png")]private var playDownPNG:Class;
		[Embed(source = "../assets/UI/playOver.png")]private var playOverPNG:Class;
		[Embed(source = "../assets/UI/playNormal.png")]private var playNormal:Class;
		
		private var background:Bitmap;
		private var player:Bitmap;
		private var progressText:TextField;
		private var textFormat:TextFormat;
		private var startButton:Sprite;
		
		private var currentLoad:int;
		private var prevLoad:int;
		
		public function Preloader() 
		{
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO show loader
			background = new Bitmap(new BitmapData(384, 560, false, 0xe1c184));
			addChild(background);
			
			player = new player1PNG;
			//player.graphics.beginBitmapFill((new AssetManager.playerAnim1PNG).bitmapData);
			//player.graphics.drawRect(0, 0, 24, 24);
			player.scaleX = 4;
			player.scaleY = 4;
			player.x = 144;
			player.y = 160;
			addChild(player);
			
			progressText = new TextField();
			progressText.text = "PROGRESS";
			progressText.embedFonts = true;
			textFormat = new TextFormat("default", 32, 0xff4f3d1b);
			textFormat.align = "center";
			progressText.x = 0;
			progressText.y = player.x + player.height + 24;
			progressText.width = 384;
			progressText.height = 32;
			progressText.setTextFormat(textFormat);
			addChild(progressText);
			
			//prevLoad = 0;
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void 
		{
			// TODO update loader
			progressText.text = int((e.bytesLoaded / e.bytesTotal) * 100).toString() + "%";
			progressText.setTextFormat(textFormat);
			
			/*
			currentLoad = int(e.bytesLoaded / e.bytesTotal) * 100;
			if (currentLoad - prevLoad >= 2 && currentLoad - prevLoad < 4)
			{
				player.graphics.clear();
				player.graphics.beginBitmapFill((new AssetManager.playerAnim1PNG).bitmapData);
				player.graphics.drawRect(0, 0, 24, 24);
			}else if (currentLoad - prevLoad >= 4){
				player.graphics.clear();
				player.graphics.beginBitmapFill((new AssetManager.playerAnim2PNG).bitmapData);
				player.graphics.drawRect(0, 0, 24, 24);
				prevLoad = currentLoad;
			}
			*/
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames) 
			{
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void 
		{
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// TODO hide loader
			/*
			player.graphics.clear();
			player.graphics.beginBitmapFill((new AssetManager.playerAnim1PNG).bitmapData);
			player.graphics.drawRect(0, 0, 24, 24);
			*/
			startButton = new Sprite();
			startButton.graphics.beginBitmapFill((new playNormal).bitmapData);
			//startButton.graphics.beginFill(0xff0000ff);
			startButton.graphics.drawRect(0, 0, 128, 40);
			startButton.x = 128;
			startButton.y = 400;
			//startButton.addEventListener(MouseEvent.MOUSE_OVER, onOver);
			startButton.addEventListener(MouseEvent.CLICK, startup);
			//startButton.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			addChild(startButton);
			
			//startup();
		}
		
		private function startup(event:MouseEvent):void 
		{
			removeChild(progressText);
			removeChild(startButton);
			removeChild(player);
			removeChild(background);
			
			var mainClass:Class = getDefinitionByName("Game") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		
		private function loadEnd(event:MouseEvent):void 
		{
			startButton.graphics.beginBitmapFill((new AssetManager.playDownPNG).bitmapData);
			startButton.graphics.drawRect(0, 0, 128, 40);
			
			removeChild(progressText);
			removeChild(startButton);
			
			var mainClass:Class = getDefinitionByName("Game") as Class;
			addChild(new mainClass() as DisplayObject);
		}
		/*
		private function onOver(e:MouseEvent):void
		{
			startButton.graphics.beginBitmapFill((new AssetManager.playOverPNG).bitmapData);
			startButton.graphics.drawRect(0, 0, 128, 40);
			//startButton.x = 128;
			//startButton.y = 400;
		}
		
		
		private function mouseOut(e:MouseEvent):void
		{
			startButton.graphics.beginBitmapFill((new AssetManager.playUpPNG).bitmapData);
			startButton.graphics.drawRect(0, 0, 128, 40);
			//startButton.x = 128;
			//startButton.y = 400;
		}
		*/
	}
	
}