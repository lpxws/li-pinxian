package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy12 extends Enemy
	{
		
		public function enemy12(X:Number,Y:Number) 
		{
			damage = 14;
			maxHP = 15;
			super(X, Y);
			loadGraphic(AssetManager.priestPNG, true, false, 24, 27);
			addAnimation("normal", [0, 1], 3);
			play("normal");
		}
		
	}

}