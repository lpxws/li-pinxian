package  
{
	import enemies.Chain;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class StoryPage extends FlxState
	{
		private var background:TileBackground;
		private var player:FlxSprite;
		private var table:FlxSprite;
		private var food:FlxSprite;
		private var boss:FlxSprite;
		private var hammerLeft:FlxSprite;
		private var hammerRight:FlxSprite;
		private var bubble:FlxSprite;
		private var chains1:FlxGroup;
		private var chains2:FlxGroup;
		//public var chainGroup:FlxGroup;
		
		private var skipButton:FlxButton;
		
		private var step:uint;
		private var delay:FlxDelay;
		
		override public function create():void
		{
			super.create();
			
			background = new TileBackground();
			background.loadMap(new AssetManager.storyCSV, AssetManager.tilePalacePNG, 32, 32);
			add(background);
			
			player = new FlxSprite(0, 0);
			player.loadGraphic(AssetManager.heroPNG, true, false, 24, 28);
			player.addAnimation("run", [0, 1], 5);
			player.addAnimation("dead", [2]);
			player.addAnimation("starve", [3]);
			player.addAnimation("win", [4, 5], 5);
			player.addAnimation("idle", [4]);
			player.reset(FlxG.width / 2 - player.width / 2, 160);
			player.play("win");
			add(player);
			
			bubble = new FlxSprite(player.x + 12, player.y - 24, AssetManager.wantStamina);
			add(bubble);
			
			table = new FlxSprite(player.x - 10, FlxG.height, AssetManager.tablePNG);
			add(table);
			food = new FlxSprite(player.x - 2, table.y + 2, AssetManager.food5PNG);
			add(food);
			
			table.velocity.y = food.velocity.y = -64;
			background.scrollMap(table.velocity.y);
			
			boss = new FlxSprite( -100, -200);
			boss.loadGraphic(AssetManager.bossPlanePNG, true, false, 48, 48);
			boss.addAnimation("state1", [0, 1], 3);
			boss.addAnimation("change", [0, 2, 3, 4, 5, 6], 2, false);
			boss.addAnimation("shoot", [5, 6], 10, false);
			boss.reset(FlxG.width / 2 - boss.width / 2, -64);
			add(boss);
			
			hammerLeft = new FlxSprite( -100, -200);
			hammerLeft.loadGraphic(AssetManager.bossHammerPNG, true, false, 32, 64);
			hammerLeft.addAnimation("warning", [0, 1], 10);
			hammerLeft.addAnimation("normal", [0, 2], 3);
			hammerLeft.addAnimation("attack", [0]);
			hammerLeft.addAnimation("grab", [2, 2, 0], 3, false);
			add(hammerLeft);
			hammerRight = new FlxSprite( -100, -200);
			hammerRight.loadGraphic(AssetManager.bossHammerPNG, true, false, 32, 64);
			hammerRight.addAnimation("warning", [0, 1], 10);
			hammerRight.addAnimation("normal", [0, 2], 3);
			hammerRight.addAnimation("attack", [0]);
			add(hammerRight);
			
			hammerLeft.reset(boss.x - hammerLeft.width, boss.y);
			hammerRight.reset(boss.x + boss.width, boss.y);
			hammerLeft.play("normal");
			hammerRight.play("normal");
			
			//create chain
			//chainGroup = new FlxGroup();
			chains1 = new FlxGroup();
			var h:int;
			for (h = 0; h < Chain.maxChainNumber; h++)
			{
				var tempChain:Chain = new Chain( -400, -400);
				tempChain.chainId = h + 1;
				chains1.add(tempChain);
			}
			add(chains1);
			chains2 = new FlxGroup();
			var f:int;
			for (f = 0; f < Chain.maxChainNumber; f++)
			{
				var tempChain2:Chain = new Chain( -400, -400);
				tempChain2.chainId = f + 1;
				chains2.add(tempChain2);
			}
			add(chains2);
			
			skipButton = new FlxButton(0, 0, "SKIP", skipStory);
			skipButton.loadGraphic(AssetManager.upgradePNG, false, false, 64, 20);
			skipButton.reset(FlxG.width - skipButton.width - 4, FlxG.height - skipButton.height - 4);
			add(skipButton);
			
			step = 1;
			delay = new FlxDelay(0);
			delay.start();
		}
		
		override public function update():void
		{
			super.update();
			
			switch (step)
			{
				case 1:
					if (table.y <= player.y + 22 )
					{
						table.velocity.y = food.velocity.y = 0;
						background.scrollMap(0);
						bubble.visible = false;
						table.y = player.y + 22;
						food.y = table.y + 2;
						player.play("idle");
						delay.reset(500);
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.hitBulletSFX);
						}
						step++;
					}
					break;
				case 2:
					if (delay.hasExpired)
					{
						player.play("win");
						boss.velocity.y = 64;
						step++;
					}
					break;
				case 3:
					hammerLeft.velocity.y = hammerRight.velocity.y = boss.velocity.y;
					if (boss.y > 32)
					{
						hammerLeft.velocity.y = hammerRight.velocity.y = boss.velocity.y = 0;
						boss.y = 32;
						player.play("idle");
						boss.play("state1");
						delay.reset(500);
						step++;
					}else {
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.bossAttackSFX);
						}
					}
					break;
				case 4:
					if (delay.hasExpired)
					{
						FlxVelocity.moveTowardsObject(hammerLeft, new FlxSprite(food.x, food.y - 36), 128);
						step++;
					}
					break;
				case 5:
					if (hammerLeft.x > food.x - (hammerLeft.width - food.width) / 2)
					{
						hammerLeft.velocity.x = hammerLeft.velocity.y = 0;
						hammerLeft.x = food.x - (hammerLeft.width - food.width) / 2;
						hammerLeft.play("grab");
						step++;
						delay.reset(1000);
					}else {
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.bossAttackSFX);
						}
					}
					break;
				case 6:
					if (delay.hasExpired)
					{
						FlxVelocity.moveTowardsPoint(hammerLeft, new FlxPoint(boss.x - hammerLeft.width, boss.y), 128);
						
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.bossGrabSFX);
						}
						step++;
					}
					break;
				case 7:
					if (hammerLeft.y < boss.y)
					{
						hammerLeft.velocity.x = hammerLeft.velocity.y = 0;
						hammerLeft.reset(boss.x - hammerLeft.width, boss.y);
						food.x = hammerLeft.x + (hammerLeft.width - food.width) / 2;
						delay.reset(300);
						bubble.loadGraphic(AssetManager.tipPNG);
						bubble.reset(player.x, player.y - 8);
						bubble.visible = true;
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.startSFX);
						}
						step++;
					}else {
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.bossAttackSFX);
						}
					}
					food.velocity.x = hammerLeft.velocity.x;
					food.velocity.y = hammerLeft.velocity.y;
					break;
				case 8:
					if (delay.hasExpired)
					{
						boss.velocity.y = hammerLeft.velocity.y = hammerRight.velocity.y = food.velocity.y = -64;
						step++;
					}
					break;
				case 9:
					if (boss.y < -64)
					{
						boss.kill();
						food.kill();
						hammerLeft.kill();
						hammerRight.kill();
						bubble.kill();
						player.play("run");
						player.velocity.y = -96;
						step++;
					}else {
						if (ShareData.soundOn)
						{
							FlxG.play(AssetManager.bossAttackSFX);
						}
					}
					break;
				case 10:
					if (player.y < -32)
					{
						FlxG.switchState(new Tutorial);
					}
					break;
			}

			if (hammerLeft.alive) {
				chains1.setAll("playerMidPoint", new FlxPoint(boss.x + 4, boss.y + 32));
				chains1.setAll("ballMidPoint", new FlxPoint(hammerLeft.x + hammerLeft.width / 2, hammerLeft.y));
				chains1.callAll("rotateChain");	
			}else {
				chains1.callAll("kill", false);
			}
			if (hammerRight.alive) {
				chains2.setAll("playerMidPoint", new FlxPoint(boss.x + boss.width - 4, boss.y + 32));
				chains2.setAll("ballMidPoint", new FlxPoint(hammerRight.x + hammerRight.width / 2, hammerRight.y));
				chains2.callAll("rotateChain");	
			}else {
				chains2.callAll("kill", false);
			}
		}
	
		private function skipStory():void
		{
			FlxG.switchState(new Tutorial);
		}
		
	}

}