package  
{
	import org.flixel.FlxSave;
	/**
	 * ...
	 * @author li pinxian
	 */
	public class SaveData 
	{
		static public var gameSave:FlxSave;
		static public var saved:Boolean;
		static public var challengeOn:Boolean;
		static public var isCleared:Boolean;
		
		static public var bestScore:int;
		static public var hpLevel:int;
		static public var staminaLevel:int;
		static public var speedLevel:int;
		static public var attackLevel:int;
		static public var armorLevel:int;
		static public var coin:int;
		static public var level:int;
		static public var exp:int;
		static public var maxExp:int;
		static public var skillPoint:int;
		
		static public function onLoad():Boolean
		{
			gameSave = new FlxSave();
			gameSave.bind("HighwaySave");
			
			var loaded:Boolean = gameSave.bind("HighwaySave");
			if (loaded && gameSave.data.saved == null)
			{
				init();
				return false;
			}else {
				bestScore = gameSave.data.bestScore;
				saved = gameSave.data.saved;
				challengeOn = gameSave.data.challengeOn;
				isCleared = gameSave.data.isCleared;
				hpLevel = gameSave.data.hpLevel;
				staminaLevel = gameSave.data.staminaLevel;
				speedLevel = gameSave.data.speedLevel;
				attackLevel = gameSave.data.attackLevel;
				armorLevel = gameSave.data.armorLevel;
				level = gameSave.data.level;
				exp = gameSave.data.exp;
				maxExp = 4 * (Math.pow(level + 1, 2)) + 10;
				skillPoint = gameSave.data.skillPoint;
				coin = gameSave.data.coin;
				return true;
			}
		}
		
		static public function init():void
		{
			bestScore = 0;
			saved = false;
			challengeOn = false;
			isCleared = false;
			hpLevel = 0;
			staminaLevel = 0;
			speedLevel = 0;
			attackLevel = 0;
			armorLevel = 0;
			level = 0;
			exp = 0;
			maxExp = 4 * (Math.pow(level + 1, 2)) + 10;
			skillPoint = 0;
			coin = 0;
			//onSave();
		}
		
		static public function onSave():void
		{
			saved = true;
			gameSave.data.bestScore = bestScore;
			gameSave.data.saved = saved;
			gameSave.data.challengeOn = challengeOn;
			gameSave.data.isCleared = isCleared;
			gameSave.data.hpLevel = hpLevel;
			gameSave.data.staminaLevel = staminaLevel;
			gameSave.data.speedLevel = speedLevel;
			gameSave.data.attackLevel = attackLevel;
			gameSave.data.armorLevel = armorLevel;
			gameSave.data.level = level;
			gameSave.data.exp = exp;
			gameSave.data.skillPoint = skillPoint;
			gameSave.data.coin = coin;
		}
		
		static public function erase():void
		{
			gameSave.erase();
			init();
		}
	}

}