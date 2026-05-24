package enemies 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author li pinxian
	 */
	public class Chain extends FlxSprite
	{
		public var playerMidPoint:FlxPoint;
		public var ballMidPoint:FlxPoint;
		public var chainId:uint;
		public static var maxChainNumber:uint = 5;
		
		public function Chain(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(AssetManager.chainPNG);
		}
		
		public function rotateChain():void
		{
			x = playerMidPoint.x - (playerMidPoint.x - ballMidPoint.x) * (chainId / (maxChainNumber + 1)) - width / 2;
			y = playerMidPoint.y - (playerMidPoint.y - ballMidPoint.y) * (chainId / (maxChainNumber + 1)) - height / 2;
		}
		
		public function disappear():void
		{
			x = -400;
			y = -400;
		}
	}

}