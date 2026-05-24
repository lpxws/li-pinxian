package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy52 extends Enemy
	{
		
		public function enemy52(X:Number,Y:Number) 
		{
			damage = 44;
			maxHP = 35;
			super(X, Y);
			loadGraphic(AssetManager.gokuPNG, true, false, 24, 24);
			addAnimation("normal", [0, 1], 3);
			play("normal");
		}
		
	}

}