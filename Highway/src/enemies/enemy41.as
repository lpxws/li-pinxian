package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy41 extends Enemy
	{
		
		public function enemy41(X:Number,Y:Number) 
		{
			damage = 33;
			maxHP = 28;
			super(X, Y);
			
			loadGraphic(AssetManager.supermanPNG, true, false, 24, 24);
			addAnimation("normal", [0, 1], 3);
			play("normal");
		}
		
	}

}