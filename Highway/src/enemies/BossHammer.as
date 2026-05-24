package enemies 
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxSprite;
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class BossHammer extends BossWeapon
	{
		private var shakeQuantity:Number;
		private var isShake:Boolean = false;
		private var normalY:Number;
		private var punchDelay:FlxDelay;
		private var punchDuration:int;
		
		public var deadEmitter:FlxEmitter;
		public var deadParticle:FlxParticle;
		
		public function BossHammer(X:Number,Y:Number,BossY:Number) 
		{
			maxHP = 1500;
			super(X, Y, BossY);
			loadGraphic(AssetManager.bossHammerPNG, true, false, 32, 64);
			addAnimation("warning", [0, 1], 10);
			addAnimation("normal", [0, 2], 3);
			addAnimation("attack", [0]);
			
			damage = 40;
			speed = 512;
			play("normal");
			normalY = BossY;
			warningDuration = 800;
			punchDelay = new FlxDelay(0);
			punchDelay.start();
			punchDuration = 300;
			deadEmitter = new FlxEmitter(x, y, 10);
			deadEmitter.setXSpeed(-256, 256);
			deadEmitter.setYSpeed( -256, 256);
			deadEmitter.setRotation( -60, 60);
		}
		
		override public function update():void
		{
			super.update();
			
			switch (state)
			{
				case STATE_NORMAL:
					break;
				case STATE_WARNING:
					if (warningDelay.hasExpired)
					{
						attack();
					}
					break;
				case STATE_ATTACK:
					if (y > FlxG.height - height)
					{
						y = FlxG.height - height;
						velocity.y = 0;
						punchDelay.reset(punchDuration);
						FlxG.camera.shake(0.02, 0.1);
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.killAllSFX);
						}
					}else if (y == FlxG.height - height && punchDelay.hasExpired)
					{
						velocity.y = -speed * 2;
					}
					if (y < normalY)
					{
						y = normalY;
						velocity.y = 0;
						isAttack = false;
						play("normal");
						state = STATE_NORMAL;
					}
					break;
			}
		}
		
		public function shake():void
		{
			isShake = true;
			isAttack = true;
			play("warning");
			state = STATE_WARNING;
			warningDelay.reset(warningDuration);
		}
		
		public function attack():void
		{
			play("attack");
			velocity.y = speed;
			state = STATE_ATTACK;
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.bossGrabSFX);
			}
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
				deadParticle.scale = new FlxPoint(1.5, 1.5);
				deadParticle.visible = false;
				deadEmitter.add(deadParticle);
			}
			deadEmitter.x = x + width / 2;
			deadEmitter.y = y + height / 2;
			deadEmitter.start(true, 0.5);
		}

	}

}