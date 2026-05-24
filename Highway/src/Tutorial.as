package  
{
	import enemies.enemy1;
	import enemies.pillar1;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Tutorial extends FlxState
	{
		private var background:TileBackground;
		private var player:Player;
		private var pillar:pillar1;
		private var enemy:enemy1;
		private var foodGroup:FlxGroup;
		
		private var textBackground:FlxSprite;
		private var tutorialText:FlxText;
		private var keyboardButton:FlxButton;
		private var mouseButton:FlxButton;
		private var skipButton:FlxButton;
		private var nextButton:FlxButton;
		private var playerHPBar:FlxBar;
		private var staminaBar:FlxBar;
		private var HPIcon:FlxSprite;
		private var staminaIcon:FlxSprite;
		
		private var speed:int;
		private var step:int;
		private var delay:FlxDelay;
		
		override public function create():void
		{
			super.create();
			
			FlxG.worldBounds = new FlxRect(0, 32, FlxG.width, FlxG.height - 32);
			
			background = new TileBackground();
			background.loadMap(new AssetManager.palaceCSV, AssetManager.tilePalacePNG, 32, 32);
			add(background);
			
			player = new Player(FlxG.width / 2, 232);
			add(player.bulletGroup);
			add(player.extraGroup);
			add(player);
			
			pillar = new pillar1(FlxG.width / 2, -64);
			add(pillar);
			add(pillar.deadEmitter);
			
			enemy = new enemy1(FlxG.random() * (FlxG.width - 24), -32);
			add(enemy);
			add(enemy.bloodEmitter);
			
			//initiate foods
			foodGroup = new FlxGroup();
			for (var k:int = 0; k < 30; k++)
			{
				var tempFood:Food = new Food( -100, -100);
				tempFood.exists = false;
				foodGroup.add(tempFood);
			}
			add(foodGroup);
			
			textBackground = new FlxSprite(32, 64, AssetManager.tutorialBackgroundPNG);
			textBackground.visible = false;
			add(textBackground);
			
			tutorialText = new FlxText(textBackground.x, textBackground.y + 8, textBackground.width,"CHOOSE YOUR INPUT METHOD");
			tutorialText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			tutorialText.visible = false;
			add(tutorialText);
			
			mouseButton = new FlxButton(textBackground.x + 32, tutorialText.y + tutorialText.height + 8, null, onMouse);
			mouseButton.loadGraphic(AssetManager.mousePNG);
			mouseButton.visible = false;
			add(mouseButton);
			
			keyboardButton = new FlxButton(textBackground.x + textBackground.width - 56, mouseButton.y, null, onKeyboard);
			keyboardButton.loadGraphic(AssetManager.keyboardPNG);
			keyboardButton.visible = false;
			add(keyboardButton);	
			
			nextButton = new FlxButton(64, textBackground.y + textBackground.height - 28 , "NEXT", gotoNext);
			nextButton.loadGraphic(AssetManager.upgradePNG, false, false, 64, 20);
			nextButton.visible = false;
			add(nextButton);
			
			skipButton = new FlxButton(0, 0, "SKIP", skipStory);
			skipButton.loadGraphic(AssetManager.upgradePNG, false, false, 64, 20);
			skipButton.reset(FlxG.width - skipButton.width - 4, FlxG.height - skipButton.height - 4);
			add(skipButton);
			
			HPIcon = new FlxSprite(4, 4, AssetManager.HPIconPNG);
			add(HPIcon);
			playerHPBar = new FlxBar(HPIcon.x + HPIcon.width + 2, HPIcon.y+1, FlxBar.FILL_LEFT_TO_RIGHT, 70, 10, player, "currentHP", 0, player.maxHP);
			playerHPBar.createImageBar(AssetManager.hpBarEmptyPNG, AssetManager.hpBarPNG);
			add(playerHPBar);
			staminaIcon = new FlxSprite(playerHPBar.x + playerHPBar.width + 8, HPIcon.y, AssetManager.staminaIconPNG);
			add(staminaIcon);
			staminaBar = new FlxBar(staminaIcon.x + staminaIcon.width + 2, HPIcon.y+1, FlxBar.FILL_LEFT_TO_RIGHT, 70, 10, player, "currentStamina", 0, player.maxStamina);
			staminaBar.createImageBar(AssetManager.staminaBarEmptyPNG, AssetManager.staminaBarPNG);
			add(staminaBar);
			
			player.onControl = false;
			speed = 128;
			background.scrollMap(speed);
			step = 1;
			delay = new FlxDelay(500);
			delay.start();
			
			if (ShareData.musicOn)
			{
				if (FlxG.music != null)
				{
					FlxG.music.stop();
				}
				FlxG.playMusic(AssetManager.levelBGM);
			}
		}
		
		override public function update():void
		{
			if (step == 5)
			{
				nextButton.update();
				skipButton.update();
				return;
			}
			
			super.update();
			
			if (player.currentHP <= 0)
			{
				player.currentHP = player.maxHP;
			}
			if (player.currentStamina <= 0)
			{
				player.currentStamina = player.maxStamina;
			}
			
			switch(step)
			{
				case 1:
					if (delay.hasExpired)
					{
						textBackground.visible = tutorialText.visible = mouseButton.visible = keyboardButton.visible = true;
						
					}
					break;
				case 2:
					if (player.overlaps(pillar))
					{
						pillar.kill();
						pillar.reset(FlxG.width / 2, -96);
						FlxG.camera.shake(0.01, 0.2);
						player.currentHP -= 5;
						if (ShareData.soundOn)
						{
						FlxG.play(AssetManager.hitBlockSFX);
						}
					}
					if (pillar.y >= FlxG.height)
					{
						player.velocity.x = 0;
						player.onControl = false;
						textBackground.visible = tutorialText.visible = nextButton.visible = true;
						tutorialText.text="GREAT MOVE !\nNOW TRY TO\n SHOOT THE ENEMY"
					}
					break;
				case 3:
					if (player.overlaps(enemy))
					{
						enemy.kill();
						enemy.reset(FlxG.random() * (FlxG.width - 24), -32);
						player.currentHP -= 5;
						FlxG.camera.shake(0.01, 0.2);
						if (ShareData.soundOn)
						{
						FlxG.play(AssetManager.hitBlockSFX);
						}
					}
					if (enemy.y >= FlxG.height)
					{
						enemy.reset(FlxG.random() * (FlxG.width - 24), -32);
					}
					FlxG.overlap(enemy, player.bulletGroup, hitEnemy);
					break;
				case 4:
					if (delay.hasExpired)
					{
						textBackground.visible = tutorialText.visible = nextButton.visible = true;
						tutorialText.text = "NICE SHOT !\nEAT SOME FOOD TO \nRECOVER YOUR STAMINA";
						step++;
					}
				case 6:
					FlxG.overlap(player, foodGroup, getFood);
					
					if (player.overlaps(enemy))
					{
						enemy.kill();
						enemy.reset(FlxG.random() * (FlxG.width - 24), -32);
						player.currentHP -= 5;
						FlxG.camera.shake(0.01, 0.2);
					}
					if (enemy.y >= FlxG.height)
					{
						enemy.reset(FlxG.random() * (FlxG.width - 24), -32);
					}
					FlxG.overlap(enemy, player.bulletGroup, hitEnemy);
					break;
			}	
		}
		
		private function skipStory():void
		{
			SaveData.onSave();
			FlxG.switchState(new MainLevel);
			
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		private function onMouse():void
		{
			ShareData.mouseControl = true;
			mouseButton.kill();
			keyboardButton.kill();
			nextButton.visible = true;
			tutorialText.text = "MOVE MOUSE TO \nDIRECT THE WIZARD";
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		
		private function onKeyboard():void
		{
			ShareData.mouseControl = false;
			mouseButton.kill();
			keyboardButton.kill();
			nextButton.visible = true;
			tutorialText.text = "PRESS A, D, OR ARROW KEYS TO MAKE THE WIZARD MOVE";
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		
		private function gotoNext():void
		{
			if (step == 1)
			{
				pillar.movingSpeed = speed;
				textBackground.visible = tutorialText.visible = nextButton.visible = false;
				player.onControl = true;
			}else if (step == 2)
			{
				enemy.movingSpeed = speed;
				textBackground.visible = tutorialText.visible = nextButton.visible = false;
				player.onControl = true;
				player.shootBullet();
				player.onShoot = true;
				player.state = player.STATE_MOVE;
			}else if (step == 5)
			{
				textBackground.visible = tutorialText.visible = nextButton.visible = false;
				
			}else if (step == 6)
			{
				SaveData.onSave();
				FlxG.switchState(new MainLevel);
			}
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
			step++;
		}
		
		private function hitEnemy(enemy:Enemy, bullet:Bullet):void
		{
			enemy.kill();
			var food:Food = foodGroup.recycle() as Food;
			food.spawnNewFood(enemy.x, enemy.y, speed, 1);
			enemy.reset(FlxG.random() * (FlxG.width - 24), -32);
			if (step == 3)
			{
				step++;
				delay.reset(200);
			}
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.hitBulletSFX);
			}
		}
		
		private function getFood(player:Player, food:Food):void
		{
			player.currentStamina += food.staminaAmout;
			food.kill();
			textBackground.visible = tutorialText.visible = nextButton.visible = true;
			tutorialText.text = "KEEP AN EYE ON \nHP & STAMINA BAR !\nRUN AS FAR AS POSSIBLE";
			nextButton.label.text = "START";
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.foodSFX);
			}
		}
	}

}