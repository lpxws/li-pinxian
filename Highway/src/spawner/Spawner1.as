package spawner 
{
	import enemies.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Spawner1 extends Spawner
	{
		public function Spawner1() 
		{
			super();
			patternGroup.push(new AssetManager.basic1CSV);
			patternGroup.push(new AssetManager.basic2CSV);
			patternGroup.push(new AssetManager.basic3CSV);
			patternGroup.push(new AssetManager.basic4CSV);
			patternGroup.push(new AssetManager.basic5CSV);
			
			for (var i:int = 0; i < 10; i++)
			{
				var tempEnemy:enemy1 = new enemy1( -100, -100);
				tempEnemy.exists = false;
				enemyGroup.add(tempEnemy);
				add(tempEnemy.bloodEmitter);
				
				var tempEnemy2:enemy12 = new enemy12( -100, -100);
				tempEnemy2.exists = false;
				enemyGroup.add(tempEnemy2);
				add(tempEnemy2.bloodEmitter);
				
				var tempBlock:pillar1 = new pillar1( -100, -100);
				tempBlock.exists = false;
				blockGroup.add(tempBlock);
				shadowGroup.add(tempBlock.shadow);
				add(tempBlock.deadEmitter);
				
				var templight:light1 = new light1( -100, -100);
				templight.exists = false;
				blockGroup.add(templight);
				add(templight.deadEmitter);
				//shadowGroup.add(templight.shadow);
				
				var badHealth:FlxBar = new FlxBar( -100, -100, FlxBar.FILL_LEFT_TO_RIGHT, tempEnemy.width, 4, tempEnemy, "currentHP", 0, tempEnemy.maxHP);
				badHealth.exists = false;
				badHealth.killOnEmpty = true;
				hpBarGroup.add(badHealth);
				
				var badHealth2:FlxBar = new FlxBar( -100, -100, FlxBar.FILL_LEFT_TO_RIGHT, tempEnemy2.width, 4, tempEnemy2, "currentHP", 0, tempEnemy2.maxHP);
				badHealth2.exists = false;
				badHealth2.killOnEmpty = true;
				hpBarGroup.add(badHealth2);
				
				badHealth.createFilledBar(0xff000000, 0xffff0000);
				badHealth2.createFilledBar(0xff000000, 0xffff0000);
			}
		}
		
		
		
	}

}