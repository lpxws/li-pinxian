package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class asteroid extends Block
	{
		
		public function asteroid(X:Number,Y:Number) 
		{
			damage = 35;
			super(X, Y);
			
			loadGraphic(AssetManager.asteroidPNG, true, false, 32, 32);
		}
		
	}

}