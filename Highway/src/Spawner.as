package  
{
	import flash.display.Sprite;
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxBar;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class Spawner extends FlxGroup
	{
		public var onSpawn:Boolean = false;
		public var enemyGroup:FlxGroup;
		public var hpBarGroup:FlxGroup;
		public var blockGroup:FlxGroup;
		public var shadowGroup:FlxGroup;
		protected var heightInPattern:uint;
		protected var widthInPattern:uint;
		protected var patternGroup:Array;
		
		public var scrollSpeed:int;
		private var basicUnit:int;
		private var patternSpacing:int;
		private var attackAmout:int;
		private var spawnInterval:Number;
		
		public function Spawner() 
		{
			onSpawn = false;
			enemyGroup = new FlxGroup();
			hpBarGroup = new FlxGroup();
			blockGroup = new FlxGroup();
			shadowGroup = new FlxGroup();
			patternGroup = new Array();
			/*
			add(enemyGroup);
			add(hpBarGroup);
			add(blockGroup);
			*/
		}
		
		override public function update():void
		{
			super.update();
			
			if (spawnInterval > 0)
			{
				spawnInterval -= FlxG.elapsed;
			}else if (spawnInterval <= 0 && onSpawn)
			{
				spawn(scrollSpeed, basicUnit, attackAmout, patternSpacing);	
			}
		}
		
		public function startSpawn(speed:int, unit:int, playerAttack:int, spacing:int):void
		{
			onSpawn = true;
			scrollSpeed = speed;
			basicUnit = unit;
			attackAmout = playerAttack;
			patternSpacing = spacing;
			spawn(scrollSpeed, basicUnit, attackAmout, patternSpacing);
		}
		
		public function stopSpawn():void
		{
			onSpawn = false;
		}
		
		public function spawn(speed:int, unit:int, playerAttack:int, spacing:int):void
		{
			var CSV:String = patternGroup[int(Math.random() * patternGroup.length)];
			var columns:Array;
			var rows:Array = CSV.split("\n");
			heightInPattern = rows.length;
			
			var tempColumn:Array = rows[i].split(",");
			var heightIndex:Number = -heightInPattern * unit;
			var widthIndex:Number = 6 + FlxG.random() * ((FlxG.width - 12) - (tempColumn.length * unit));
			
			for (var i:int = 0; i < heightInPattern; i++)
			{
				
				columns = rows[i].split(",");
				widthInPattern = columns.length;
				for (var j:int = 0; j < widthInPattern; j++)
				{
					if (columns[j] == "1")
					{
						var tempEnemy:GameSprite = enemyGroup.recycle() as GameSprite;
						tempEnemy.reset(widthIndex + j * unit, heightIndex + i * unit);
						tempEnemy.movingSpeed = speed;
						
						if (playerAttack < tempEnemy.maxHP)
						{
							var tempBar:FlxBar = hpBarGroup.recycle() as FlxBar;
							tempBar.reset( -100, -100);
							tempBar.setParent(tempEnemy, "currentHP", true, 0, -6);
						}
					}else if (columns[j] == 2)
					{
						var tempBlock:Block = blockGroup.recycle() as Block;
						tempBlock.reset(widthIndex + j * unit, heightIndex + i * unit);
						tempBlock.movingSpeed = speed;
						//tempBlock.shadow.velocity.y = speed;
					}
				}
			}
			
			spawnInterval = (heightInPattern * unit + spacing) / speed;
		}
	}
	

}