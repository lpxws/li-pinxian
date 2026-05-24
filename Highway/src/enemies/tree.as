package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class tree extends Block
	{
		
		public function tree(X:Number,Y:Number) 
		{
			damage = 25;
			super(X, Y);
			
			loadGraphic(AssetManager.treePNG);
			shadow.loadGraphic(AssetManager.treeShadowPNG);
		}
		
	}

}