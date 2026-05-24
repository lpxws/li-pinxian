package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class TileBackground extends FlxGroup
	{
		private var tile1:FlxTilemap;
		private var tile2:FlxTilemap;
		private var changeTile1:Boolean = false;
		private var changeTile2:Boolean = false;
		
		private var mapData:String;
		private var tileGraphic:Class; 
		private var tileWidth:uint;
		private var tileHeight:uint;
		
		public function TileBackground() 
		{
			super();
			tile1 = new FlxTilemap(0, 0);
			tile2 = new FlxTilemap(0, 0);
			add(tile1);
			add(tile2);
		}
		
		override public function update():void
		{
			super.update();
			
			if (tile1.y > FlxG.height)
			{
				tile1.y = tile2.y - tile1.height;
				if (changeTile1)
				{
					tile1.loadMap(mapData, tileGraphic, tileWidth, tileHeight);
					changeTile1 = false;
				}
			}
			if (tile2.y > FlxG.height)
			{
				tile2.y = tile1.y - tile2.height;
				if (changeTile2)
				{
					tile2.loadMap(mapData, tileGraphic, tileWidth, tileHeight);
					changeTile2 = false;
				}
			}
		}
		
		public function loadMap(MapData:String, TileGraphic:Class, TileWidth:uint = 0, TileHeight:uint = 0, AutoTile:uint = FlxTilemap.OFF, StartingIndex:uint = 0, DrawIndex:uint = 1, CollideIndex:uint = 1):void
		{
			tile1.loadMap(MapData, TileGraphic,TileWidth,TileHeight,AutoTile,StartingIndex,DrawIndex,CollideIndex);
			tile2.loadMap(MapData, TileGraphic,TileWidth,TileHeight,AutoTile,StartingIndex,DrawIndex,CollideIndex);
			tile2.y = tile1.y - tile2.height;
		}
		
		public function scrollMap(speed:int):void
		{
			tile1.velocity.y = speed;
			tile2.velocity.y = speed;
		}
		
		public function changeTile(MapData:Class,  TileGraphic:Class, TileWidth:uint = 0, TileHeight:uint = 0, AutoTile:uint = FlxTilemap.OFF, StartingIndex:uint = 0, DrawIndex:uint = 1, CollideIndex:uint = 1):void
		{
			changeTile1 = true;;
			changeTile2 = true;
			
			mapData = new MapData;
			tileGraphic = TileGraphic;
			tileWidth = TileWidth;
			tileHeight = TileHeight;
		}
	}

}