package src.Game_Frame.Summary_Frame
{
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	import src.GameDataTracker;
	
	public class SummaryFrame extends MovieClip
	{
		private var GameData:GameDataTracker;
		
		private var Background:MovieClip;
		private var LevelTitle:TextField;
		private var ScoreText:TextField;
		private var BTContinue:MovieClip;
		
		
		public function SummaryFrame()
		{
			super();
		}
	}
}