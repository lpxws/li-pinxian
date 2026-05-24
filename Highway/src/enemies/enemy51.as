package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemy51 extends Enemy
	{
		
		public function enemy51(X:Number,Y:Number) 
		{
			damage = 44;
			maxHP = 33;
			super(X, Y);
			
			loadGraphic(AssetManager.astronautPNG);
		}
		
	}

}