package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class satellite extends Block
	{
		
		public function satellite(X:Number,Y:Number) 
		{
			damage = 30;
			super(X, Y);
			
			loadGraphic(AssetManager.setellitePNG, true, false, 32, 32);
		}
		
	}

}