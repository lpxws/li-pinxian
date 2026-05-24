package  
{
	import org.flixel.FlxG;
	import spawner.SpawnerChallenge;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class ChallengeLevel extends _level
	{
		private var targetScore:int;
		
		override public function create():void
		{
			super.create();
			scrollSpeed = 128;
			tileBackground.loadMap(new AssetManager.seaCSV, AssetManager.tileSnowPNG, 32, 32);
			tileBackground.scrollMap(scrollSpeed);
			levelMode = _level.MODE_CHALLENGE;
			initSpawner = spawnerC;
			targetScore = 100;
			
			readyText.color = scoreText.color = 0xff4f3d1b;
			readyText.shadow = scoreText.shadow = 0xfffffff;
			//spawnerC.startSpawn(scrollSpeed, 16, player.damageAmout, 128);
			ShareData.bgmType = ShareData.BGM_LEVEL;
			if (ShareData.musicOn)
			{
				FlxG.playMusic(AssetManager.levelBGM);
			}
		}
		
		override public function update():void
		{
			super.update();
			if (FlxG.score >= targetScore)
			{
				targetScore += 500;
				scrollSpeed += 32;
				spawnerC.blockGroup.setAll("movingSpeed", scrollSpeed);
				spawnerC.enemyGroup.setAll("movingSpeed", scrollSpeed);
				spawnerC.scrollSpeed = scrollSpeed;
				tileBackground.scrollMap(scrollSpeed);
			}
		}
		
	}

}