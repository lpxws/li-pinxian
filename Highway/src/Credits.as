package  
{
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Credits extends FlxState
	{
		private var background:TileBackground;
		private var textBackground:FlxSprite;
		private var creditsText:FlxText;
		private var developText:FlxText;
		private var nameText:FlxText;
		private var powerText:FlxText;
		private var flixelText:FlxText;
		private var artText:FlxText;
		private var siteText:FlxText;
		private var musicText:FlxText;
		private var composerText:FlxText;
		private var flixel:FlxSprite;
		private var backButton:FlxButton;
		
		override public function create():void
		{
			super.create();
			
			background = new TileBackground();
			background.loadMap(new AssetManager.palaceCSV, AssetManager.tileForestPNG, 32, 32);
			background.scrollMap(64);
			add(background);
			
			textBackground = new FlxSprite(32, 48, AssetManager.pauseBackgroundPNG);
			add(textBackground);
			
			creditsText = new FlxText(textBackground.x, textBackground.y + 2, textBackground.width, "CREDITS");
			creditsText.setFormat(null, 16, 0xff4f3d1b, "center", 0xffffffff);
			add(creditsText);
			
			developText = new FlxText(textBackground.x, creditsText.y + creditsText.height + 4, textBackground.width);
			developText.setFormat(null, 8, 0xffffffff, "center", 0xff4f3d1b);
			developText.text = "Develop by";
			add(developText);
			
			nameText = new FlxText(textBackground.x, developText.y + developText.height + 2, textBackground.width);
			nameText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			nameText.text = "LI PINXIAN";
			add(nameText);
			
			powerText = new FlxText(textBackground.x, nameText.y + nameText.height + 4, textBackground.width);
			powerText.setFormat(null, 8, 0xffffffff, "center", 0xff4f3d1b);
			powerText.text = "Powered by";
			add(powerText);
			
			flixelText = new FlxText(textBackground.x, powerText.y + powerText.height + 2, textBackground.width);
			flixelText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			flixelText.text = "FLIXEL";
			add(flixelText);
			
			flixel = new FlxSprite(textBackground.x + 40, flixelText.y, AssetManager.flixelPNG);
			add(flixel);
			
			artText = new FlxText(textBackground.x, flixelText.y + flixelText.height + 4, textBackground.width);
			artText.setFormat(null, 8, 0xffffffff, "center", 0xff4f3d1b);
			artText.text = "Resource from";
			add(artText);
			
			siteText = new FlxText(textBackground.x, artText.y + artText.height + 2, textBackground.width);
			siteText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			siteText.text = "OPENGAMEART.ORG";
			add(siteText);
			
			musicText = new FlxText(textBackground.x, siteText.y + siteText.height + 4, textBackground.width);
			musicText.setFormat(null, 8, 0xffffffff, "center", 0xff4f3d1b);
			musicText.text = "Music by";
			add(musicText);
			
			composerText = new FlxText(textBackground.x, musicText.y + musicText.height + 2, textBackground.width);
			composerText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			composerText.text = "Gichco";
			add(composerText);
			
			backButton = new FlxButton(0, 0, "BACK", goBack);
			backButton.loadGraphic(AssetManager.upgradePNG, false, false, 64, 20);
			backButton.reset(FlxG.width - backButton.width - 4, FlxG.height - backButton.height - 4);
			add(backButton);
			
		}
		
		override public function update():void
		{
			super.update()
		}
		
		private function goBack():void
		{
			FlxG.switchState(new TitlePage);
		}
	}

}