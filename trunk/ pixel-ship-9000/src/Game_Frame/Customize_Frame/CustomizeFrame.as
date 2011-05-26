package src.Game_Frame.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import src.Frames;
	import src.GameDataTracker;
	
	public class CustomizeFrame extends MovieClip
	{
		var gameData:GameDataTracker;
		var background:CustomFrameBackground;
		var BTMainMenu:GOMainMenuButton;
		var BTPlayAgain:playAgainButton;
		
		public function CustomizeFrame()
		{
			super();
			background = new CustomFrameBackground();
			BTMainMenu = new GOMainMenuButton();
			BTPlayAgain = new playAgainButton();
			
			this.addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		public function init( e:Event ):void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE, init );
			
			addChild( background );
			addChild( BTMainMenu );
			addChild( BTPlayAgain );
			
			with( background )
			{
				x = stage.stageWidth - width;
				x -= x / 2; 
				y = stage.stageHeight - height;
				y -= y / 2; 
			}
			
			with( BTMainMenu )
			{
				x = stage.stageWidth - width;
				x -= x / 2; 
				y = stage.stageHeight - height;
				y -= y / 2;
				addEventListener( MouseEvent.CLICK, returnMainMenu );
			}
			with( BTPlayAgain )
			{
				x = stage.stageWidth - width;
				x -= x / 2; 
				y = stage.stageHeight - height;
				y -= y / 2;
				addEventListener( MouseEvent.CLICK, returnPlayAgain );
			}
		}
		
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
		
		public function Update( tick:Event ):void
		{
			if( enabled )
			{
				
			}
		}
		
		private function returnMainMenu( click:MouseEvent ):void
		{
			dispatchEvent( new Event( Frames.TITLE, true ) );
		}
		
		private function returnPlayAgain( click:MouseEvent ):void
		{
			dispatchEvent( new Event( Frames.GAME, true ) );
		}
	}
}