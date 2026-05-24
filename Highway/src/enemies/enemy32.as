package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy32 extends Enemy
	{
		
		public function enemy32(X:Number,Y:Number) 
		{
			damage = 24;
			maxHP = 25;
			super(X, Y);
			loadGraphic(AssetManager.mermaiPNG, true, false, 24, 24);
			addAnimation("normal", [0, 1], 2);
			play("normal");
		}
		
	}

}