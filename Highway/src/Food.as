package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Food extends Enemy
	{
		public var staminaAmout:int;
		private var imgGroup:Array;
		
		public function Food(X:Number,Y:Number) 
		{
			super(X, Y);
			imgGroup = new Array();
			imgGroup.push(AssetManager.food1PNG);
			imgGroup.push(AssetManager.food2PNG);
			imgGroup.push(AssetManager.food3PNG);
			imgGroup.push(AssetManager.food4PNG);
			imgGroup.push(AssetManager.food5PNG);
			//loadGraphic(AssetManager.food2PNG);
			//makeGraphic(16, 16, 0xff00ff00);
		}
		
		public function spawnNewFood(X:Number, Y:Number, speed:int, recoverLevel:int):void
		{
			reset(X, Y);
			movingSpeed = speed;
			var level:int = int(FlxG.random() * recoverLevel);
			staminaAmout = 100 * (level + 1);
			loadGraphic(imgGroup[level]);
		}
	}

}