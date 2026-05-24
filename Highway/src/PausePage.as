package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class PausePage extends FlxGroup
	{
		public var x:Number;
		public var y:Number;
		private var background:FlxSprite;
		private var pauseText:FlxText;
		private var soundText:FlxText;
		private var musicButton:FlxButton;
		private var sfxButton:FlxButton;
		private var controlText:FlxText;
		private var keyboardButton:FlxButton;
		private var mouseButton:FlxButton;
		private var homeButton:FlxButton;
		private var resumeButton:FlxButton;
		private var upgradeButton:FlxButton;
		public var pauseButton:FlxButton;
		private var tipText:FlxText;
		
		public function PausePage(X:Number, Y:Number) 
		{
			super();
			
			x = X;
			y = Y;
			background = new FlxSprite(x, y, AssetManager.pauseBackgroundPNG);
			//background.makeGraphic(128, 180, 0xffe1c184);
			add(background);
			
			pauseText = new FlxText(x, y + 4, background.width, "PAUSE");
			pauseText.setFormat(null, 16, 0xff4f3d1b, "center", 0xffffffff);
			add(pauseText);
			
			soundText = new FlxText(x, pauseText.y + pauseText.height + 8, background.width, "SOUND");
			soundText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			add(soundText);
			
			musicButton = new FlxButton(x + background.width / 2 - 28, soundText.y + soundText.height + 4, null, switchMusic);
			if (ShareData.musicOn)
			{
				musicButton.loadGraphic(AssetManager.musicONPNG);
			}else {
				musicButton.loadGraphic(AssetManager.musicOFFPNG);
			}
			add(musicButton);
			
			sfxButton = new FlxButton(x + background.width / 2 + 4, soundText.y +  soundText.height + 4, null, switchSFX);
			if (ShareData.soundOn)
			{
				sfxButton.loadGraphic(AssetManager.SFXONPNG);
			}else {
				sfxButton.loadGraphic(AssetManager.SFXOFFPNG);
			}
			add(sfxButton);
			
			controlText = new FlxText(x, sfxButton.y + sfxButton.height + 4,background.width, "CONTROL TYPE");
			controlText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			add(controlText);
			
			mouseButton = new FlxButton(musicButton.x, controlText.y + controlText.height + 4, null, onMouse);
			add(mouseButton);
			
			keyboardButton = new FlxButton(sfxButton.x, mouseButton.y, null, onKeyboard);
			add(keyboardButton);
			//switch control type
			if (ShareData.mouseControl)
			{
				mouseButton.loadGraphic(AssetManager.mousePNG);
				keyboardButton.loadGraphic(AssetManager.keyboardOffPNG);
			}else {
				mouseButton.loadGraphic(AssetManager.mouseOffPNG);
				keyboardButton.loadGraphic(AssetManager.keyboardPNG);
			}
			
			homeButton = new FlxButton(musicButton.x - 16, mouseButton.y + mouseButton.height + 24, null, goHome);
			homeButton.loadGraphic(AssetManager.homePNG);
			add(homeButton);
			
			upgradeButton = new FlxButton(musicButton.x+16, homeButton.y, null, gotoUpgrade);
			upgradeButton.loadGraphic(AssetManager.gotoUpgradePNG);
			add(upgradeButton);
			
			resumeButton = new FlxButton(sfxButton.x + 16, homeButton.y - 8, null, resume);
			resumeButton.loadGraphic(AssetManager.resumePNG);
			add(resumeButton);
			
			pauseButton = new FlxButton(2, FlxG.height - 18, null, onPause);
			if (FlxG.paused)
			{
				pauseButton.loadGraphic(AssetManager.pauseOnPNG);
			}else {
				pauseButton.loadGraphic(AssetManager.pauseOffPNG);
			}
			add(pauseButton);
			
			tipText = new FlxText( -100, -100, FlxG.width);
			tipText.setFormat(null, 8, 0xff4f3d1b, "left", 0xffffffff);
			add(tipText);
			
			setAll("visible", false);
			pauseButton.visible = true;
		}
		
		override public function update():void
		{
			super.update();
			
			if (FlxG.paused)
			{
				if (homeButton.overlapsPoint(FlxG.mouse))
				{
					tipText.reset(FlxG.mouse.x, FlxG.mouse.y + 12);
					tipText.text = "GO TO MAINMENU";
					tipText.visible = true;
				}else if (upgradeButton.overlapsPoint(FlxG.mouse))
				{
					tipText.reset(FlxG.mouse.x, FlxG.mouse.y + 12);
					tipText.text = "GO TO UPGRADE";
					tipText.visible = true;
				}else if (resumeButton.overlapsPoint(FlxG.mouse))
				{
					tipText.reset(FlxG.mouse.x, FlxG.mouse.y + 12);
					tipText.text = "RESUME";
					tipText.visible = true;
				}else {
					tipText.visible = false;
				}
			}
		}
		
		public function startPause():void
		{
			FlxG.paused = true;
			setAll("visible", true);
			pauseButton.loadGraphic(AssetManager.pauseOnPNG);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		public function resume():void
		{
			FlxG.paused = false;
			pauseButton.loadGraphic(AssetManager.pauseOffPNG);
			setAll("visible", false);
			pauseButton.visible = true;
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		private function switchMusic():void
		{
			ShareData.musicOn = !ShareData.musicOn;
			if (ShareData.musicOn)
			{
				musicButton.loadGraphic(AssetManager.musicONPNG);
				
				if (ShareData.bgmType == ShareData.BGM_LEVEL)
				{
					FlxG.playMusic(AssetManager.levelBGM);
				}else if (ShareData.bgmType == ShareData.BGM_BOSS)
				{
					FlxG.playMusic(AssetManager.bossBGM);
				}
			}else {
				musicButton.loadGraphic(AssetManager.musicOFFPNG);
				FlxG.music.stop()
			}
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		
		private function switchSFX():void
		{
			ShareData.soundOn = !ShareData.soundOn;
			if (ShareData.soundOn)
			{
				sfxButton.loadGraphic(AssetManager.SFXONPNG);
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.selectSFX);
				}
			}else {
				sfxButton.loadGraphic(AssetManager.SFXOFFPNG);
			}
		}
		
		private function onMouse():void
		{
			ShareData.mouseControl = true;
			mouseButton.loadGraphic(AssetManager.mousePNG);
			keyboardButton.loadGraphic(AssetManager.keyboardOffPNG);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		
		private function onKeyboard():void
		{
			ShareData.mouseControl = false;
			mouseButton.loadGraphic(AssetManager.mouseOffPNG);
			keyboardButton.loadGraphic(AssetManager.keyboardPNG);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		
		private function goHome():void
		{
			FlxG.paused = false;
			SaveData.onSave();
			FlxG.switchState(new TitlePage);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		private function gotoUpgrade():void
		{
			FlxG.paused = false;
			SaveData.onSave();
			FlxG.switchState(new UpgradePage);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		private function onPause():void
		{
			FlxG.paused = !FlxG.paused;
			if (FlxG.paused)
			{
				startPause();
			}else {
				resume();
				if (ShareData.soundOn)
				{
					FlxG.play(AssetManager.clickSFX);
				}
			}
		}
	}

}