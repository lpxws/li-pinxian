package item 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class itemSpawner extends FlxGroup
	{
		public var potionGroup:FlxGroup;
		public var inviceGroup:FlxGroup;
		public var killGroup:FlxGroup;
		public var shotgunGroup:FlxGroup;
		public var laserGroup:FlxGroup;
		public var itemGroup:FlxGroup;
		
		public function itemSpawner(initiateNum:uint) 
		{
			potionGroup = new FlxGroup();
			inviceGroup = new FlxGroup();
			killGroup = new FlxGroup();
			shotgunGroup = new FlxGroup();
			laserGroup = new FlxGroup();
			itemGroup = new FlxGroup();
			var i:uint;
			for (i = 1; i <= initiateNum; i++) 
			{
				var potion:item_potion = new item_potion( -100, -100);
				potion.exists = false;
				potionGroup.add(potion);
				add(potion);
				var invince:item_invince = new item_invince( -100, -100);
				invince.exists = false;
				inviceGroup.add(invince);
				add(invince)
				var killAll:item_kill = new item_kill( -100, -100);
				killAll.exists = false;
				killGroup.add(killAll);
				add(killAll)
				var shotgun:item_shotgun = new item_shotgun( -100, -100);
				shotgun.exists = false;
				shotgunGroup.add(shotgun);
				add(shotgun);
				var laser:item_laser = new item_laser( -100, -100);
				laser.exists = false;
				laserGroup.add(laser);
				add(laser);
			}
			/*
			itemGroup.add(potionGroup);
			itemGroup.add(inviceGroup);
			itemGroup.add(killGroup);
			itemGroup.add(shotgunGroup);
			itemGroup.add(laserGroup);
			*/
		}
		
		public function spawn(X:Number, Y:Number, speed:int):void
		{
			var tempItem:*;
			var tempNum:int = int(FlxG.random() * 5);
			switch(tempNum)
			{
				case 0:
					tempItem = potionGroup.recycle() as item_potion;
					break;
				case 1:
					tempItem = inviceGroup.recycle() as item_invince;
					break;
				case 2:
					tempItem = killGroup.recycle() as item_kill;
					break;
				case 3:
					tempItem = shotgunGroup.recycle() as item_shotgun;
					break;
				case 4:
					tempItem = laserGroup.recycle() as item_laser;
					break;
			}
			tempItem.reset(X, Y);
			tempItem.movingSpeed = speed;
		}
		
	}

}