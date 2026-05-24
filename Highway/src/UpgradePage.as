package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxDelay;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class UpgradePage extends FlxState
	{
		private var UIGroup:FlxGroup;
		private var isAnimeOver:Boolean = false;
		private var animeDelay:FlxDelay;
		
		private var upgradeButton:FlxButton;
		private var upgradeDisable:FlxButton;
		private var restartButton:FlxButton;
		private var challengeButton:FlxButton;
		private var homeButton:FlxButton;
		private var coinText:FlxText;
		private var coinIcon:FlxSprite;
		private var priceText:FlxText;
		private var nameText:FlxText;
		private var descriText:FlxText;
		private var descriBack:FlxSprite;
		
		private var hpButton:FlxButton;
		private var staminaButton:FlxButton;
		private var attackButton:FlxButton;
		private var armorButton:FlxButton;
		private var speedButton:FlxButton;
		private var fakeButton:FlxSprite;
		private var hpTip:FlxSprite;
		private var staminaTip:FlxSprite;
		private var attackTip:FlxSprite;
		private var armorTip:FlxSprite;
		private var speedTip:FlxSprite;
		private var tipArray:Array;
		
		private var currentSelected:int;
		private var currentPrice:int;
		private const SELECT_HP:int = 0;
		private const SELECT_STAMINA:int = 1;
		private const SELECT_ATTACK:int = 2;
		private const SELECT_ARMOR:int = 3;
		private const SELECT_SPEED:int = 4;
		
		private var background:TileBackground;;
		private var scroll:FlxSprite;
		
		override public function create():void
		{
			super.create();
			
			UIGroup = new FlxGroup();
			animeDelay = new FlxDelay(250);
			animeDelay.start();
			
			background = new TileBackground();
			background.loadMap(new AssetManager.seaCSV, AssetManager.upgradeBackgroundPNG, 32, 32);
			add(background);
			
			scroll = new FlxSprite(0, 0);
			scroll.loadGraphic(AssetManager.scrollLPNG, true, false, 192, 280);
			scroll.addAnimation("open", [1, 2, 3, 4, 0], 20, false);
			add(scroll);
			scroll.play("open");
			
			currentSelected = SELECT_HP;
			currentPrice = ShareData.hpPirces[SaveData.hpLevel + 1];
			
			restartButton = new FlxButton(70, FlxG.height - 26, "TRY AGAIN", restart);
			if (SaveData.challengeOn)
			{
				restartButton.label.text = "STORY MODE";
			}
			restartButton.loadGraphic(AssetManager.buttonPNG, false, false, 112, 20);
			restartButton.label.setFormat(null, 8, 0xffffffff, "center", 0xff000000);
			restartButton.labelOffset.x = 16;
			add(restartButton);
			UIGroup.add(restartButton);
			
			challengeButton = new FlxButton(restartButton.x, restartButton.y - 26, "ENDLESS MODE", challenge);
			challengeButton.loadGraphic(AssetManager.buttonPNG, false, false, 112, 20);
			challengeButton.visible = SaveData.challengeOn;
			challengeButton.label.setFormat(null, 8, 0xffffffff, "center", 0xff000000);
			challengeButton.labelOffset.x = 16;
			add(challengeButton);
			UIGroup.add(challengeButton);
			
			homeButton = new FlxButton(2, FlxG.height - 26, null, goMainMenu);
			homeButton.loadGraphic(AssetManager.homePNG);
			add(homeButton);
			UIGroup.add(homeButton);
			
			coinIcon = new FlxSprite(2, 2, AssetManager.coinPNG);
			add(coinIcon);
			UIGroup.add(coinIcon);
			coinText = new FlxText(coinIcon.x + coinIcon.width + 2, 4, FlxG.width - coinIcon.width - 4, null);
			coinText.setFormat(null, 8, 0xffffffff, "left", 0xff000000);
			coinText.text = SaveData.coin.toString();
			add(coinText);
			
			hpButton = new FlxButton(38, 53, null, onHP);
			//hpButton.makeGraphic(32, 32, 0xffff0000);
			hpButton.loadGraphic(AssetManager.abl_HPPNG, false, false, 32, 32);
			add(hpButton);
			UIGroup.add(hpButton);
			staminaButton = new FlxButton(hpButton.x + hpButton.width + 12, hpButton.y + hpButton.height / 2 + 2 , null, onStamina);
			//staminaButton.makeGraphic(32, 32, 0xffff0000);
			staminaButton.loadGraphic(AssetManager.abl_StaminaPNG, false, false, 32, 32);
			add(staminaButton);
			UIGroup.add(staminaButton);
			attackButton = new FlxButton(staminaButton.x + staminaButton.width + 12, hpButton.y, null, onAttack);
			//attackButton.makeGraphic(32, 32, 0xffff0000);
			attackButton.loadGraphic(AssetManager.abl_AttackPNG, false, false, 32, 32);
			add(attackButton);
			UIGroup.add(attackButton);
			armorButton = new FlxButton(hpButton.x, hpButton.y + hpButton.height + 8, null, onArmor);
			//armorButton.makeGraphic(32, 32, 0xffff0000);
			armorButton.loadGraphic(AssetManager.abl_ArmorPNG, false, false, 32, 32);
			add(armorButton);
			UIGroup.add(armorButton);
			speedButton = new FlxButton(attackButton.x, armorButton.y, null, onSpeed);
			//speedButton.makeGraphic(32, 32, 0xffff0000);
			speedButton.loadGraphic(AssetManager.abl_SpeedPNG, false, false, 32, 32);
			add(speedButton);
			UIGroup.add(speedButton);
			fakeButton = new FlxSprite(hpButton.x, hpButton.y);
			fakeButton.loadGraphic(AssetManager.hilight_HPPNG);
			add(fakeButton);
			UIGroup.add(fakeButton);
			
			hpTip = new FlxSprite(hpButton.x + hpButton.height - 6, hpButton.y - 4, AssetManager.tipPNG);
			hpTip.visible = false;
			add(hpTip);
			UIGroup.add(hpTip);
			staminaTip = new FlxSprite(staminaButton.x + staminaButton.height - 6, staminaButton.y - 4, AssetManager.tipPNG);
			staminaTip.visible = false;
			add(staminaTip);
			UIGroup.add(staminaTip);
			attackTip = new FlxSprite(attackButton.x + attackButton.height - 6, attackButton.y - 4, AssetManager.tipPNG);
			attackTip.visible = false;
			add(attackTip);
			UIGroup.add(attackTip);
			armorTip = new FlxSprite(armorButton.x + armorButton.height - 6, armorButton.y - 4, AssetManager.tipPNG);
			armorTip.visible = false;
			add(armorTip);
			UIGroup.add(armorTip);
			speedTip = new FlxSprite(speedButton.x + speedButton.height - 6, speedButton.y - 4, AssetManager.tipPNG);
			speedTip.visible = false;
			add(speedTip);
			UIGroup.add(speedTip);
			tipArray = new Array();
			tipArray = [hpTip, staminaTip, attackTip, armorTip, speedTip];
			
			nameText = new FlxText(0, armorButton.y + armorButton.height + 16, FlxG.width,"UPGRADE");
			nameText.setFormat(null, 16, 0xff4f3d1b, "center", 0xffffffff);
			add(nameText);
			UIGroup.add(nameText);
			
			priceText = new FlxText(0, nameText.y + nameText.height + 2, FlxG.width, "COST");
			priceText.text = "COST  " + currentPrice;
			priceText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			add(priceText);
			UIGroup.add(priceText);
			
			upgradeButton = new FlxButton(70, priceText.y + priceText.height + 2, "UPGRADE", upgrade);
			upgradeButton.loadGraphic(AssetManager.upgradePNG, false, false, 64, 20);
			upgradeButton.x = FlxG.width / 2 - upgradeButton.width / 2;
			upgradeDisable = new FlxButton(upgradeButton.x, upgradeButton.y, "UPGRADE");
			upgradeDisable.loadGraphic(AssetManager.upgradeDisablePNG);
			add(upgradeDisable)
			UIGroup.add(upgradeDisable);
			add(upgradeButton);
			UIGroup.add(upgradeButton);
			
			descriBack = new FlxSprite( -100, -100, AssetManager.descripPNG);
			add(descriBack);
			UIGroup.add(descriBack);
			descriText = new FlxText( -100, -100, 80);
			descriText.setFormat(null, 8, 0xff4f3d1b, "center", 0xffffffff);
			add(descriText);
			UIGroup.add(descriText);
			
			UIGroup.setAll("visible", false);
		}
		
		override public function update():void
		{
			super.update();
			
			if (!isAnimeOver && animeDelay.hasExpired)
			{
				isAnimeOver = true;
				UIGroup.setAll("visible", true);
				challengeButton.visible = SaveData.challengeOn;
				updateButton();
			}
			
			if (hpButton.overlapsPoint(FlxG.mouse))
			{
				descriBack.reset(FlxG.mouse.x - 32, FlxG.mouse.y + 8);
				descriText.reset(descriBack.x, descriBack.y + 8 );
				descriText.text = "HEALTH\nLEVEL " + SaveData.hpLevel + "/5";
			}else if (staminaButton.overlapsPoint(FlxG.mouse))
			{
				descriBack.reset(FlxG.mouse.x - 32, FlxG.mouse.y + 8);
				descriText.reset(descriBack.x, descriBack.y + 8 );
				descriText.text = "STAMINA\nLEVEL " + SaveData.staminaLevel + "/5";
			}else if (attackButton.overlapsPoint(FlxG.mouse))
			{
				descriBack.reset(FlxG.mouse.x - 32, FlxG.mouse.y + 8);
				descriText.reset(descriBack.x, descriBack.y + 8 );
				descriText.text = "ATTACK\nLEVEL " + SaveData.attackLevel + "/5";
			}else if (armorButton.overlapsPoint(FlxG.mouse))
			{
				descriBack.reset(FlxG.mouse.x - 32, FlxG.mouse.y + 8);
				descriText.reset(descriBack.x, descriBack.y + 8 );
				descriText.text = "ARMOR\nLEVEL " + SaveData.armorLevel + "/5";
			}else if (speedButton.overlapsPoint(FlxG.mouse))
			{
				descriBack.reset(FlxG.mouse.x - 32, FlxG.mouse.y + 8);
				descriText.reset(descriBack.x, descriBack.y + 8 );
				descriText.text = "SPEED\nLEVEL " + SaveData.hpLevel + "/5";
			}else {
				descriBack.reset( -100, -100);
				descriText.reset( -100, -100);
			}
		}
		
		private function onHP():void
		{
			currentSelected = SELECT_HP;
			nameText.text = "HEALTH";
			//descriText.text = "More HP to endure more damage.";
			fakeButton.reset(hpButton.x, hpButton.y);
			fakeButton.loadGraphic(AssetManager.hilight_HPPNG);
			updateButton();
			
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		private function onStamina():void
		{
			currentSelected = SELECT_STAMINA;
			nameText.text = "STAMINA";
			//descriText.text = "Make Marblor go further.";
			fakeButton.reset(staminaButton.x, staminaButton.y);
			fakeButton.loadGraphic(AssetManager.hilight_StaminaPNG);
			updateButton();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		private function onAttack():void
		{
			currentSelected = SELECT_ATTACK;
			nameText.text = "ATTACK";
			//descriText.text = "Give enemies more damage.";
			fakeButton.reset(attackButton.x, attackButton.y);
			fakeButton.loadGraphic(AssetManager.hilight_AttackPNG);
			updateButton();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		private function onArmor():void
		{
			currentSelected = SELECT_ARMOR;
			nameText.text = "ARMOR";
			//descriText.text = "Reduce the damage from enemies.";
			fakeButton.reset(armorButton.x, armorButton.y);
			fakeButton.loadGraphic(AssetManager.hilight_ArmorPNG);
			updateButton();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		private function onSpeed():void
		{
			currentSelected = SELECT_SPEED;
			nameText.text = "SPEED";
			//descriText.text = "Move faster to evade blocks.";
			fakeButton.reset(speedButton.x, speedButton.y);
			fakeButton.loadGraphic(AssetManager.hilight_SpeedPNG);
			updateButton();
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.selectSFX);
			}
		}
		
		private function upgrade():void
		{
			switch (currentSelected)
			{
				case SELECT_HP:
					SaveData.hpLevel++;
					SaveData.coin -= currentPrice;
					break;
				case SELECT_STAMINA:
					SaveData.staminaLevel++;
					SaveData.coin -= currentPrice;
					break;
				case SELECT_ATTACK:
					SaveData.attackLevel++;
					SaveData.coin -= currentPrice;
					break;
				case SELECT_ARMOR:
					SaveData.armorLevel++;
					SaveData.coin -= currentPrice;
					break;
				case SELECT_SPEED:
					SaveData.speedLevel++;
					SaveData.coin -= currentPrice;
					break;
			}
			
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.upgradeSFX);
			}
			updateButton();
			SaveData.onSave();
		}
		
		private function restart():void
		{
			SaveData.onSave();
			FlxG.switchState(new MainLevel);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		private function challenge():void
		{
			SaveData.onSave();
			FlxG.switchState(new ChallengeLevel);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		private function goMainMenu():void
		{
			SaveData.onSave();
			FlxG.switchState(new TitlePage);
			if (ShareData.soundOn)
			{
				FlxG.play(AssetManager.clickSFX);
			}
		}
		
		private function updateButton():void
		{
			
			for (var i:int = 0; i < tipArray.length; i++)
			{
				var tempPrice:int = showPrice(i);
				if (tempPrice > SaveData.coin || tempPrice == -1)
				{
					tipArray[i].visible = false;
				}else {
					tipArray[i].visible = true;
				}
			}
			
			currentPrice = showPrice(currentSelected);
			
			if (currentPrice > SaveData.coin)
			{
				upgradeButton.visible = false;
			}else {
				upgradeButton.visible = true;
			}
			if (currentPrice == -1)
			{
				priceText.text = "LEVEL MAX";
				upgradeButton.visible = false;
			}else {
				priceText.text = "COST  " + currentPrice;		
			}
			
			coinText.text = SaveData.coin.toString();
		}
		
		private function showPrice(selected:int):int 
		{
			var price:int;
			switch (selected)
			{
				case SELECT_HP:	
					price = ShareData.hpPirces[SaveData.hpLevel + 1];
					break;
				case SELECT_STAMINA:
					price = ShareData.staminaPrices[SaveData.staminaLevel + 1];
					break;
				case SELECT_ATTACK:
					price = ShareData.attackPirces[SaveData.attackLevel + 1];
					break;
				case SELECT_ARMOR:
					price = ShareData.armorPirces[SaveData.armorLevel + 1];
					break;
				case SELECT_SPEED:
					price = ShareData.speedPirces[SaveData.speedLevel + 1];
					break;
			}
			return price;
		}
	}

}