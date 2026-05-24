package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy21 extends Enemy
	{
		
		public function enemy21(X:Number,Y:Number) 
		{
			damage = 17;
			maxHP = 15;
			super(X, Y);
			loadGraphic(AssetManager.amazonPNG, true, false, 24, 27);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}