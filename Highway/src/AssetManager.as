package  
{
	import flash.text.Font;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class AssetManager 
	{
		//player & bullets
		[Embed(source = "../assets/character/player.png")]static public var heroPNG:Class;
		[Embed(source = "../assets/character/playerShadow.png")]static public var heroShadowPNG:Class;
		[Embed(source = "../assets/asset/bullet_normal.png")]static public var bulletPNG:Class;
		[Embed(source = "../assets/asset/bullet_shotgun.png")]static public var bulletShotgunPNG:Class;
		[Embed(source = "../assets/asset/bullet_laser.png")]static public var bulletLaserPNG:Class;
		[Embed(source = "../assets/character/player1.png")]static public var playerAnim1PNG:Class;
		[Embed(source = "../assets/character/player2.png")]static public var playerAnim2PNG:Class;
		
		//tile background
		[Embed(source = "../assets/tile/tile_palace.png")]static public var tilePalacePNG:Class;
		[Embed(source = "../assets/tile/tile_forest.png")]static public var tileForestPNG:Class;
		[Embed(source = "../assets/tile/tile_sea.png")]static public var tileSeaPNG:Class;
		[Embed(source = "../assets/tile/tile_sky.png")]static public var tileSkyPNG:Class;
		[Embed(source = "../assets/tile/tile_space.png")]static public var tileSpacePNG:Class;
		[Embed(source = "../assets/tile/tile_challenge.png")]static public var tileChallengePNG:Class;
		[Embed(source = "../assets/tile/upgrade.png")]static public var upgradeBackgroundPNG:Class;
		[Embed(source = "../assets/tile/tile_story.png")]static public var tileStoryPNG:Class;
		[Embed(source = "../assets/tile/tile_snow.png")]static public var tileSnowPNG:Class;
		[Embed(source = "../assets/tile/palace.csv", mimeType = "application/octet-stream")]static public var palaceCSV:Class;
		[Embed(source = "../assets/tile/sea.csv", mimeType = "application/octet-stream")]static public var seaCSV:Class;
		[Embed(source = "../assets/tile/sky.csv", mimeType = "application/octet-stream")]static public var skyCSV:Class;
		[Embed(source = "../assets/tile/story.csv", mimeType = "application/octet-stream")]static public var storyCSV:Class;
		
		//pickup
		[Embed(source = "../assets/asset/item_potion.png")]static public var potionPNG:Class;
		[Embed(source = "../assets/asset/item_invince.png")]static public var invincePNG:Class;
		[Embed(source = "../assets/asset/item_kill.png")]static public var killPNG:Class;
		[Embed(source = "../assets/asset/item_shotgun.png")]static public var shotgunPNG :Class;
		[Embed(source = "../assets/asset/item_laser.png")]static public var laserPNG:Class;
		
		//food
		[Embed(source = "../assets/asset/food1.png")]static public var food1PNG:Class;
		[Embed(source = "../assets/asset/food2.png")]static public var food2PNG:Class;
		[Embed(source = "../assets/asset/food3.png")]static public var food3PNG:Class;
		[Embed(source = "../assets/asset/food4.png")]static public var food4PNG:Class;
		[Embed(source = "../assets/asset/food5.png")]static public var food5PNG:Class;
		
		//enemy
		[Embed(source = "../assets/character/priest.png")]static public var priestPNG:Class;
		[Embed(source = "../assets/character/sister.png")]static public var sisterPNG:Class;
		[Embed(source = "../assets/character/elf.png")]static public var elfPNG:Class;
		[Embed(source = "../assets/character/titan.png")]static public var titanPNG:Class;
		[Embed(source = "../assets/character/amazon.png")]static public var amazonPNG:Class;
		[Embed(source = "../assets/character/pirate.png")]static public var piratePNG:Class;
		[Embed(source = "../assets/character/mermaid.png")]static public var mermaiPNG:Class;
		[Embed(source = "../assets/character/surf.png")]static public var surfPNG:Class;
		[Embed(source = "../assets/character/superman.png")]static public var supermanPNG:Class;
		[Embed(source = "../assets/character/angel.png")]static public var angelPNG:Class;
		[Embed(source = "../assets/character/doraemon.png")]static public var doraemonPNG:Class;
		[Embed(source = "../assets/character/astronaut.png")]static public var astronautPNG:Class;
		[Embed(source = "../assets/character/goku.png")]static public var gokuPNG:Class;
		[Embed(source = "../assets/character/yoda.png")]static public var yodaPNG:Class;
		//boss
		[Embed(source = "../assets/character/boss/hammer.png")]static public var bossHammerPNG:Class;
		[Embed(source = "../assets/character/boss/boss.png")]static public var bossPNG:Class;
		[Embed(source = "../assets/character/boss/bossplane.png")]static public var bossPlanePNG:Class;
		[Embed(source = "../assets/character/boss/chain.png")]static public var chainPNG:Class;
		[Embed(source = "../assets/character/boss/amazon.png")]static public var bossBullet1PNG:Class;
		[Embed(source = "../assets/character/boss/sister.png")]static public var bossBullet2PNG:Class;
		[Embed(source = "../assets/character/boss/priest.png")]static public var bossBullet3PNG:Class;
		[Embed(source = "../assets/character/boss/elf.png")]static public var bossBullet4PNG:Class;
		
		//block
		[Embed(source = "../assets/asset/pillar1.png")]static public var pillar1PNG:Class;
		[Embed(source = "../assets/asset/pillarShadow.png")]static public var pillarShadowPNG:Class;
		[Embed(source = "../assets/asset/light.png")]static public var lightPNG:Class;
		[Embed(source = "../assets/asset/lightShadow.png")]static public var lightShadowPNG:Class;
		[Embed(source = "../assets/asset/well.png")]static public var wellPNG:Class;
		[Embed(source = "../assets/asset/wellShadow.png")]static public var wellShadowPNG:Class;
		[Embed(source = "../assets/asset/piece.png")]static public var piecePNG:Class;
		[Embed(source = "../assets/asset/rock.png")]static public var rockPNG:Class;
		[Embed(source = "../assets/asset/rockShadow.png")]static public var rockShadowPNG:Class;
		[Embed(source = "../assets/asset/tree.png")]static public var treePNG:Class;
		[Embed(source = "../assets/asset/treeShadow.png")]static public var treeShadowPNG:Class;
		[Embed(source = "../assets/asset/buoy.png")]static public var buoyPNG:Class;
		[Embed(source = "../assets/asset/reef.png")]static public var reefPNG:Class;
		[Embed(source = "../assets/asset/submarine.png")]static public var subPNG:Class;
		[Embed(source = "../assets/asset/rocket.png")]static public var rocketPNG:Class;
		[Embed(source = "../assets/asset/paperplane.png")]static public var planePNG:Class;
		[Embed(source = "../assets/asset/cloud.png")]static public var cloudPNG:Class;
		[Embed(source = "../assets/asset/setellite.png")]static public var setellitePNG:Class;
		[Embed(source = "../assets/asset/spaceship.png")]static public var spaceshipPNG:Class;
		[Embed(source = "../assets/asset/asteroid.png")]static public var asteroidPNG:Class;
		[Embed(source = "../assets/asset/wellC.png")]static public var wellCPNG:Class;
		[Embed(source = "../assets/asset/buoyC.png")]static public var buoyCPNG:Class;
		[Embed(source = "../assets/asset/table.png")]static public var tablePNG:Class;
		
		//enemy pattern CSV
		[Embed(source = "../doc/pattern/basic1.csv", mimeType = "application/octet-stream")]static public var basic1CSV:Class;
		[Embed(source = "../doc/pattern/basic2.csv", mimeType = "application/octet-stream")]static public var basic2CSV:Class;
		[Embed(source = "../doc/pattern/basic3.csv", mimeType = "application/octet-stream")]static public var basic3CSV:Class;
		[Embed(source = "../doc/pattern/basic4.csv", mimeType = "application/octet-stream")]static public var basic4CSV:Class;
		[Embed(source = "../doc/pattern/basic5.csv", mimeType = "application/octet-stream")]static public var basic5CSV:Class;
		[Embed(source = "../doc/pattern/patter2_1.csv", mimeType = "application/octet-stream")]static public var pattern2_1CSV:Class;
		[Embed(source = "../doc/pattern/patter2_2.csv", mimeType = "application/octet-stream")]static public var pattern2_2CSV:Class;
		[Embed(source = "../doc/pattern/patter2_3.csv", mimeType = "application/octet-stream")]static public var pattern2_3CSV:Class;
		[Embed(source = "../doc/pattern/patter3_1.csv", mimeType = "application/octet-stream")]static public var pattern3_1CSV:Class;
		[Embed(source = "../doc/pattern/patter3_2.csv", mimeType = "application/octet-stream")]static public var pattern3_2CSV:Class;
		[Embed(source = "../doc/pattern/patter4_1.csv", mimeType = "application/octet-stream")]static public var pattern4_1CSV:Class;
		[Embed(source = "../doc/pattern/patter4_2.csv", mimeType = "application/octet-stream")]static public var pattern4_2CSV:Class;
		[Embed(source = "../doc/pattern/patter5_1.csv", mimeType = "application/octet-stream")]static public var pattern5_1CSV:Class;
		[Embed(source = "../doc/pattern/patter5_2.csv", mimeType = "application/octet-stream")]static public var pattern5_2CSV:Class;
		
		//UI elements
		[Embed(source = "../assets/UI/HP.png")]static public var HPIconPNG:Class;
		[Embed(source = "../assets/UI/stamina.png")]static public var staminaIconPNG:Class;
		[Embed(source = "../assets/UI/hpbar.png")]static public var hpBarPNG:Class;
		[Embed(source = "../assets/UI/hpbarEmpty.png")]static public var hpBarEmptyPNG:Class;
		[Embed(source = "../assets/UI/staminabar.png")]static public var staminaBarPNG:Class;
		[Embed(source = "../assets/UI/staminabarEmpty.png")]static public var staminaBarEmptyPNG:Class;
		[Embed(source = "../assets/UI/needHP.png")]static public var wantHPPNG:Class;
		[Embed(source = "../assets/UI/needStamina.png")]static public var wantStamina:Class;
		[Embed(source = "../assets/UI/pauseOn.png")]static public var pauseOnPNG:Class;
		[Embed(source = "../assets/UI/pauseOff.png")]static public var pauseOffPNG:Class;
		[Embed(source = "../assets/UI/button.png")]static public var buttonPNG:Class;
		[Embed(source = "../assets/UI/cursor.png")]static public var cursorPNG:Class;
		[Embed(source = "../assets/UI/playerCursor.png")]static public var playerCursorPNG:Class;
		[Embed(source = "../assets/UI/progression.png")]static public var progressionPNG:Class;
		[Embed(source = "../assets/UI/scroll192.png")]static public var scrollLPNG:Class;
		[Embed(source = "../assets/UI/coin.png")]static public var coinPNG:Class;
		[Embed(source = "../assets/UI/upgrade.png")]static public var upgradePNG:Class;
		[Embed(source = "../assets/UI/upgradeDisable.png")]static public var upgradeDisablePNG:Class;
		[Embed(source = "../assets/UI/description.png")]static public var descripPNG:Class;
		[Embed(source = "../assets/UI/ability_armor.png")]static public var abl_ArmorPNG:Class;
		[Embed(source = "../assets/UI/ability_attack.png")]static public var abl_AttackPNG:Class;
		[Embed(source = "../assets/UI/ability_hp.png")]static public var abl_HPPNG:Class;
		[Embed(source = "../assets/UI/ability_speed.png")]static public var abl_SpeedPNG:Class;
		[Embed(source = "../assets/UI/ability_stamina.png")]static public var abl_StaminaPNG:Class;
		[Embed(source = "../assets/UI/hiligh_armor.png")]static public var hilight_ArmorPNG:Class;
		[Embed(source = "../assets/UI/hilight_attack.png")]static public var hilight_AttackPNG:Class;
		[Embed(source = "../assets/UI/hilight_hp.png")]static public var hilight_HPPNG:Class;
		[Embed(source = "../assets/UI/hilight_speed.png")]static public var hilight_SpeedPNG:Class;
		[Embed(source = "../assets/UI/hilight_stamina.png")]static public var hilight_StaminaPNG:Class;
		[Embed(source = "../assets/UI/tip.png")]static public var tipPNG:Class;
		[Embed(source = "../assets/UI/scroll96.png")]static public var scrollMPNG:Class;
		[Embed(source = "../assets/UI/scoreIcon.png")]static public var scoreIconPNG:Class;
		[Embed(source = "../assets/UI/countIcon.png")]static public var countIconPNG:Class;
		[Embed(source = "../assets/UI/home.png")]static public var homePNG:Class;
		[Embed(source = "../assets/UI/keyboard.png")]static public var keyboardPNG:Class;
		[Embed(source = "../assets/UI/keyboardOff.png")]static public var keyboardOffPNG:Class;
		[Embed(source = "../assets/UI/mouse.png")]static public var mousePNG:Class;
		[Embed(source = "../assets/UI/mouseOff.png")]static public var mouseOffPNG:Class;
		[Embed(source = "../assets/UI/music.png")]static public var musicONPNG:Class;
		[Embed(source = "../assets/UI/musicOff.png")]static public var musicOFFPNG:Class;
		[Embed(source = "../assets/UI/SFX.png")]static public var SFXONPNG:Class;
		[Embed(source = "../assets/UI/SFXOFF.png")]static public var SFXOFFPNG:Class;
		[Embed(source = "../assets/UI/resume.png")]static public var resumePNG:Class;
		[Embed(source = "../assets/UI/gotoUpgrade.png")]static public var gotoUpgradePNG:Class;
		[Embed(source = "../assets/UI/pauseBackground.png")]static public var pauseBackgroundPNG:Class;
		[Embed(source = "../assets/UI/tutorial.png")]static public var tutorialBackgroundPNG:Class;
		[Embed(source = "../../_fixel/org/flixel/data/vcr/flixel.png")]static public var flixelPNG:Class;
		[Embed(source = "../assets/UI/playNormal.png")]static public var playUpPNG:Class;
		[Embed(source = "../assets/UI/playOver.png")]static public var playOverPNG:Class;
		[Embed(source = "../assets/UI/playDonw.png")]static public var playDownPNG:Class;
		
		//background music
		[Embed(source = "../assets/music/levelBGM.mp3")]static public var levelBGM:Class;
		[Embed(source = "../assets/music/titleBGM.mp3")]static public var titleBGM:Class;
		[Embed(source = "../assets/music/bossGBM.mp3")]static public var bossBGM:Class;
		[Embed(source = "../assets/music/win.mp3")]static public var winJINGLE:Class;
		
		//sound effect
		[Embed(source = "../assets/sfx/invincible.mp3")]static public var invincibleSFX:Class;
		[Embed(source = "../assets/sfx/getHP.mp3")]static public var hpSFX:Class;
		[Embed(source = "../assets/sfx/getFood.mp3")]static public var foodSFX:Class;
		[Embed(source = "../assets/sfx/changeWeapon.mp3")]static public var weaponSFX:Class;
		[Embed(source = "../assets/sfx/killAll.mp3")]static public var killAllSFX:Class;
		[Embed(source = "../assets/sfx/hit.mp3")]static public var hitBlockSFX:Class;
		[Embed(source = "../assets/sfx/damage.mp3")]static public var hitBulletSFX:Class;
		[Embed(source = "../assets/sfx/hitEnemy.mp3")]static public var shootSFX:Class;
		[Embed(source = "../assets/sfx/laser.mp3")]static public var hitLaserSFX:Class;
		[Embed(source = "../assets/sfx/starve.mp3")]static public var starveSFX:Class;
		[Embed(source = "../assets/sfx/killEnemy.mp3")]static public var exploSFX:Class;
		[Embed(source = "../assets/sfx/button.mp3")]static public var clickSFX:Class;
		[Embed(source = "../assets/sfx/button2.mp3")]static public var selectSFX:Class;
		[Embed(source = "../assets/sfx/upgrade.mp3")]static public var upgradeSFX:Class;
		[Embed(source = "../assets/sfx/beep.mp3")]static public var beepSFX:Class;
		[Embed(source = "../assets/sfx/start.mp3")]static public var startSFX:Class;
		[Embed(source = "../assets/sfx/bossAttack.mp3")]static public var bossAttackSFX:Class;
		[Embed(source = "../assets/sfx/grab.mp3")]static public var bossGrabSFX:Class;
		[Embed(source = "../assets/sfx/explo.mp3")]static public var boomSFX:Class;
		[Embed(source = "../assets/sfx/transform.mp3")]static public var transformSFX:Class;
		
		public function AssetManager() 
		{
			
		}
		
	}

}