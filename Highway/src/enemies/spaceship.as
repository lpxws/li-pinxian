package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class spaceship extends Block
	{
		
		public function spaceship(X:Number,Y:Number) 
		{
			damage = 30;
			super(X, Y);
			
			loadGraphic(AssetManager.spaceshipPNG, true, false, 32, 32);
		}
		
	}

}