package item 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class item_shotgun extends Item
	{
		
		public function item_shotgun(X:Number,Y:Number) 
		{
			super(X, Y);
			loadGraphic(AssetManager.shotgunPNG);
		}
		
	}

}