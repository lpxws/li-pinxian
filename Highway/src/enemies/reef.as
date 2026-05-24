package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class reef extends Block
	{
		
		public function reef(X:Number,Y:Number) 
		{
			damage = 25;
			super(X, Y);
			
			loadGraphic(AssetManager.reefPNG, true, false, 32, 32);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}