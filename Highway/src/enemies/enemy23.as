package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy23 extends Enemy
	{
		
		public function enemy23(X:Number,Y:Number) 
		{
			damage = 21;
			maxHP = 20;
			super(X, Y);
			loadGraphic(AssetManager.elfPNG, true, false, 24, 27);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}