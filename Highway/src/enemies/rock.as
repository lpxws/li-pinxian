package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class rock extends Block
	{
		
		public function rock(X:Number,Y:Number) 
		{
			damage = 20;
			super(X, Y);
			
			loadGraphic(AssetManager.rockPNG);
			shadow.loadGraphic(AssetManager.rockShadowPNG);
		}
		
	}

}