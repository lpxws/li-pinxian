package spawner 
{
	import enemies.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Spawner4 extends Spawner
	{
		public function Spawner4() 
		{
			super();
			//patternGroup.push(new AssetManager.basic1CSV);
			//patternGroup.push(new AssetManager.basic2CSV);
			//patternGroup.push(new AssetManager.basic3CSV);
			//patternGroup.push(new AssetManager.basic4CSV);
			patternGroup.push(new AssetManager.basic5CSV);
			patternGroup.push(new AssetManager.pattern2_1CSV);
			patternGroup.push(new AssetManager.pattern2_2CSV);
			patternGroup.push(new AssetManager.pattern2_3CSV);
			patternGroup.push(new AssetManager.pattern3_1CSV);
			patternGroup.push(new AssetManager.pattern3_2CSV);
			patternGroup.push(new AssetManager.pattern4_1CSV);
			patternGroup.push(new AssetManager.pattern4_2CSV);
			
			for (var i:int = 0; i < 10; i++)
			{
				var tempEnemy:enemy41 = new enemy41( -100, -100);
				tempEnemy.exists = false;
				enemyGroup.add(tempEnemy);
				add(tempEnemy.bloodEmitter);
				
				var tempEnemy2:enemy42 = new enemy42( -100, -100);
				tempEnemy2.exists = false;
				enemyGroup.add(tempEnemy2);
				add(tempEnemy2.bloodEmitter);
				
				var tempEnemy3:enemy43 = new enemy43( -100, -100);
				tempEnemy3.exists = false;
				enemyGroup.add(tempEnemy3);
				add(tempEnemy3.bloodEmitter);
				
				var tempBlock:rocket = new rocket( -100, -100);
				tempBlock.exists = false;
				blockGroup.add(tempBlock);
				//shadowGroup.add(tempBlock.shadow);
				
				var templight:plane = new plane( -100, -100);
				templight.exists = false;
				blockGroup.add(templight);
				//shadowGroup.add(templight.shadow);
				
				var tempBlock2:cloud = new cloud( -100, -100);
				tempBlock2.exists = false;
				blockGroup.add(tempBlock2);
				
				var badHealth:FlxBar = new FlxBar( -100, -100, FlxBar.FILL_LEFT_TO_RIGHT, tempEnemy.width, 4, tempEnemy, "currentHP", 0, tempEnemy.maxHP);
				badHealth.exists = false;
				badHealth.killOnEmpty = true;
				hpBarGroup.add(badHealth);
				
				var badHealth2:FlxBar = new FlxBar( -100, -100, FlxBar.FILL_LEFT_TO_RIGHT, tempEnemy2.width, 4, tempEnemy2, "currentHP", 0, tempEnemy2.maxHP);
				badHealth2.exists = false;
				badHealth2.killOnEmpty = true;
				hpBarGroup.add(badHealth2);
				
				var badHealth3:FlxBar = new FlxBar( -100, -100, FlxBar.FILL_LEFT_TO_RIGHT, tempEnemy3.width, 4, tempEnemy3, "currentHP", 0, tempEnemy3.maxHP);
				badHealth3.exists = false;
				badHealth3.killOnEmpty = true;
				hpBarGroup.add(badHealth3);
				
				badHealth.createFilledBar(0xff000000, 0xffff0000);
				badHealth2.createFilledBar(0xff000000, 0xffff0000);
				badHealth3.createFilledBar(0xff000000, 0xffff0000);
			}
		}
		
		
		
	}

}