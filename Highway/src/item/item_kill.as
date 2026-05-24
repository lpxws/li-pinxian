package item 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class item_kill extends Item
	{
		
		public function item_kill(X:Number,Y:Number) 
		{
			super(X, Y);
			loadGraphic(AssetManager.killPNG);
		}
		
	}

}