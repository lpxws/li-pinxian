package UI 
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class CompleText extends FlxGroup
	{
		public var deadText:FlxText; 
		public var nextButton:FlxButton;
		public var scoreText:FlxText;
		public var countText:FlxText;
		public var coinText:FlxText;
		public var newScoreText:FlxText;
		public var backGround:FlxSprite;
		public var coinIcon:FlxSprite;
		public var scoreIcon:FlxSprite;
		public var countIcon:FlxSprite;
		public var line:FlxSprite;
		private var showDelay:FlxDelay;
		private var showInterval:int;
		private var tipText:FlxText;
		
		public function CompleText() 
		{
			super();
			
			FlxG.worldBounds = new FlxRect(0, 12, FlxG.width, FlxG.height - 12);
			
			backGround = new FlxSprite(32, 48);
			backGround.loadGraphic(AssetManager.scrollMPNG, true, false, 128, 160);
			backGround.addAnimation("open", [1, 2, 3, 4, 0], 15, false);
			add(backGround);
			
			deadText = new FlxText(0, backGround.y + 20, FlxG.width);
			deadText.setFormat(null, 16, 0xff4f3d1b, "center", 0xffffffff);
			add(deadText);
			
			scoreText = new FlxText(backGround.x, deadText.y + 32, backGround.width - 32);
			scoreText.setFormat(null, 8, 0xff4f3d1b, "right", 0xffffffff);
			add(scoreText);
			
			scoreIcon = new FlxSprite(64, deadText.y + 32, AssetManager.scoreIconPNG);
			add(scoreIcon);
			
			countText = new FlxText(backGround.x, scoreText.y + 16, backGround.width - 32);
			countText.setFormat(null, 8, 0xff4f3d1b, "right", 0xffffffff);
			add(countText);
			
			countIcon = new FlxSprite(64, countText.y, AssetManager.countIconPNG);
			add(countIcon);
			
			line = new FlxSprite(48, countText.y + 16);
			line.makeGraphic(92, 2, 0xff4f3d1b);
			add(line);
			
			coinText = new FlxText(backGround.x, countText.y + 24 , backGround.width - 32 );
			coinText.setFormat(null, 8, 0xff4f3d1b, "right", 0xffffffff);
			add(coinText);
			coinIcon = new FlxSprite(64, coinText.y, AssetManager.coinPNG);
			add(coinIcon);
			
			newScoreText = new FlxText(0, 86, FlxG.width, "NEW RECORD");
			newScoreText.setFormat(null, 8, 0xffff0000, "center", 0xffffffff);
			add(newScoreText);
			
			nextButton = new FlxButton(64, coinText.y + 24 , "NEXT", goToUpgrade)
			nextButton.loadGraphic(AssetManager.upgradePNG, false, false, 64, 20);
			nextButton.visible = false;
			add(nextButton);
			
			tipText = new FlxText( -100, -100, FlxG.width);
			tipText.setFormat(null, 8, 0xff4f3d1b, "left", 0xffffffff);
			add(tipText);
			
			setAll("visible", false);
			
			showInterval = 200;
			showDelay = new FlxDelay(showInterval);
		}
		
		override public function update():void
		{
			super.update();
			
			if (!deadText.visible && showDelay.hasExpired)
			{
				deadText.visible = true;
				showDelay.reset(showInterval);
			
				if (FlxG.score > SaveData.bestScore)
				{
					SaveData.bestScore = FlxG.score;
					newScoreText.visible = true;
				}
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.beepSFX);
				}
			}
			if (!scoreText.visible && showDelay.hasExpired && deadText.visible)
			{
				scoreText.visible = true;
				scoreIcon.visible = true;
				showDelay.reset(showInterval);
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.beepSFX);
				}
			}
			if (!countText.visible && showDelay.hasExpired && scoreText.visible)
			{
				countText.visible = true;
				countIcon.visible = true;
				showDelay.reset(showInterval);
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.beepSFX);
				}
			}
			if (!coinText.visible && showDelay.hasExpired && countText.visible)
			{
				coinText.visible = true;
				line.visible = true;
				coinIcon.visible = true;
				showDelay.reset(showInterval);
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.upgradeSFX);
				}
			}
			if (!nextButton.visible && showDelay.hasExpired && coinText.visible)
			{
				nextButton.visible = true;
			}
			
			if (coinIcon.visible)
			{
				if (scoreIcon.overlapsPoint(FlxG.mouse))
				{
					tipText.reset(FlxG.mouse.x, FlxG.mouse.y + 12);
					tipText.text = "DISTANCE";
					tipText.visible = true;
				}else if (countIcon.overlapsPoint(FlxG.mouse))
				{
					tipText.reset(FlxG.mouse.x, FlxG.mouse.y + 12);
					tipText.text = "ENEMIES KILLED";
					tipText.visible = true;
				}else if (coinIcon.overlapsPoint(FlxG.mouse))
				{
					tipText.reset(FlxG.mouse.x, FlxG.mouse.y + 12);
					tipText.text = "COINS";
					tipText.visible = true;
				}else {
					tipText.visible = false;
				}
				
			}
		}
		
		public function start(deadWay:int,enemyCount:int, levelMode:int):void
		{
			/*
			*/
			
			backGround.visible = true;
			backGround.play("open");
			
			ShareData.exchangeCoin(FlxG.score, enemyCount);
			//subummit score to Kongregete API
			if (levelMode == _level.MODE_STORY)
			{
				FlxKongregate.submitStats("Best Score(Story Mode)", FlxG.score);
			}else if (levelMode == _level.MODE_CHALLENGE) {
				FlxKongregate.submitStats("Best Score(Challenge Mode)", FlxG.score);
			}
			
			if (deadWay == Player.DEAD_KILLED)
			{
				deadText.text = "KILLED";
			}else if (deadWay == Player.DEAD_STARVE){
				deadText.text = "STARVE";
			}else if (deadWay == Player.DEAD_WIN) {
				deadText.text = "YOU WIN";
			}
			scoreText.text = FlxG.score + "M";
			countText.text = enemyCount.toString();
			coinText.text = "+ " + ShareData.coinCount;
			
			showDelay.start();
		}
		 
		public function goToUpgrade():void
		{
			//exchange distance into coins
			SaveData.onSave();
			FlxG.switchState(new UpgradePage);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
	}

}