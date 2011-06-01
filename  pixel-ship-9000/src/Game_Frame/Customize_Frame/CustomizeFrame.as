package src.Game_Frame.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import src.Frames;
	import src.GameDataTracker;
	import src.Ship;
	
	public class CustomizeFrame extends MovieClip
	{
		public static var RESTART_ONLY:String = "RestartOnly";
		public static var RESTART_CONTINUE:String = "RestartAndContinue";
		
		var gameData:GameDataTracker;
		
		var background:CustomFrameBackground;
		var BTMainMenu:GOMainMenuButton;
		var BTPlayAgain:playAgainButton;
		var BTContinue:MovieClip;
		var MGC:ModGridCustomizer;
		var GameOverTest:Boolean;
		
		var BuyRED:ModPixel;
		var BuySPEED:ModPixel;
		var BuyDEF:ModPixel;
		
		var ShipReference:Ship;
		
		public function CustomizeFrame()
		{
			super();
			background = new CustomFrameBackground();
			BTMainMenu = new GOMainMenuButton();
			BTPlayAgain = new playAgainButton();
			
			
			this.addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function ContinueOrRestart( e:Event ):void
		{ 
			if( e.type == RESTART_ONLY )
			{
				GameOverTest = true;
			}
			else if ( e.type == RESTART_CONTINUE )
			{
				GameOverTest = false;	
			}
		}
		
		public function LoadShipReference( sr:Ship ):void
		{
			this.ShipReference = sr;
		}
		
		public function init( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			ResetFrame();
			addEventListener( Event.ENTER_FRAME, Update );
		}
		
		public function ResetFrame():void
		{
			var CenteringX = 0;
			var CenteringY = 0;
			
			if( stage != null )
			{
				CenteringX = stage.stageWidth;
				CenteringY = stage.stageHeight;
			}
			else
			{
				CenteringX = background.width;
				CenteringY = background.height;
			}
				
			if( !contains( background ))
			{
				addChild( background );
				with( background )
				{
					x = CenteringX/2;
					y = CenteringY/2;
				}
			}
			
			if( !contains( BTMainMenu ))
			{
				addChild( BTMainMenu );
				with( BTMainMenu )
				{
					x = background.x - 159.10; 
					y = background.y + 194.70;
					addEventListener( MouseEvent.CLICK, returnMainMenu );
				}
			}
			
			if( GameOverTest )
			{
				if( !contains( BTPlayAgain ))
				{
					addChild( BTPlayAgain );
					with( BTPlayAgain )
					{
						x = BTMainMenu.x - width - 20;
						y = BTMainMenu.y;
						addEventListener( MouseEvent.CLICK, returnPlayAgain ); 
					}
				}
				
				if( !contains( ShipReference ) )
				{
					addChild( ShipReference );
					ShipReference.x = width/2;
					ShipReference.y = height/2;
				}
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
				ResetFrame();
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