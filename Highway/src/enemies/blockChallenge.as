package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class blockChallenge extends Block
	{
		private var graphicArray:Array;
		
		public function blockChallenge(X:Number,Y:Number) 
		{
			damage = 60;
			
			super(X, Y);
			graphicArray = new Array()
			graphicArray = [AssetManager.asteroidPNG, AssetManager.buoyCPNG, AssetManager.wellCPNG, AssetManager.rockPNG];
		}
		
		override public function reset(X:Number, Y:Number):void
		{
			super.reset(X, Y);
			loadGraphic(graphicArray[int(Math.random() * graphicArray.length)]);
		}
		
	}

}