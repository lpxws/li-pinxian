package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class cloud extends Block
	{
		
		public function cloud(X:Number,Y:Number) 
		{
			damage = 30;
			super(X, Y);
			
			loadGraphic(AssetManager.cloudPNG, true, false, 32, 32);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}