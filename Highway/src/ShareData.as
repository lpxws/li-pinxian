package  
{
	/**
	 * ...
	 * @author Li Pinxian
	 */
	public class ShareData 
	{
		static public var mouseControl:Boolean = true;
		static public var musicOn:Boolean = true;
		static public var soundOn:Boolean = true;
		static public var coinCount:int;
		static public var enemyCount:int;
		static public var bgmType:int;
		static public const BGM_TITLE:int = 0;
		static public const BGM_LEVEL:int = 1;
		static public const BGM_BOSS:int = 2;
		
		static private var scoreToCoin:int = 3;
		static private var enemyCountToCoint:int = 1;
		
		static public var hpPirces:Array = [0, 450, 2000, 5000, 10000, 180000, -1];
		static public var staminaPrices:Array = [0, 600, 2500, 6300, 13000, 24000, -1];
		static public var attackPirces:Array = [0, 550, 2250, 5550, 11550, 21000, -1];
		static public var armorPirces:Array = [0, 300, 1300, 3150, 6600, 12000, -1];
		static public var speedPirces:Array = [0, 350, 1600, 4000, 8250, 14950, -1];
		
		static public function exchangeCoin(score:int, enemyKilled:int):void
		{
			coinCount = score * scoreToCoin + enemyKilled * enemyCountToCoint;
			SaveData.coin += coinCount;
		}
	}

}