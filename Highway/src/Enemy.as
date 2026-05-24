package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Enemy extends GameSprite
	{
		public var bloodEmitter:FlxEmitter;
		public var bloodParticle:FlxParticle;
		
		public function Enemy(X:Number,Y:Number) 
		{
			super(X, Y);
			
			//makeGraphic(24, 24, 0xffff0000);
			
			bloodEmitter = new FlxEmitter(x, y, 10);
			bloodEmitter.setXSpeed(-128, 128);
			bloodEmitter.setYSpeed( -32, 256);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function kill():void
		{
			super.kill();
			
			//start blood emitter when killed
			bloodEmitter.clear();
			for (var i:int = 0; i < bloodEmitter.maxSize; i++)
			{
				bloodParticle = new FlxParticle();
				bloodParticle.makeGraphic(3, 3, 0xffff0000);
				bloodParticle.visible = false;
				bloodEmitter.add(bloodParticle);
			}
			bloodEmitter.x = x;
			bloodEmitter.y = y;
			bloodEmitter.gravity = movingSpeed;
			bloodEmitter.start(true, 0.5);
		}
		
	}

}