package enemies
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class BossBullet2 extends BossWeapon
	{
		private var target:FlxPoint;
		private var shootDelay:FlxDelay;
		private var isReady:Boolean;
		private var delayDuration:int;
		
		public function BossBullet2(X:Number,Y:Number,BossY:Number) 
		{
			super(X, Y, BossY);
			
			var random:Number = FlxG.random() * 2;
			if (random <= 1)
			{
				loadGraphic(AssetManager.bossBullet1PNG);
			}else {
				loadGraphic(AssetManager.bossBullet2PNG);
			}
			speed = 256;
			damage = 40;
			
			shootDelay = new FlxDelay(0);
			shootDelay.start();
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxVelocity.distanceToPoint(this, target) <= speed / FlxG.framerate)
			{
				velocity.x = velocity.y = 0;
				x = target.x;
				y = target.y;
				isReady = true;
				shootDelay.reset(delayDuration);
			}
			if (isReady && shootDelay.hasExpired)
			{
				velocity.y = speed;
				isReady = false;
			}
			
			if (y > FlxG.height)
			{
				kill();
			}
		}
		
		public function shoot(delay:int):void
		{
			
		}
		
		public function moveTo(X:Number, Y:Number, delay:int):void
		{
			target = new FlxPoint(X, Y);
			FlxVelocity.moveTowardsPoint(this, target, speed);
			isReady = false;
			delayDuration = delay;
		}
		
		override public function kill():void
		{
			super.kill();
		}
		
	}

}