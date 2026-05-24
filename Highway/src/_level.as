package  
{
	import flash.geom.Rectangle;
	import item.item_invince;
	import item.item_kill;
	import item.item_laser;
	import item.item_potion;
	import item.item_shotgun;
	import item.itemSpawner;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	import spawner.*;
	import UI.*;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class _level extends FlxState
	{
		public var distance:Number;
		public var scrollSpeed:Number;
		public var scrollDrag:Number;
		public var enemyCount:int = 0;
		private var deadState:int;
		
		public var player:Player;
		public var enemyGroup:FlxGroup;
		public var bossGroup:FlxGroup;
		public var blockGroup:FlxGroup;
		public var foodGroup:FlxGroup;
		public var itemGroup:itemSpawner;
		//public var weaponGroup:FlxGroup;
		//tilebackground
		public var tileBackground:TileBackground;
		public var starGroup:FlxGroup;
		public var backgroundGroup:FlxGroup;
		
		public var levelMode:int;
		static public const MODE_STORY:int = 0;
		static public const MODE_CHALLENGE:int = 1;
		public var state:int;
		public const STATE_READY:int = 0;
		public const STATE_MOVE:int = 1;
		public const STATE_DEAD:int = 2;
		public const STATE_OVER:int = 3;
		public const STATE_CLEAR:int = 4;
		public var level:int;
		
		//temp variable for testing spawning funtion
		private var spawnInterval:int = 1500;
		//private var spawnDelay:FlxDelay;
		//private var blockInterval:int = 2000;
		//private var blockDelay:FlxDelay;
		protected var spawner1:Spawner1;
		protected var spawner2:Spawner2;
		protected var spawner3:Spawner3;
		protected var spawner4:Spawner4;
		protected var spawner5:Spawner5;
		protected var spawnerC:SpawnerChallenge;
		protected var initSpawner:Spawner;
		
		//add UI element
		public var UIGroup:FlxGroup;
		public var playerHPBar:FlxBar;
		public var staminaBar:FlxBar;
		public var scoreText:FlxText;
		public var readyText:FlxText;
		public var readyDelay:FlxDelay;
		public var goDelay:FlxDelay;
		public var overUI:CompleText;
		public var HPIcon:FlxSprite;
		public var staminaIcon:FlxSprite;
		public var pausePage:PausePage;
		//public var pauseText:FlxText;
		
		override public function create():void
		{
			super.create();
			
			distance = 0;
			state = STATE_READY;
			level = 1;
			FlxG.score = 0;
			scrollSpeed = 128;
			scrollDrag = 3;
			
			//add background
			backgroundGroup = new FlxGroup();
			tileBackground = new TileBackground();
			backgroundGroup.add(tileBackground);
			//tileBackground.scrollMap(scrollSpeed);
			//add star background
			starGroup = new FlxGroup();
			backgroundGroup.add(starGroup);
			add(backgroundGroup);
			
			//initiate enemies
			enemyGroup = new FlxGroup
			add(enemyGroup);
			
			//initiate blocks
			blockGroup = new FlxGroup();
			add(blockGroup);
			
			//initiate foods
			foodGroup = new FlxGroup();
			for (var k:int = 0; k < 30; k++)
			{
				var tempFood:Food = new Food( -100, -100);
				tempFood.exists = false;
				foodGroup.add(tempFood);
			}
			add(foodGroup);
			
			//initiate pickups
			itemGroup = new itemSpawner(5);
			add(itemGroup);
			
			//temp test for spawning enemies, remove later
			//spawnDelay = new FlxDelay(1);
			//spawnDelay.reset(spawnInterval);
			
			spawner1 = new Spawner1();
			enemyGroup.add(spawner1.enemyGroup);
			blockGroup.add(spawner1.blockGroup);
			add(spawner1.hpBarGroup);
			add(spawner1.shadowGroup);
			add(spawner1);
			spawner2 = new Spawner2();
			enemyGroup.add(spawner2.enemyGroup);
			blockGroup.add(spawner2.blockGroup);
			add(spawner2.hpBarGroup);
			add(spawner2.shadowGroup);
			add(spawner2);
			spawner3 = new Spawner3();
			enemyGroup.add(spawner3.enemyGroup);
			blockGroup.add(spawner3.blockGroup);
			add(spawner3.hpBarGroup);
			add(spawner3.shadowGroup);
			add(spawner3);
			spawner4 = new Spawner4();
			enemyGroup.add(spawner4.enemyGroup);
			blockGroup.add(spawner4.blockGroup);
			add(spawner4.hpBarGroup);
			add(spawner4.shadowGroup);
			add(spawner4);
			spawner5 = new Spawner5();
			enemyGroup.add(spawner5.enemyGroup);
			blockGroup.add(spawner5.blockGroup);
			add(spawner5.hpBarGroup);
			add(spawner5.shadowGroup);
			add(spawner5);
			spawnerC = new SpawnerChallenge();
			enemyGroup.add(spawnerC.enemyGroup);
			blockGroup.add(spawnerC.blockGroup);
			add(spawnerC.hpBarGroup);
			add(spawnerC);
			
			//create player
			player = new Player(FlxG.width / 2, 232);
			add(player.bulletGroup);
			add(player.bloodEmitter);
			add(player);
			add(player.extraGroup);
			
			//weaponGroup = new FlxGroup;
			//add(weaponGroup);
			
			bossGroup = new FlxGroup;
			add(bossGroup);
			
			//create UI group
			UIGroup = new FlxGroup();
			add(UIGroup);
			HPIcon = new FlxSprite(4, 4, AssetManager.HPIconPNG);
			UIGroup.add(HPIcon);
			playerHPBar = new FlxBar(HPIcon.x + HPIcon.width + 2, HPIcon.y+1, FlxBar.FILL_LEFT_TO_RIGHT, 70, 10, player, "currentHP", 0, player.maxHP);
			playerHPBar.createImageBar(AssetManager.hpBarEmptyPNG, AssetManager.hpBarPNG);
			//playerHPBar.createFilledBar(0xff500000, 0xffff0000);
			UIGroup.add(playerHPBar);
			staminaIcon = new FlxSprite(playerHPBar.x + playerHPBar.width + 8, HPIcon.y, AssetManager.staminaIconPNG);
			UIGroup.add(staminaIcon);
			staminaBar = new FlxBar(staminaIcon.x + staminaIcon.width + 2, HPIcon.y+1, FlxBar.FILL_LEFT_TO_RIGHT, 70, 10, player, "currentStamina", 0, player.maxStamina);
			staminaBar.createImageBar(AssetManager.staminaBarEmptyPNG, AssetManager.staminaBarPNG);
			UIGroup.add(staminaBar);
			scoreText = new FlxText(0, FlxG.height - 14, FlxG.width);
			scoreText.setFormat(null, 8, 0xffffe6b6, "right",0xff000000);
			UIGroup.add(scoreText);
			overUI = new CompleText();
			UIGroup.add(overUI);
			readyText = new FlxText(0, 64, FlxG.width,"READY?");
			readyText.setFormat(null, 16, 0xffffe6b6, "center", 0xff000000);
			UIGroup.add(readyText);
			pausePage = new PausePage(32, 48);
			UIGroup.add(pausePage);
			//pauseText = new FlxText(0, 100, FlxG.width, "PAUSE");
			//pauseText.setFormat(null, 16, 0xffffe6b6, "center", 0xff000000);
			//pauseText.visible = false;
			//UIGroup.add(pauseText);
			//UIGroup.add(pauseButton);
			
			readyDelay = new FlxDelay(800);
			readyDelay.start();
			goDelay = new FlxDelay(1);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE"))
			{
				FlxG.paused = !FlxG.paused;
				if (!FlxG.paused)
				{
					//pauseText.visible = false;
					pausePage.resume();
				}else {
					pausePage.startPause();
				}
			}
			if (FlxG.paused)
			{
				//pauseButton.update();
				pausePage.update();
				//pauseText.visible = true;
				return;
			}else {
				//pauseText.visible = false;
			}
			
			super.update();
			
			switch(state)
			{
				case STATE_READY:
					if (readyDelay.hasExpired)
					{
						readyDelay.reset(1500);
						goDelay.reset(1000);
						readyText.size = 24;
						readyText.text = "GO!";
					}
					if (goDelay.hasExpired)
					{
						state = STATE_MOVE;
						player.state = STATE_MOVE;
						player.onShoot = true;
						player.shootBullet();
						readyText.visible = false;
						if (initSpawner == null)
						{
							initSpawner = spawner1;
						}
						FlxG.camera.flash(0xffffffff, 0.3);
						initSpawner.startSpawn(scrollSpeed, 16, player.damageAmout, 128);
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.startSFX);
						}
					}
					break;
				case STATE_MOVE:
					if (player.isStarved())
					{
						FlxG.camera.flash(0xffffffff, 0.3);
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.starveSFX);
						}
						gameOver(Player.DEAD_STARVE);
					}
					/*
					if (spawnDelay.hasExpired)
					{
						spawnEnemy();
					}
					*/
					FlxG.overlap(player, enemyGroup, hitPlayer);
					FlxG.overlap(player, blockGroup, hitPlayer);
					FlxG.overlap(player.bulletGroup, enemyGroup, hitEnemy);
					FlxG.overlap(player.bulletGroup, blockGroup, hitBlock);
					FlxG.overlap(player, foodGroup, getFood);
					FlxG.overlap(player, itemGroup.potionGroup, getPotion);
					FlxG.overlap(player, itemGroup.inviceGroup, getInvince);
					FlxG.overlap(player, itemGroup.killGroup, getKillAll);
					FlxG.overlap(player, itemGroup.shotgunGroup, getShotgun);
					FlxG.overlap(player, itemGroup.laserGroup, getLaser);
					
					//update score
					distance += scrollSpeed / FlxG.framerate;
					FlxG.score = int(distance / 30);
					scoreText.text = FlxG.score.toString() + "M";
					break;
				case STATE_DEAD:
					//update score
					if (scrollSpeed > scrollDrag)
					{
						scrollSpeed -= scrollDrag;
						tileBackground.scrollMap(scrollSpeed);
					}else {
						scrollSpeed = 0;
						player.movingSpeed = scrollSpeed;
						overUI.start(deadState, enemyCount, levelMode);
						tileBackground.scrollMap(scrollSpeed);
						state=STATE_OVER
					}
					enemyGroup.setAll("movingSpeed", scrollSpeed);
					blockGroup.setAll("movingSpeed", scrollSpeed);
					foodGroup.setAll("movingSpeed", scrollSpeed);
					itemGroup.setAll("movingSpeed", scrollSpeed);
					distance += scrollSpeed / FlxG.framerate;
					FlxG.score = int(distance / 30);
					scoreText.text = FlxG.score.toString();
					break;
				case STATE_OVER:
					break;
				case STATE_CLEAR:
					if (scrollSpeed > scrollDrag)
					{
						scrollSpeed -= scrollDrag;
						tileBackground.scrollMap(scrollSpeed);
					}else if (scrollSpeed < scrollDrag){
						scrollSpeed = 0;
						player.onControl = false;
						player.velocity.y = -128;
						tileBackground.scrollMap(scrollSpeed);
					}else {
					}
					
					if (player.y < 0)
					{
						ShareData.enemyCount = enemyCount;
						FlxG.switchState(new BossLevel);
						player.kill();
					}
					enemyGroup.setAll("movingSpeed", scrollSpeed);
					blockGroup.setAll("movingSpeed", scrollSpeed);
					foodGroup.setAll("movingSpeed", scrollSpeed);
					itemGroup.setAll("movingSpeed", scrollSpeed);
					distance += scrollSpeed / FlxG.framerate;
					break;
			}
			
		}
		/*
		public function spawnEnemy():void
		{
			
			var tempEnemy:Enemy = enemyGroup.recycle() as Enemy;
			tempEnemy.reset(FlxG.random() * (FlxG.width - tempEnemy.width), -tempEnemy.height);
			tempEnemy.movingSpeed = scrollSpeed;
			
			spawnDelay.reset(spawnInterval);
		}
		*/
		/*
		public function spawnBlock():void
		{
			var tempBlock:Block = blockGroup.recycle() as Block;
			tempBlock.reset(FlxG.random() * (FlxG.width - tempBlock.width), -tempBlock.height);
			tempBlock.movingSpeed = scrollSpeed;
			blockDelay.reset(blockInterval);
			
		}
		*/
		
		public function hitPlayer(player:Player,enemy:GameSprite):void
		{
			FlxG.camera.shake(0.01, 0.2);
			player.onHit(enemy.damage);
			enemy.kill();
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
		
		public function hitEnemy(bullet:Bullet, enemy:Enemy):void
		{
			if (!bullet.isLaser)
			{
				bullet.kill();
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.hitBulletSFX);
				}
			}else {
				
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.hitLaserSFX);
				}
			}
			enemy.onHit(bullet.damage);
			if (!enemy.alive)
			{
				enemyCount++;
				var random:int = int(FlxG.random() * 100);
				if (random <= 15)
				{
					var tempFood:Food = foodGroup.recycle() as Food;
					tempFood.spawnNewFood(enemy.x, enemy.y, scrollSpeed, level);
				}else if (random <= 20) {
					itemGroup.spawn(enemy.x, enemy.y, scrollSpeed);
				}
			}
		}
		
		public function hitBlock(bullet:Bullet, block:Block):void
		{
			if (!bullet.isLaser)
			{
				bullet.kill();	
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.hitBulletSFX);
				}
			}
		}
		
		public function getFood(player:Player, food:Food):void
		{
			player.recoverStmina(food.staminaAmout);
			food.kill();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.foodSFX);
			}
		}
		
		public function gameOver(deadWay:int):void
		{
			state = STATE_DEAD;
			spawner1.stopSpawn();
			spawner2.stopSpawn();
			spawner3.stopSpawn();
			spawner4.stopSpawn();
			spawner5.stopSpawn();
			spawnerC.stopSpawn();
			deadState = deadWay;
		}
		
		protected function getPotion(player:Player, potion:item_potion):void
		{
			player.recoverHP(potion.recoveryAmout);
			potion.kill();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.hpSFX);
			}
		}
		protected function getInvince(player:Player, invince:item_invince):void
		{
			player.startInvincible();
			invince.kill();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.invincibleSFX);
			}
		}
		protected function getKillAll(player:Player, killAll :item_kill):void
		{
			enemyGroup.callAll("kill");
			blockGroup.callAll("kill");
			FlxG.camera.shake(0.02, 0.2);
			killAll.kill();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.killAllSFX);
			}
		}
		protected function getShotgun(player:Player, shotgun:item_shotgun):void
		{
			player.getShotgun();
			shotgun.kill();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.weaponSFX);
			}
		}
		protected function getLaser(player:Player, laser:item_laser):void
		{
			player.getLaser();
			laser.kill();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.weaponSFX);
			}
		}

	}

}