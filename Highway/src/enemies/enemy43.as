package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy43 extends Enemy
	{
		
		public function enemy43(X:Number,Y:Number) 
		{
			damage = 40;
			maxHP = 30;
			super(X, Y);
			loadGraphic(AssetManager.doraemonPNG, true, false, 24, 24);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}