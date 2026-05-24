package item 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class item_potion extends Item
	{
		public var recoveryAmout:int = 20;
		
		public function item_potion(X:Number,Y:Number) 
		{
			super(X, Y);
			loadGraphic(AssetManager.potionPNG);
		}
		
	}

}