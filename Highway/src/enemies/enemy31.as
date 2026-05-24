package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy31 extends Enemy
	{
		
		public function enemy31(X:Number,Y:Number) 
		{
			damage = 24;
			maxHP = 23;
			super(X, Y);
			loadGraphic(AssetManager.piratePNG, true, false, 24, 24);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}