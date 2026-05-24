package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Star extends FlxSprite
	{
		
		public function Star(X:Number,Y:Number) 
		{
			super(X, Y);
			makeGraphic(1, 1);
		}
		
		override public function update():void
		{
			super.update();
			if (y > FlxG.height)
			{
				y = -FlxG.height;
				x = FlxG.random() * FlxG.width;
			}
			
		}
	}

}