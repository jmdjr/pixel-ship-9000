package src
{
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	
	import src.Game_Frame.Level;

	public class GameDataTracker
	{
		private var ShotsFired:Number;
		private var EnemiesKilled:Number;
		private var Accuracy:Number;
		private var Score:Number;
		private var CurrentScrap:Number;
		private var TotalScrap:Number;
		public var JB:JukeBox;
		private var CurrentLevel:Level;
		
		public function GameDataTracker()
		{
			ShotsFired = 0; 
			EnemiesKilled = 0;
			Score = 0;
			CurrentScrap = 0;
			TotalScrap = 0;
			Accuracy = 1.0;
			CurrentLevel = null;
			JB = new JukeBox();
		}
		
		public function FireShot():void
		{
			++ShotsFired;
		}
		
		public function EnemyKill():void
		{
			++EnemiesKilled;
		}
		
		public function UpdateLevel( _l:Level ):void
		{
			CurrentLevel = _l;
		}
		
		public function AddScrap( _s:Number ):void
		{
			CurrentScrap += _s;
		}
		
		public function SpendScrap( _s:Number ):Boolean
		{
			if( _s > CurrentScrap )
			{
				return false;
			}
			
			CurrentScrap -= _s;
			return true;
		}
		
		public function CalcScore():void
		{
			Accuracy = (EnemiesKilled/ShotsFired);
		}
		
		public function get Scrap():Number
		{
			return CurrentScrap;
		}
		
		public function get Kills():Number
		{
			return EnemiesKilled;
		}
		
		public function get LevelName():String
		{
			if( this.CurrentLevel != null )
			{
				return this.CurrentLevel.LevelTitle;
			}
			
			return "Blank Level Name";
		}

	}
}