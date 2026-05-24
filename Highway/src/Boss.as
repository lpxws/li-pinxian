package  
{
	import enemies.BossBullet;
	import enemies.BossBullet2;
	import enemies.BossHammer;
	import enemies.Chain;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBar;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxMath;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Boss extends FlxSprite
	{
		public var damage:int;
		public var currentHP:int;
		public var maxHP:int;
		
		public var bossState:uint;
		public const STATE_READY:uint = 0;
		public const STATE_1_NORMAL:uint = 1;
		public const STATE_2_NORMAL:uint = 2;
		public const STATE_3_NORMAL:uint = 3;
		public const STATE_1_ATTACK:uint = 4;
		public const STATE_2_ATTACK:uint = 5;
		public const STATE_3_ATTACK:uint = 6;
		public const STATE_1_WARNING:uint = 7;
		public const STATE_2_WARNING:uint = 8;
		public const STATE_3_WARNING:uint = 9;
		public const STATE_DEAD:uint = 99;
		public const STATE_KILL:uint = 98;
		
		public var weaponGroup:FlxGroup;
		public var bulletGroup:FlxGroup;
		public var hpBarGroup:FlxGroup;
		public var emitterGroup:FlxGroup;
		private var chains1:FlxGroup;
		private var chains2:FlxGroup;
		public var chainGroup:FlxGroup;
		public var hammer1:BossHammer;
		public var hammer2:BossHammer;
		public var deadEmitter:FlxEmitter;
		public var deadParticle:FlxParticle;
		
		public var isDamageable:Boolean = false;
		private var player:Player;
		private var speed:int;
		private var rushAngle:Number;
		private var rushSpeed:int;
		private var rushTarget:FlxPoint;
		private var shootType:Number;
		private var movingTarget:FlxPoint;
		private var target:FlxPoint;
		private var onMove:Boolean;
		private var distanceToTarget:Number;
		private var attackDelay:FlxDelay;
		private var attackInterval:int;
		private var attackIntervalRandom:int;
		private var shootDelay:FlxDelay;
		private var shootInterval:int;
		private var warningDelay:FlxDelay;
		private var warningDuration:int;
		private var bossBar:FlxBar;
		private var state3Delay:FlxDelay;
		private var state3Interval:int;
		private var inDelay:FlxDelay;
		
		public function Boss(X:Number,Y:Number,target:Player) 
		{
			super(X, Y);
			maxHP = 4000;
			//maxHP = 400;
			currentHP = maxHP;
			damage = 40;
			
			//makeGraphic(48, 48, 0xff00ffff);
			loadGraphic(AssetManager.bossPlanePNG, true, false, 48, 48);
			addAnimation("state1", [0, 1], 3);
			addAnimation("change", [0, 2, 3, 4, 5, 6], 2, false);
			addAnimation("shoot", [5, 6], 10, false);
			
			//add weapon to the boss
			weaponGroup = new FlxGroup();
			hammer1 = new BossHammer(x, y, 32);
			hammer1.reset(x - hammer1.width, y);
			weaponGroup.add(hammer1);
			hammer2 = new BossHammer(x, y, 32);
			hammer2.reset(x + width, y);
			weaponGroup.add(hammer2);
			emitterGroup = new FlxGroup();
			emitterGroup = new FlxGroup();
			emitterGroup.add(hammer1.deadEmitter);
			emitterGroup.add(hammer2.deadEmitter);
			bulletGroup = new FlxGroup();
			for (var i:int = 0; i < 50; i++)
			{
				var tempBullet:BossBullet = new BossBullet( -100, -100, y);
				tempBullet.exists = false;
				bulletGroup.add(tempBullet);
				
				var tempBullet2:BossBullet2 = new BossBullet2( -100, -100, y);
				tempBullet2.exists = false;
				bulletGroup.add(tempBullet2);
			}
			
			//create chain
			chainGroup = new FlxGroup();
			chains1 = new FlxGroup();
			var h:int;
			for (h = 0; h < Chain.maxChainNumber; h++)
			{
				var tempChain:Chain = new Chain( -400, -400);
				tempChain.chainId = h + 1;
				chains1.add(tempChain);
			}
			chainGroup.add(chains1);
			chains2 = new FlxGroup();
			var f:int;
			for (f = 0; f < Chain.maxChainNumber; f++)
			{
				var tempChain2:Chain = new Chain( -400, -400);
				tempChain2.chainId = f + 1;
				chains2.add(tempChain2);
			}
			chainGroup.add(chains2);
			
			//create hpbar
			hpBarGroup = new FlxGroup();
			var hammer1Bar:FlxBar = new FlxBar(x, y, FlxBar.FILL_LEFT_TO_RIGHT, hammer1.width, 4, hammer1, "currentHP", 0, hammer1.maxHP);
			hammer1Bar.killOnEmpty = true;
			hammer1Bar.createFilledBar(0xff333333, 0xffff0000);
			hammer1Bar.setParent(hammer1, "currentHP", true, 0, -10);
			hpBarGroup.add(hammer1Bar);
			var hammer2Bar:FlxBar = new FlxBar(x, y, FlxBar.FILL_LEFT_TO_RIGHT, hammer2.width, 4, hammer2, "currentHP", 0, hammer2.maxHP);
			hammer2Bar.killOnEmpty = true;
			hammer2Bar.createFilledBar(0xff333333, 0xffff0000);
			hammer2Bar.setParent(hammer2, "currentHP", true, 0, -10);
			hpBarGroup.add(hammer2Bar);
			
			player = target;
			speed = 64;
			rushSpeed = 160;
			attackDelay = new FlxDelay(0);
			attackDelay.start();
			attackInterval = 2000;
			attackIntervalRandom = 2000;
			shootDelay = new FlxDelay(0);
			shootDelay.start();
			shootInterval = 1500;
			warningDelay = new FlxDelay(0);
			warningDelay.start();
			warningDuration = 500;
			state3Delay = new FlxDelay(0);
			state3Delay.start();
			state3Interval = 2000;
			inDelay = new FlxDelay(1000);
			
			bossState = STATE_READY;
			play("state1");
			
			deadEmitter = new FlxEmitter(x, y, 20);
			deadEmitter.setXSpeed(-256, 256);
			deadEmitter.setYSpeed( -256, 256);
			deadEmitter.setRotation( -60, 60);
		}
		
		override public function update():void
		{
			super.update();
			
			switch (bossState)
			{
				case STATE_READY:
					hammer1.y = hammer2.y = y;
					if (checkMoveOnTarget())
					{
						inDelay.start();
					}else {
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.bossAttackSFX);
						}
					}
					if (inDelay.hasExpired)
					{
						attackDelay.reset(attackInterval);
						bossState = STATE_1_NORMAL;
						moveToTarget();
					}
					updateChain();
					break;
				case STATE_1_NORMAL:
					checkMove();
					if (attackDelay.hasExpired)
					{
						warning();
						bossState = STATE_1_ATTACK;
						break;
					}
					hammer1.x = x - hammer1.width;
					hammer2.x = x + width;
					if (!hammer1.alive && !hammer2.alive)
					{
						changeToState2();
					}
					updateChain();
					break;
				//case STATE_1_WARNING:
				//	break;
				case STATE_1_ATTACK:
					checkMove();
					if (!hammer1.isAttack || !hammer2.isAttack)
					{
						bossState = STATE_1_NORMAL;
						moveToTarget();
						attackDelay.reset(attackInterval + FlxG.random() * attackIntervalRandom);
					}
					if (!hammer1.alive && !hammer2.alive)
					{
						changeToState2();
					}
					updateChain();
					break;
				case STATE_2_NORMAL:
					checkMove();
					if (shootDelay.hasExpired)
					{
						shootBullet();
						isDamageable = true;
					}
					if (currentHP <= 0)
					{
						changeToState3();
					}
					break;
				case STATE_3_WARNING:
					if (state3Delay.hasExpired)
					{
						rushAngle = 30;
						velocity.x = Math.sin(FlxMath.asRadians(rushAngle)) * rushSpeed;
						velocity.y = Math.cos(FlxMath.asRadians(rushAngle)) * rushSpeed;
						bossState = STATE_3_NORMAL;
						play("rotate");
						isDamageable = true;
					}
					break;
				case STATE_3_NORMAL:
					angularVelocity = 60;
					if (x > FlxG.width - width)
					{
						velocity.x = 0;
						x = FlxG.width - width;
						if (velocity.y >= 0)
						{
							rushAngle = 360 - rushAngle;
						}else {
							rushAngle = 90 + rushAngle;
						}
						velocity.x = Math.sin(FlxMath.asRadians(rushAngle)) * rushSpeed;
						velocity.y = Math.cos(FlxMath.asRadians(rushAngle)) * rushSpeed;
						
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.hitBlockSFX);
						}
					}else if (x < 0) {
						velocity.x = 0;
						x = 0;
						if (velocity.y >= 0)
						{
							rushAngle = 360 - rushAngle;
						}else {
							rushAngle = 360 - rushAngle;
						}
						velocity.x = Math.sin(FlxMath.asRadians(rushAngle)) * rushSpeed;
						velocity.y = Math.cos(FlxMath.asRadians(rushAngle)) * rushSpeed;
						
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.hitBlockSFX);
						}
					}else if (y < 0) {	
						velocity.y = 0;
						y = 0;
						if (velocity.x >= 0)
						{
							rushAngle = rushAngle-90;
						}else {
							rushAngle = 540 - rushAngle;
						}
						velocity.x = Math.sin(FlxMath.asRadians(rushAngle)) * rushSpeed;
						velocity.y = Math.cos(FlxMath.asRadians(rushAngle)) * rushSpeed;
						
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.hitBlockSFX);
						}
					}else if (y > FlxG.height - height){
						velocity.y = 0;
						y = FlxG.height - height;
						if (velocity.x >= 0)
						{
							rushAngle = 180 - rushAngle;
						}else {
							rushAngle = 540 - rushAngle;
						}
						velocity.x = Math.sin(FlxMath.asRadians(rushAngle)) * rushSpeed;
						velocity.y = Math.cos(FlxMath.asRadians(rushAngle)) * rushSpeed;
						
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.hitBlockSFX);
						}
					}
					if (currentHP <= 0)
					{
						play("dead");
						moveTo(FlxG.width / 2 - width / 2, 64);
						angle = 0;
						angularVelocity = 0;
						bossState = STATE_DEAD;
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.hitBlockSFX);
						}
					}
					break;
				case STATE_DEAD:
					checkMoveOnTarget();
					break;
				case STATE_KILL:
					checkMove();
					break;
			}
			if (bossState != STATE_3_NORMAL)
			{		
			}
		}
		
		//play warning animation before attack
		public function warning():void
		{
			velocity.x = 0;
			hammer1.shake();
			hammer2.shake();
		}
		
		//stop moving and attack the player
		public function attack():void
		{
			moveToTarget();
		}
		
		//move to a random target
		public function moveToTarget():void
		{
			if (x > (FlxG.width / 2 - width / 2))
			{
				if (hammer1.alive) {
					movingTarget = new FlxPoint(hammer1.width + FlxG.random() * 32, y);
				}else {
					movingTarget = new FlxPoint(FlxG.random() * 32, y);
				}
				velocity.x = -speed;
			}else {
				if (hammer2.alive)
				{
					movingTarget = new FlxPoint(FlxG.width - FlxG.random() * (64 - width) - width - hammer2.width, y);	
				}else {
					movingTarget = new FlxPoint(FlxG.width - FlxG.random() * (64 - width) - width, y);
				}
				velocity.x = speed;
			}
		}
		
		public function checkMove():void
		{
			distanceToTarget = Math.abs(x - movingTarget.x);
			if (distanceToTarget < speed / FlxG.framerate)
			{
				moveToTarget();
			}	
		}
		
		//move to the specific place
		public function moveTo(X:Number, Y:Number):void
		{
			target = new FlxPoint(X + width / 2, Y + height / 2);
			FlxVelocity.moveTowardsPoint(this, target, speed);
		}
		
		public function checkMoveOnTarget():Boolean
		{
			if (FlxVelocity.distanceToPoint(this, target) <= speed / FlxG.framerate)
			{
				x = target.x - width / 2;
				y = target.y - height / 2;
				target.x = -100;
				velocity.x = velocity.y = 0;
				return true;
			}else {
				return false;
			}
		}
		
		//shoot bullets in state 2
		public function shootBullet():void
		{
			shootType = FlxG.random() * 2;
			play("shoot");
			if (shootType <= 1)
			{
				for (var i:int = 0; i < 5; i++)
				{
					var tempBulletShot:BossBullet = bulletGroup.recycle(BossBullet) as BossBullet;
					tempBulletShot.reset((x - tempBulletShot.width) + i * (width + tempBulletShot.width) / 5, y + height);
					var tempAngle:Number = 240-30 * i;
					tempBulletShot.velocity.x = Math.sin(FlxMath.asRadians(tempAngle)) * tempBulletShot.speed;
					tempBulletShot.velocity.y = -Math.cos(FlxMath.asRadians(tempAngle)) * tempBulletShot.speed;
				}	
				shootDelay.reset(shootInterval);
			}else if (shootType <= 2) {
				for (var j:int = 0; j < 5; j++)
				{
					var tempBullet:BossBullet2 = bulletGroup.recycle(BossBullet2) as BossBullet2;
					tempBullet.reset(x, y + height);
					tempBullet.moveTo(8 + j * (FlxG.width - tempBullet.width - 16) / 4, y + height + 4, (1 + j % 2) * 1000);
				}
				shootDelay.reset(shootInterval * 2);
			}
		}
		
		private function changeToState2():void
		{
			play("change");
			bossBar = new FlxBar(x, y, FlxBar.FILL_LEFT_TO_RIGHT, width, 4, this, "currentHP", 0, maxHP);
			//bossBar.killOnEmpty = true;
			bossBar.createFilledBar(0xff333333, 0xffff0000);
			bossBar.setParent(this, "currentHP", true, 0, -8);
			hpBarGroup.add(bossBar);
			moveToTarget();
			shootDelay.reset(4000);
			bossState = STATE_2_NORMAL;
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.transformSFX);
			}
		}
		
		private function changeToState3():void
		{
			currentHP = maxHP / 2;
			bossBar.setRange(0, maxHP / 2);
			bossBar.killOnEmpty = true;
			
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
			state3Delay.reset(state3Interval);
			bossState = STATE_3_WARNING;
			velocity.x = 0;
			//makeGraphic(32, 32, 0xff00ffff);
			loadGraphic(AssetManager.bossPNG, true, false, 32, 32);
			addAnimation("angry", [0, 1], 3);
			addAnimation("rotate", [0]);
			addAnimation("dead", [2]);
			play("angry");
			bulletGroup.callAll("kill");
			isDamageable = false;
			
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.killAllSFX);
			}
		}
		
		private function rushToPlayer():void
		{
			shootType = FlxG.random() * 2;
			if (shootType <= 1)
			{
				rushTarget = new FlxPoint(FlxG.width - width, 70 + FlxG.random() * (FlxG.height - 140));
			}else if (shootType <= 2) {
				rushTarget = new FlxPoint(FlxG.width - width, y +64);
				shootDelay.reset(shootInterval);
			}
			FlxVelocity.moveTowardsPoint(this, rushTarget,rushSpeed);	
		}
		
		public function onHit(damage:int):void
		{
			currentHP -= damage;
		}
		
		private function updateChain():void
		{
			if (hammer1.alive) {
				chains1.setAll("playerMidPoint", new FlxPoint(x + 4, y + 32));
				chains1.setAll("ballMidPoint", new FlxPoint(hammer1.x + hammer1.width / 2, hammer1.y));
				chains1.callAll("rotateChain");	
			}else {
				chains1.callAll("kill", false);
			}
			if (hammer2.alive) {
				chains2.setAll("playerMidPoint", new FlxPoint(x +width - 4, y + 32));
				chains2.setAll("ballMidPoint", new FlxPoint(hammer2.x + hammer2.width / 2, hammer2.y));
				chains2.callAll("rotateChain");	
			}else {
				chains2.callAll("kill", false);
			}
		}
		
		override public function reset(X:Number, Y:Number):void
		{
			super.reset(X, Y);
			hammer1.reset(X - hammer1.width, Y);
			hammer2.reset(X + width, Y);
			
		}
	}

}