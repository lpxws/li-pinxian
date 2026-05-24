package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class well extends Block
	{
		
		public function well(X:Number,Y:Number) 
		{
			damage = 20;
			super(X, Y);
			
			loadGraphic(AssetManager.wellPNG);
			shadow.loadGraphic(AssetManager.wellShadowPNG);
			//makeGraphic(32, 32, 0xffff00ff);
		}
		
	}

}