package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy33 extends Enemy
	{
		
		public function enemy33(X:Number,Y:Number) 
		{
			damage = 27;
			maxHP = 25;
			super(X, Y);
			loadGraphic(AssetManager.surfPNG , true, false, 24, 24);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}