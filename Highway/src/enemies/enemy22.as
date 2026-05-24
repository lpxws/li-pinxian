package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy22 extends Enemy
	{
		
		public function enemy22(X:Number,Y:Number) 
		{
			damage = 17;
			maxHP = 20;
			super(X, Y);
			loadGraphic(AssetManager.titanPNG, true, false, 24, 27);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}