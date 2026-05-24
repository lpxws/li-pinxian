package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Block extends GameSprite
	{
		public var deadEmitter:FlxEmitter;
		public var deadParticle:FlxParticle;
		
		public function Block(X:Number,Y:Number) 
		{
			super(X, Y);
			
			deadEmitter = new FlxEmitter(x, y, 6);
			deadEmitter.setXSpeed(-128, 128);
			deadEmitter.setYSpeed( -32, 256);
			deadEmitter.setRotation( -60, 60);
		}
		
		override public function update():void
		{
			super.update();
		}
		override public function kill():void
		{
			super.kill();
			
			//start pieces emitter when killed
			deadEmitter.clear();
			for (var i:int = 0; i < deadEmitter.maxSize; i++)
			{
				deadParticle = new FlxParticle();
				deadParticle.loadGraphic(AssetManager.piecePNG);
				deadParticle.visible = false;
				deadEmitter.add(deadParticle);
			}
			deadEmitter.x = x + width / 2;
			deadEmitter.y = y + height / 2;
			deadEmitter.gravity = movingSpeed;
			deadEmitter.start(true, 0.5);
		}
		
	}

}