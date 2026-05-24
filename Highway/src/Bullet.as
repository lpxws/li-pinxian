package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Bullet extends FlxSprite
	{
		public var speed:int = 256;
		public var damage:int;
		public var isLaser:Boolean = false;
		
		public function Bullet(X:Number,Y:Number) 
		{
			super(X, Y);
			
			makeGraphic(24, 24, 0xff0000ff);
			velocity.y = -speed;
		}
		
		override public function update():void
		{
			super.update();
			
			if (y < 0 || x<0||x>FlxG.width)
			{
				kill();
			}
		}
		
		override public function kill():void
		{
			super.kill();
			isLaser = false;
		}
		
	}

}