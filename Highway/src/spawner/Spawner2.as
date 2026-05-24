package spawner 
{
	import enemies.*;
	import org.flixel.plugin.photonstorm.FlxBar;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Spawner2 extends Spawner
	{
		public function Spawner2() 
		{
			super();
			patternGroup.push(new AssetManager.basic1CSV);
			//patternGroup.push(new AssetManager.basic2CSV);
			patternGroup.push(new AssetManager.basic3CSV);
			patternGroup.push(new AssetManager.basic4CSV);
			patternGroup.push(new AssetManager.basic5CSV);
			patternGroup.push(new AssetManager.pattern2_1CSV);
			patternGroup.push(new AssetManager.pattern2_2CSV);
			patternGroup.push(new AssetManager.pattern2_3CSV);
			
			for (var i:int = 0; i < 10; i++)
			{
				var tempEnemy:enemy21 = new enemy21( -100, -100);
				tempEnemy.exists = false;
				enemyGroup.add(tempEnemy);
				add(tempEnemy.bloodEmitter);
				
				var tempEnemy2:enemy22 = new enemy22( -100, -100);
				tempEnemy2.exists = false;
				enemyGroup.add(tempEnemy2);
				add(tempEnemy2.bloodEmitter);
				
				var tempEnemy3:enemy23 = new enemy23( -100, -100);
				tempEnemy3.exists = false;
				enemyGroup.add(tempEnemy3);
				add(tempEnemy3.bloodEmitter);
				
				
				var tempBlock:tree = new tree( -100, -100);
				tempBlock.exists = false;
				blockGroup.add(tempBlock);
				shadowGroup.add(tempBlock.shadow);
				add(tempBlock.deadEmitter);
				
				var tempWell:well = new well( -100, -100);
				tempWell.exists = false;
				blockGroup.add(tempWell);
				shadowGroup.add(tempWell.shadow);
				add(tempWell.deadEmitter);
				
				var tempRock:rock = new rock( -100, -100);
				tempRock.exists = false;
				blockGroup.add(tempRock);
				shadowGroup.add(tempRock.shadow);
				add(tempRock.deadEmitter);
				
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