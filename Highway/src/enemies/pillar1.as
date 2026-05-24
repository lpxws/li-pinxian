package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class pillar1 extends Block
	{
		
		public function pillar1(X:Number,Y:Number) 
		{
			damage = 16;
			super(X, Y);
			loadGraphic(AssetManager.pillar1PNG);
			shadow.loadGraphic(AssetManager.pillarShadowPNG);
		}
		
	}

}