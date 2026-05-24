package item 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class item_invince extends Item
	{
		
		public function item_invince(X:Number,Y:Number) 
		{
			super(X, Y);
			loadGraphic(AssetManager.invincePNG);
		}
		
	}

}