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
		var DidShipDie:Boolean;
		var ShipReference:Ship;
		
		var BTMainMenu:GOMainMenuButton;
		var BTPlayAgain:playAgainButton;
		var BTContinue:ContinueButton;
		
		var sum_attackText:Sum_AttackText;
		var sum_defenseText:Sum_DefenseText;
		var sum_speedText:Sum_SpeedText;
		
		var MGC:ModGridCustomizer;
		
		var BuyRED:ModPixel;
		var BuySPEED:ModPixel;
		var BuyDEF:ModPixel;
		
		
		
		public function CustomizeFrame()
		{
			super();
			BTMainMenu = null;
			BTPlayAgain = null;			
			DidShipDie = false;
			
			
			this.addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function ContinueOrRestart( e:Event ):void
		{ 
			if( e.type == RESTART_ONLY )
			{
				DidShipDie = true;
			}
			else if ( e.type == RESTART_CONTINUE )
			{
				DidShipDie = false;	
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
			this.addEventListener(Event.ADDED_TO_STAGE, Update );
		}
		
		public function ResetFrame():void
		{
			var child:int = 0;
			while( child < numChildren )
			{
				var testObject = getChildAt( child );
				
				if( testObject is playAgainButton )
				{
					this.BTPlayAgain = playAgainButton( testObject );
				}
				else 
					if( testObject is ModGridCustomizer )
				{
					this.MGC = ModGridCustomizer( testObject );
				}
				else 
					if( testObject is ContinueButton )
				{
					this.BTContinue = ContinueButton( testObject );
				}
				else
					if( testObject is ModPixel )
					{
						this.BuyRED = testObject;
					}
				else
					
					if( testObject is TextObject )
				{
					assignTextObjects( TextObject( testObject ) );
				}
				
				++child; 
			}
		}
		
		private function assignTextObjects( object:TextObject ):void
		{
			switch( object )
			{
				case TextObject:
					break;
			}
		}
		
		public function LoadGameData( data:GameDataTracker )
		{
			gameData = data;
		}
		
		public function Update( tick:Event ):void
		{
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