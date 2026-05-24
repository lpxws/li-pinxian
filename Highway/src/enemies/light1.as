package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class light1 extends Block
	{
		
		public function light1(X:Number,Y:Number) 
		{
			damage = 12;
			super(X, Y);
			loadGraphic(AssetManager.lightPNG, true,false, 16, 32);
			addAnimation("light", [0, 1], 5);
			play("light");
			//shadow.loadGraphic(AssetManager.lightShadowPNG);
		}
		
	}

}