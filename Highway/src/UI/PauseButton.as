package  UI
{
	import org.flixel.*;
	/**
	 * ...
	 * @author elephant li
	 */
	public class PauseButton extends FlxButton
	{	
		public function PauseButton(X:Number,Y:Number) 
		{
			super(X, Y, null, pause);
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.paused)
			{
				loadGraphic(AssetManager.pauseOnPNG);
			}else {
				loadGraphic(AssetManager.pauseOffPNG);
			}
		}
		
		public function pause():void
		{
			FlxG.paused = !FlxG.paused;
		}
	}

}