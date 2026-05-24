package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.API.FlxKongregate;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class TitlePage extends FlxState
	{
		private var title:FlxText;
		private var title2:FlxText;
		private var startButton:FlxButton;
		private var challengeButton:FlxButton;
		private var eraseButton:FlxButton;
		private var creditButton:FlxButton;
		private var background:TileBackground;
		private var tip:FlxSprite;
		
		override public function create():void
		{
			super.create();
			
			SaveData.onLoad();
			
			background = new TileBackground();
			background.loadMap(new AssetManager.skyCSV, AssetManager.tileSkyPNG, 32, 32);
			background.scrollMap(64);
			add(background);
			
			title = new FlxText(0, 64, FlxG.width, "DON'T TOUCH");
			title.setFormat(null, 16, 0xffffffff, "center", 0xffff5000);
			add(title);
			title2 = new FlxText(0, 82, FlxG.width, "MY FOOD");
			title2.setFormat(null, 24, 0xffff5000, "center", 0xffffffff);
			add(title2);
			
			startButton = new FlxButton(32, 150, "NEW GAME", startGame);
			startButton.loadGraphic(AssetManager.buttonPNG, false, false, 112, 20);
			startButton.label.setFormat(null, 8, 0xffffffff, "center", 0xff000000);
			startButton.labelOffset.x = 16;
			add(startButton);
			
			challengeButton = new FlxButton(startButton.x, startButton.y + startButton.height + 4, "ENDLESS MODE", goToChallenge);
			challengeButton.visible = SaveData.challengeOn;
			challengeButton.loadGraphic(AssetManager.buttonPNG, false, false, 112, 20);
			challengeButton.label.setFormat(null, 8, 0xffffffff, "center", 0xff000000);
			challengeButton.labelOffset.x = 16;
			add(challengeButton);
			
			tip = new FlxSprite( -100, -100, AssetManager.tipPNG);
			tip.exists = false;
			add(tip);
			if (SaveData.challengeOn && !SaveData.isCleared)
			{
				SaveData.isCleared = true;
				tip.reset(challengeButton.x + challengeButton.width - tip.width / 2, challengeButton.y - tip.height / 2);
			}
			
			eraseButton = new FlxButton(startButton.x, challengeButton.y + challengeButton.height + 4, "CLEAR SAVE", eraseData);
			eraseButton.visible = false;
			eraseButton.loadGraphic(AssetManager.buttonPNG, false, false, 112, 20);
			eraseButton.label.setFormat(null, 8, 0xffffffff, "center", 0xff000000);
			eraseButton.labelOffset.x = 16;
			add(eraseButton);
			
			creditButton = new FlxButton(startButton.x, eraseButton.y + eraseButton.height + 4, "CREDITS", goToCredits);
			creditButton.loadGraphic(AssetManager.buttonPNG, false, false, 112, 20);
			creditButton.label.setFormat(null, 8, 0xffffffff, "center", 0xff000000);
			creditButton.labelOffset.x = 16;
			add(creditButton);
			
			if (SaveData.saved)
			{
				startButton.label.text = "CONTINUE";
				eraseButton.visible = true;
				if (!SaveData.challengeOn)
				{
					eraseButton.reset(startButton.x, startButton.y + startButton.height + 4);
					creditButton.reset(startButton.x, eraseButton.y + eraseButton.height + 4);
				}
			}else {
				creditButton.reset(startButton.x, startButton.y + startButton.height + 4);
			}
			
			FlxKongregate.init(loadKAPI);
			
			if (ShareData.musicOn)
			{
				if (FlxG.music != null)
				{
					FlxG.music.stop();
				}
				FlxG.playMusic(AssetManager.titleBGM, 0.5);
			}
			
			ShareData.bgmType = ShareData.BGM_TITLE;
		}
		
		override public function update():void
		{
			super.update();
		}
		
		private function startGame():void
		{
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
			if (SaveData.saved)
			{
				FlxG.switchState(new MainLevel);
				if (ShareData.musicOn)
				{
					FlxG.music.stop();
					//FlxG.playMusic(AssetManager.levelBGM);
				}
				SaveData.onSave();
			}else {
				FlxG.music.stop();
				FlxG.switchState(new StoryPage);
			}
			
			//for debug test
			//SaveData.coin += 1000000;
		}
		
		private function eraseData():void
		{
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
			SaveData.erase();
			eraseButton.visible = false;
			challengeButton.visible = false;
			startButton.label.text = "NEW GAME";
			creditButton.reset(startButton.x, startButton.y + startButton.height + 4);
		}
		
		private function goToChallenge():void
		{
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
			FlxG.switchState(new ChallengeLevel);
		}
		private function goToCredits():void
		{
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
			FlxG.switchState(new Credits);
		}
		
		private function loadKAPI():void
		{
			trace("connected");
		}
		
	}

}