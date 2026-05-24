package enemies 
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class enemyChallenge extends Enemy
	{
		private var graphicArray:Array;
		public function enemyChallenge(X:Number,Y:Number) 
		{
			damage = 50;
			maxHP = 40;
			super(X, Y);
			graphicArray = new Array();
			graphicArray = [AssetManager.bossBullet1PNG, AssetManager.bossBullet2PNG, AssetManager.bossBullet3PNG, AssetManager.bossBullet4PNG];
		}
		
		override public function reset(X:Number, Y:Number):void
		{
			super.reset(X, Y);
			loadGraphic(graphicArray[int(Math.random() * graphicArray.length)]);
		}
		
	}

}