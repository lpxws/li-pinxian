package  
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	import enemies.BossWeapon;
	import item.item_potion;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	
	public class BossLevel extends _level
	{
		//starfield background
		private var stars:FlxSprite;
		private var starfield:StarfieldFX;
		
		private var boss:Boss;
		private var bloodEmitter:FlxEmitter;
		private var bloodParticle:FlxParticle;
		private var winDelay:FlxDelay;
		
		public const STATE_BOSS_IN:int = 5;
		public const STATE_BOSS_WIN:int = 6;
		
		override public function create():void
		{
			super.create();
			
			levelMode = _level.MODE_STORY;
			
			backgroundGroup.remove(tileBackground);
			backgroundGroup.remove(starGroup);
			//create starfield background
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
			}
			starfield = FlxSpecialFX.starfield();
			stars = starfield.create(0, 0, FlxG.width, FlxG.height, 128, 2);
			backgroundGroup.add(stars);
			
			boss = new Boss(FlxG.width / 2, -48, player);
			boss.exists = boss.hammer1.exists = boss.hammer2.exists = false;
			bossGroup.add(boss);
			bossGroup.add(boss.weaponGroup);
			bossGroup.add(boss.bulletGroup);
			bossGroup.add(boss.hpBarGroup);
			bossGroup.add(boss.deadEmitter);
			bossGroup.add(boss.emitterGroup);
			bossGroup.add(boss.chainGroup);
			
			bloodEmitter = new FlxEmitter(boss.x, boss.y, 20);
			bloodEmitter.setXSpeed(-128, 128);
			bloodEmitter.setYSpeed( -32, 256);
			add(bloodEmitter);
			
			winDelay = new FlxDelay(2000);
			
			player.y = FlxG.height;
			player.velocity.y = -128;
			player.onControl = false;
			state = STATE_BOSS_IN;
			//player.staminaReduce = 0;
			readyText.text = "";
			distance = 78000;
			enemyCount = ShareData.enemyCount;
			scrollSpeed = 0;
			
			ShareData.bgmType = ShareData.BGM_BOSS;
			if (ShareData.musicOn)
			{
				FlxG.playMusic(AssetManager.bossBGM);
			}
		}
		
		override public function update():void
		{
			super.update();
			
			switch(state)
			{
				case STATE_BOSS_IN:
					if (player.y < 232)
					{
						player.velocity.y = 0;
						player.y = 232;
						boss.reset(FlxG.width / 2 -boss.width/2, -64);
						boss.moveTo(boss.x, 32);
					}
					if (boss.bossState == boss.STATE_1_NORMAL)
					{
						player.onShoot = true;
						player.shootBullet();
						player.state = STATE_MOVE;
						state = STATE_MOVE;
						player.onControl = true;
					}
					break;
				case STATE_MOVE:
					FlxG.overlap(player, boss.weaponGroup, damagePlayer);
					FlxG.overlap(player, boss.bulletGroup, damagePlayer);
					FlxG.overlap(player.bulletGroup, boss.weaponGroup, hitBossWeapon);
					FlxG.overlap(player, boss, hitByBoss);
					if (boss.bossState == boss.STATE_DEAD)
					{
						player.state = player.STATE_OVER;
						player.onControl = false;
						if (player.x > boss.x + player.mpf)
						{
							player.velocity.x = -player.movingSpeed;
						}else if (player.x < boss.x - player.mpf) {
							player.velocity.x = player.movingSpeed;
						}else {
							player.velocity.x = 0;
							player.x = boss.x;
							if (boss.checkMoveOnTarget())
							{
								player.shootBullet();
								state = STATE_BOSS_WIN;
							}
						}
					}else {
						FlxG.overlap(player.bulletGroup, boss, hitBoss);
					}
					break;
				case STATE_BOSS_WIN:
					FlxG.overlap(player.bulletGroup, boss, winShot);
					FlxG.overlap(player, foodGroup, getFood);
					if (player.y <= 0)
					{
						SaveData.challengeOn = true;
						if (player.alive)
						{
							FlxG.camera.flash(0xffffffff, 0.3);
							//FlxG.camera.shake(0.03, 0.4);
							//starfield.destroy();
							if (ShareData.musicOn)
							{
								FlxG.music.stop();
								FlxG.play(AssetManager.winJINGLE);
							}
							overUI.start(Player.DEAD_WIN, enemyCount, levelMode);
							player.kill();
						}
					}
					if (winDelay.hasExpired && player.velocity.y == 0)
					{
						player.play("run");
						player.velocity.y = -128;
					}
					break;
			}
			
			//FlxG.overlap(player, foodGroup, getFood);
			//FlxG.overlap(player, itemGroup.potionGroup, getPotion);
			//FlxG.overlap(player, itemGroup.inviceGroup, getInvince);
			//FlxG.overlap(player, itemGroup.killGroup, getKillAll);
			//FlxG.overlap(player, itemGroup.shotgunGroup, getShotgun);
			//FlxG.overlap(player, itemGroup.laserGroup, getLaser);
			
		}
		
		override public function gameOver(deadWay:int):void
		{
			super.gameOver(deadWay);
			starfield.destroy();
		}
		
		public function damagePlayer(player:Player,enemy:BossWeapon):void
		{
			FlxG.camera.shake(0.01, 0.2);
			player.onHit(enemy.damage);
			if (player.isKilled())
			{
				FlxG.camera.flash(0xffff0000, 0.3);
				FlxG.camera.shake(0.03, 0.4);
				starfield.destroy();
				boss.bossState = boss.STATE_KILL;
				gameOver(Player.DEAD_KILLED);
			}
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.hitBlockSFX);
			}
		}
		
		public function hitBoss(bullet:Bullet, boss:Boss):void
		{
			if (boss.isDamageable)
			{
				boss.onHit(bullet.damage);
				boss.flicker(0.2);
			}
			bullet.kill();
			if (boss.bossState == boss.STATE_3_NORMAL)
			{
				//boss.y -= 8;
			}
			if (boss.currentHP <= 0 && boss.bossState == boss.STATE_2_NORMAL)
			{
				spawnFood(boss.x, boss.y + boss.height / 2);
			}
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.hitBulletSFX);
			}
		}
		
		public function hitBossWeapon(bullet:Bullet, enemy:BossWeapon):void
		{
			if (!bullet.isLaser)
			{
				bullet.kill();
			}
			enemy.onHit(bullet.damage);
			if (!enemy.alive)
			{
				spawnFood(enemy.x, enemy.y);
			}
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.hitBulletSFX);
			}
		}
		
		public function hitByBoss(player:Player, boss:Boss):void
		{
			FlxG.camera.shake(0.01, 0.2);
			player.onHit(boss.damage);
			if (player.isKilled())
			{
				FlxG.camera.flash(0xffff0000, 0.3);
				FlxG.camera.shake(0.03, 0.4);
				gameOver(Player.DEAD_KILLED);
			}
			
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.hitBlockSFX);
			}
		}
		
		public function spawnFood(x:Number, y:Number):void
		{
			var tempFood:Food = foodGroup.recycle() as Food;
			tempFood.spawnNewFood(x, y, 160, 5);
			var tempPotion:item_potion = itemGroup.recycle(item_potion) as item_potion;
			tempPotion.reset(tempFood.x + tempFood.width + 8, y);
			tempPotion.movingSpeed = 160;
		}
		
		public function winShot(bullet:Bullet, boss:Boss):void
		{
			//start blood emitter when killed
			bloodEmitter.clear();
			for (var i:int = 0; i < bloodEmitter.maxSize; i++)
			{
				bloodParticle = new FlxParticle();
				bloodParticle.makeGraphic(3, 3, 0xffff0000);
				bloodParticle.visible = false;
				bloodEmitter.add(bloodParticle);
			}
			bloodEmitter.x = boss.x;
			bloodEmitter.y = boss.y;
			bloodEmitter.start(true, 0.5);
			
			bullet.kill();
			boss.kill();
			var tempFood:Food = foodGroup.recycle() as Food;
			tempFood.spawnNewFood(boss.x, boss.y, 0, 5);
			player.play("win");
			winDelay.start();
			
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.killAllSFX);
			}
		}
		
				
		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();
			
			super.destroy();
		}
	}

}