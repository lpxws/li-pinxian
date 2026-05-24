package item 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class item_laser extends Item
	{
		
		public function item_laser(X:Number,Y:Number) 
		{
			super(X, Y);
			loadGraphic(AssetManager.laserPNG);
		}
		
	}

}