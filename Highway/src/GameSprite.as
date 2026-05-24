package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class GameSprite extends FlxSprite
	{
		public var movingSpeed:int;
		public var damage:int;
		public var currentHP:int;
		public var maxHP:int;
		public var shadow:FlxSprite;
		
		public function GameSprite(X:Number,Y:Number) 
		{
			super(X, Y);
			
			currentHP = maxHP;
			shadow = new FlxSprite(X, Y);
		}
		
		override public function update():void
		{
			super.update();
			
			if (y > FlxG.height)
			{
				kill();
			}
			//trace(movingSpeed);
			velocity.y = movingSpeed;
			shadow.velocity.y = movingSpeed;
		}
		
		override public function kill():void
		{
			super.kill();
			currentHP = 0;
			shadow.kill();
		}
		
		override public function reset(X:Number, Y:Number):void
		{
			super.reset(X, Y);
			currentHP = maxHP;
			shadow.reset(X, Y);
		}
		
		public function onHit(damage:int):void
		{
			currentHP -= damage;
			if (currentHP <= 0)
			{
				kill();
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.exploSFX);
				}
			}
		}
		
	}

}