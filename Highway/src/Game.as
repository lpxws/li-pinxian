package  
{
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import org.flixel.FlxG;
	import org.flixel.FlxGame;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	[Frame(factoryClass = "Preloader3")]
	
	public class Game extends FlxGame
	{
		public function Game() 
		{
			super(192, 280, TitlePage, 2, 30, 30);
			
			//forceDebugger = true;
			
			FlxG.mouse.load(AssetManager.cursorPNG);
			FlxG.mouse.show();
		}
		
	}

}