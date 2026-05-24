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
	import UI.CompleText;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class MainLevel extends _level
	{	
		
		public var progression:FlxSprite;
		public var playerCursor:FlxSprite;
		
		override public function create():void
		{
			super.create();
			
			levelMode = _level.MODE_STORY;
			
			scrollSpeed = 128;
			//initSpawner = spawner1;
			
			tileBackground.loadMap(new AssetManager.palaceCSV, AssetManager.tilePalacePNG, 32, 32);
			tileBackground.scrollMap(scrollSpeed);
			
			progression = new FlxSprite(pausePage.pauseButton.x +28, FlxG.height - 10, AssetManager.progressionPNG);
			UIGroup.add(progression);
			playerCursor = new FlxSprite(progression.x - 3, progression.y - 4, AssetManager.playerCursorPNG);
			UIGroup.add(playerCursor);
			ShareData.bgmType = ShareData.BGM_LEVEL;
			if (ShareData.musicOn)
			{
				FlxG.playMusic(AssetManager.levelBGM);
			}
		}
		
		override public function update():void
		{
			super.update();
			
			switch(state)
			{
				case STATE_MOVE:
					//update score
					switch (level)
					{
						case 1:
							if (FlxG.score >= 100)
							{
								level++;
								scrollSpeed = 160;
								spawner1.enemyGroup.setAll("movingSpeed", scrollSpeed);
								spawner1.blockGroup.setAll("movingSpeed", scrollSpeed);
								foodGroup.setAll("movingSpeed", scrollSpeed);
								itemGroup.setAll("movingSpeed", scrollSpeed);
								tileBackground.scrollMap(scrollSpeed);
								spawner1.stopSpawn();
								tileBackground.changeTile(AssetManager.palaceCSV, AssetManager.tileForestPNG, 32, 32);//create stars
								readyText.text = "SPEED UP";
								readyText.size = 16;
								readyText.visible = true;
							}
							break;
						case 2:
							//var tempSprite:Star = starGroup.getRandom()as Star;
							//trace(tempSprite.y);
							//trace(starGroup.getRandom().y);
							if (FlxG.score == 110)
							{
								spawner2.startSpawn(scrollSpeed, 16, player.damageAmout, 128);
								distance += 30;
								readyText.visible = false;
								spawner1.clear();
							}
							if (FlxG.score >= 400)
							{
								level++;
								scrollSpeed = 192;
								spawner2.enemyGroup.setAll("movingSpeed", scrollSpeed);
								spawner2.blockGroup.setAll("movingSpeed", scrollSpeed);
								foodGroup.setAll("movingSpeed", scrollSpeed);
								itemGroup.setAll("movingSpeed", scrollSpeed);
								tileBackground.scrollMap(scrollSpeed);
								spawner2.stopSpawn();
								tileBackground.changeTile(AssetManager.seaCSV, AssetManager.tileSeaPNG, 32, 32);
								readyText.visible = true;
							}
							break;
						case 3:
							if (FlxG.score == 420)
							{
								spawner3.startSpawn(scrollSpeed, 16, player.damageAmout, 96);
								distance += 30;
								readyText.visible = false;
								spawner2.clear();
							}
							if (FlxG.score >= 1000)
							{
								level++;
								scrollSpeed = 224;
								spawner3.enemyGroup.setAll("movingSpeed", scrollSpeed);
								spawner3.blockGroup.setAll("movingSpeed", scrollSpeed);
								foodGroup.setAll("movingSpeed", scrollSpeed);
								itemGroup.setAll("movingSpeed", scrollSpeed);
								spawner3.stopSpawn();
								tileBackground.scrollMap(scrollSpeed);
								tileBackground.changeTile(AssetManager.skyCSV, AssetManager.tileSkyPNG, 32, 32);
								readyText.visible = true;
							}
							break;
						case 4:
							if (FlxG.score == 1020)
							{
								spawner4.startSpawn(scrollSpeed, 16, player.damageAmout, 128);
								distance += 30;
								readyText.visible = false;
								spawner3.clear();
							}
							if (FlxG.score >= 1800)
							{
								level++;
								spawner4.enemyGroup.setAll("movingSpeed", scrollSpeed);
								spawner4.blockGroup.setAll("movingSpeed", scrollSpeed);
								foodGroup.setAll("movingSpeed", scrollSpeed);
								itemGroup.setAll("movingSpeed", scrollSpeed);
								spawner4.stopSpawn();
								tileBackground.changeTile(AssetManager.seaCSV, AssetManager.tileSpacePNG, 32, 32);
								readyText.visible = true;
								//create stars
								for (var i:int = 0; i < 50; i++)
								{
									var tempStar:Star = new Star(FlxG.random() * FlxG.width, - FlxG.random() * FlxG.height * 2);
									tempStar.velocity.y = scrollSpeed * 2 / 3;
									starGroup.add(tempStar);
								}
								for (var j:int = 0; j < 25; j++)
								{
									var tempStar2:Star = new Star(FlxG.random() * FlxG.width, - FlxG.random() * FlxG.height * 2);
									tempStar2.velocity.y = scrollSpeed / 2;
									starGroup.add(tempStar2);
								}
							}
							break;
						case 5:
							if (FlxG.score == 1820)
							{
								spawner5.startSpawn(scrollSpeed, 16, player.damageAmout, 128);
								distance += 30;
								readyText.visible = false;
								spawner4.clear();
							}
							if (FlxG.score >= 2600)
							{
								spawner5.stopSpawn();
								state = STATE_CLEAR;
							}
							break;
					}
					playerCursor.x = progression.x + (FlxG.score / 2600) * progression.width - 3;
					
					break;
			}
			}
			
		}
}