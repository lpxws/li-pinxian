package  
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.*;
	
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Player extends FlxSprite
	{
		static public const DEAD_KILLED:int = 0;
		static public const DEAD_STARVE:int = 1;
		static public const DEAD_WIN:int = 2;
		
		public var onControl:Boolean = true;
		public var state:int;
		public const STATE_READY:int = 0;
		public const STATE_MOVE:int = 1;
		public const STATE_DEAD:int = 2;
		public const STATE_STARVE:int = 3;
		public const STATE_OVER:int = 4;
		private var weaponType:int = 0;
		private const WEAPON_NORMAL:int = 0;
		private const WEAPON_SHOTGUN:int = 1;
		private const WEAPON_LASER:int = 2;
		
		public var onShoot:Boolean = true;
		public var shootInterval:int = 200;
		private var shootDelay:FlxDelay;
		public var bulletGroup:FlxGroup;
		 
		//the amoune of reducing stamina per frame
		public var staminaReduce:int = 1;
		
		//basic status
		public var maxHP:int;
		public var currentHP:int;
		public var maxStamina:int;
		public var currentStamina:int;
		public var armor:int;
		public var damageAmout:int;
		public var movingSpeed:int;
		public var mpf:Number;
		
		private var isDamageable:Boolean = true;
		private var damageDelay:FlxDelay;
		private var damageDuration:int = 1000;
		
		//for pickup function 
		private var invincibleTimer:Number = 5;
		private var invincleDelay:Number;
		public var isInvincle:Boolean = false;
		
		//blood emitter when killed
		public var bloodEmitter:FlxEmitter
		public var bloodParticle:FlxParticle;
		
		//extra elements
		public var extraGroup:FlxGroup;
		public var wantSth:FlxSprite;
		public var shadow:FlxSprite;
		private var isHungry:Boolean = false;
		private var isLowHP:Boolean = false;
		
		public function Player(X:Number,Y:Number) 
		{
			super(X, Y);
			
			loadGraphic(AssetManager.heroPNG, true, false, 24, 28);
			addAnimation("run", [0, 1], 5);
			addAnimation("dead", [2]);
			addAnimation("starve", [3]);
			addAnimation("win", [4, 5], 5);
			//makeGraphic(20, 20, 0xff0000ff);
			
			//initiate bullet
			bulletGroup = new FlxGroup();
			for (var i:int = 0; i < 50; i++)
			{
				var tempBullet:Bullet = new Bullet( -100, -100);
				tempBullet.exists = false;
				bulletGroup.add(tempBullet);
			}
			
			//initiate status ofshooting
			state = STATE_READY;
			play("run");
			onShoot = false;
			shootDelay = new FlxDelay(1);
			//shootBullet();
			
			//update status
			updateStatus();
			currentHP = maxHP;
			currentStamina = maxStamina;
			
			//create blood emitter
			bloodEmitter = new FlxEmitter(x, y, 5);
			bloodEmitter.setXSpeed( -16, 16);
			
			//add extra elements
			extraGroup = new FlxGroup();
			shadow = new FlxSprite(x, y, AssetManager.heroShadowPNG);
			//extraGroup.add(shadow);
			wantSth = new FlxSprite(x, y - 20, AssetManager.wantStamina);
			wantSth.visible = false;
			extraGroup.add(wantSth);
			
			damageDelay = new FlxDelay(0);
			damageDelay.start();
		}
		
		override public function update():void
		{
			super.update();
			
			switch (state)
			{
				case STATE_READY:
					
					break;
				case STATE_MOVE:
					currentStamina -= staminaReduce;
					wantSth.x = x + 16;
					if (!isHungry && currentStamina <= maxStamina / 5)
					{
						wantSth.visible = true;
						isHungry = true;
					}
					if (isHungry && currentStamina > maxStamina / 5)
					{
						isHungry = false;
						wantSth.visible = false;
					}
					if (onShoot && shootDelay.hasExpired)
					{
						shootBullet();
					}
					break;
				case STATE_DEAD:
					bloodEmitter.x = x + 4;
					bloodEmitter.y = y + height / 2;
					if (movingSpeed == 0)
					{
						bloodEmitter.clear();
					}
					break;
				case STATE_OVER:
					break;
			}
			
			//check if invincible time is up
			if (isInvincle)
			{
				invincleDelay -= FlxG.elapsed;
				if (invincleDelay > 0.9 && invincleDelay <= 1)
				{
					flicker(1);
					invincleDelay = 0.9;
				}
				if (invincleDelay <= 0)
				{
					isInvincle = false;
					//isDamageable = true;
					scale = new FlxPoint(1, 1);	
				}
			}
			
			if (onControl)
			{
				if (ShareData.mouseControl)
				{
					//x = FlxG.mouse.screenX
					if (FlxG.mouse.screenX > FlxG.width - width - 6 && x >= FlxG.width - width - 6)
					{
						x = FlxG.width - width - 6;
						velocity.x = 0;
					}else if (FlxG.mouse.screenX - x > mpf)
					{
						velocity.x = movingSpeed;
					}else if (FlxG.mouse.screenX - x < -mpf) {
						velocity.x = -movingSpeed;
					}else {
						velocity.x = 0;
					}
				}else {
					if (FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A"))
					{
						velocity.x = -movingSpeed;
					}else if (FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D"))
					{
						velocity.x = movingSpeed;
					}else {
						velocity.x = 0;
					}
				}
				if (x >= FlxG.width - width - 6)
				{
					x = FlxG.width - width - 6;
				}
				/*else if (x <= 6)
				{
					x = 6;
				}
				*/
			}
			
			//invincible for a while after damaged
			if (!isDamageable && damageDelay.hasExpired && !isInvincle)
			{
				isDamageable = true;
			}
			
			//add shadow
			shadow.velocity.x = velocity.x;
		}
		
		public function shootBullet():void
		{
			shootDelay.reset(shootInterval);
			switch(weaponType)
			{
				case WEAPON_NORMAL:
					var tempBullet:Bullet = bulletGroup.recycle() as Bullet;
					tempBullet.reset(x + width / 2 - tempBullet.width / 2, y - tempBullet.height);
					tempBullet.velocity.y = -tempBullet.speed;
					tempBullet.damage = damageAmout;
					tempBullet.loadGraphic(AssetManager.bulletPNG);
					break;
				case WEAPON_SHOTGUN:
					for (var i:int = 0; i < 5; i++)
					{
						var tempBulletShot:Bullet = bulletGroup.recycle() as Bullet;
						tempBulletShot.reset(x + width / 2 - tempBulletShot.width / 2, y - tempBulletShot.height);
						tempBulletShot.damage = damageAmout;
						var tempAngle:Number = 120+30 * i;
						tempBulletShot.velocity.x = Math.sin(FlxMath.asRadians(tempAngle)) * tempBulletShot.speed;
						tempBulletShot.velocity.y = Math.cos(FlxMath.asRadians(tempAngle)) * tempBulletShot.speed;
						tempBulletShot.loadGraphic(AssetManager.bulletShotgunPNG);
					}
					break;
				case WEAPON_LASER:
					var tempBulletLaser:Bullet = bulletGroup.recycle() as Bullet;
					tempBulletLaser.reset(x + width / 2 - tempBulletLaser.width / 2, y - tempBulletLaser.height);
					tempBulletLaser.isLaser = true;
					tempBulletLaser.velocity.y = -tempBulletLaser.speed;
					tempBulletLaser.loadGraphic(AssetManager.bulletLaserPNG);
			}
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.shootSFX);
			}
		}
		
		public function updateStatus():void
		{
			maxHP = 30 + 10 * SaveData.hpLevel;
			maxStamina = 500 + 1000 * SaveData.staminaLevel;
			damageAmout = 10 + 5 * SaveData.attackLevel;
			armor = 5 * SaveData.armorLevel;
			movingSpeed = 64 + SaveData.speedLevel * 32;
			mpf = movingSpeed / FlxG.framerate;
		}
		
		public function onHit(damage:int):void
		{
			if (!isInvincle && isDamageable)
			{
				var realDamage:int;
				if (damage > armor)
				{
					realDamage = damage - armor;
				}else {
					realDamage = 1;
				}
				currentHP -= realDamage;	
				weaponType = WEAPON_NORMAL;
				shootInterval = 200;
				isDamageable = false;
				damageDelay.reset(damageDuration);
				flicker(damageDuration / 1000);
				
			}
		}
		
		public function isKilled():Boolean
		{
			if (currentHP <= 0)
			{
				currentHP = 0;
				state = STATE_DEAD;
				onControl = false;
				velocity.x = 0;
				//scale = new FlxPoint(1, 1);
				play("dead");
				
				//start blood emitter when killed
				bloodEmitter.clear();
				for (var i:int = 0; i < bloodEmitter.maxSize; i++)
				{
					bloodParticle = new FlxParticle();
					bloodParticle.makeGraphic(4, 4, 0xffff0000);
					bloodParticle.visible = false;
					bloodEmitter.add(bloodParticle);
				}
				bloodEmitter.setYSpeed(movingSpeed, movingSpeed);
				bloodEmitter.start(false, 1, 0.1);
				return true;
			}else {
				return false;
			}
		}	
		public function isStarved():Boolean
		{
			if (currentStamina <= 0)
			{
				currentStamina = 0;
				state = STATE_STARVE;
				onControl = false;
				velocity.x = 0;
				play("starve");
				scale = new FlxPoint(1, 1);
				isInvincle = false;
				return true;
			}else {
				return false;
			}
		}
		
		public function recoverHP(amout:int):void
		{
			currentHP += amout;
			if (currentHP > maxHP)
			{
				currentHP = maxHP;
			}
		}
		
		public function recoverStmina(amout:int):void
		{
			currentStamina += amout;
			if (currentStamina > maxStamina)
			{
				currentStamina = maxStamina;
			}
		}
		
		public function startInvincible():void
		{
			if (!isInvincle)
			{
				isInvincle = true;
				//isDamageable = false;
				scale = new FlxPoint(2, 2);	
			}
			invincleDelay = invincibleTimer;
		}
		
		public function getShotgun():void
		{
			weaponType = WEAPON_SHOTGUN;
			shootInterval = 400;
		}
		
		public function getLaser():void
		{
			weaponType = WEAPON_LASER;
			shootInterval = 400;
		}
	}

}