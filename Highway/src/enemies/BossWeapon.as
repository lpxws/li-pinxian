package enemies 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class BossWeapon extends FlxSprite
	{
		public var speed:int;
		protected var warningDelay:FlxDelay;
		protected var warningDuration:int;
		
		public var damage:int;
		public var currentHP:int;
		public var maxHP:int;
		public var isAttack:Boolean = false;
		
		protected var state:int;
		protected const STATE_NORMAL:int = 0;
		protected const STATE_WARNING:int = 1;
		protected const STATE_ATTACK:int = 2;
		
		public function BossWeapon(X:Number,Y:Number,BossY:Number) 
		{
			super(X, Y);

			currentHP = maxHP;
			warningDelay = new FlxDelay(0);
			warningDelay.start();
		}
			
		public function onHit(damage:int):void
		{
			currentHP -= damage;
			flicker(0.2);
			if (currentHP <= 0)
			{
				kill();
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.boomSFX);
				}
			}
		}
	}

}