package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class submarine extends Block
	{
		
		public function submarine(X:Number,Y:Number) 
		{
			damage = 25;
			super(X, Y);
			
			loadGraphic(AssetManager.subPNG, true, false, 32, 32);
			addAnimation("normal", [0, 0, 2, 1, 1, 2], 4);
			play("normal");
		}
		
	}

}