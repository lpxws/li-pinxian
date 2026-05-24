package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy1 extends Enemy
	{
		
		public function enemy1(X:Number,Y:Number) 
		{
			damage = 8;
			maxHP = 10;
			super(X, Y);
			loadGraphic(AssetManager.sisterPNG, true, false, 20, 28);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}