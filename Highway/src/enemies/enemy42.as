package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy42 extends Enemy
	{
		
		public function enemy42(X:Number,Y:Number) 
		{
			damage = 33;
			maxHP = 30;
			super(X, Y);
			
			loadGraphic(AssetManager.angelPNG, true, false, 24, 24);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}