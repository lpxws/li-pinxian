package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy53 extends Enemy
	{
		
		public function enemy53(X:Number,Y:Number) 
		{
			damage = 47;
			maxHP = 35;
			super(X, Y);
			loadGraphic(AssetManager.yodaPNG, true, false, 24, 24);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}