package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class buoy extends Block
	{
		
		public function buoy(X:Number,Y:Number) 
		{
			damage = 25;
			super(X, Y);
			
			loadGraphic(AssetManager.buoyPNG, true, false, 32, 32);
			addAnimation("normal", [0, 1, 1, 0, 2, 2], 3);
			play("normal");
		}
		
	}

}