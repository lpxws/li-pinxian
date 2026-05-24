package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class plane extends Block
	{
		
		public function plane(X:Number,Y:Number) 
		{
			damage = 25;
			super(X, Y);
			
			loadGraphic(AssetManager.planePNG, true, false, 32, 32);
			addAnimation("normal", [1, 0, 0, 2, 0, 0], 4);
			play("normal");
		}
		
	}

}