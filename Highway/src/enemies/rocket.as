package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class rocket extends Block
	{
		
		public function rocket(X:Number,Y:Number) 
		{
			damage = 25;
			super(X, Y);
			
			loadGraphic(AssetManager.rocketPNG, true, false, 32, 32);
			addAnimation("normal", [0, 1], 10);
			play("normal");
		}
		
	}

}