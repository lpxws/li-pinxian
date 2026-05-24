package enemies
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class BossBullet extends BossWeapon
	{
		public function BossBullet(X:Number,Y:Number,BossY:Number) 
		{
			super(X, Y, BossY);
			
			var random:Number = FlxG.random() * 2;
			if (random <= 1)
			{
				loadGraphic(AssetManager.bossBullet3PNG);
			}else {
				loadGraphic(AssetManager.bossBullet4PNG);
			}
			speed = 64;
			damage = 40;
			velocity.y = speed;
		}
		
		override public function update():void
		{
			super.update();
			
			if (y > FlxG.height || x<0||x>FlxG.width)
			{
				kill();
			}
		}
		
		override public function kill():void
		{
			super.kill();
		}
		
	}

}