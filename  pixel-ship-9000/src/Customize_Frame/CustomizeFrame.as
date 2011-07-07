package src.Customize_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;
	
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
		
		var price_defensePixel:Price_DefensePixel;
		var price_speedPixel:Price_SpeedPixel;
		var price_attackPixel:Price_AttackPixel;
		
		var ship_scrapTotalText:Ship_ScrapTotalText;
		var MGC:ModGridCustomizer;
		
		var BuyATK:AttackModSpawner;
		var BuySPEED:SpeedModSpawner;
		var BuyDEF:DefenseModSpawner;
		
		public function CustomizeFrame()
		{
			super();
			BTMainMenu = null;
			BTPlayAgain = null;			
			DidShipDie = true;
			
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
			LoadFrame();
			this.addEventListener(Event.ADDED_TO_STAGE, Update );
		}
		
		public function LoadFrame():void
		{
			for(var child:int = 0; child < numChildren; ++child )
			{
				var childClip = getChildAt( child );
				
				switch( getQualifiedSuperclassName( childClip ) )
				{
					case getQualifiedClassName( GenericButtonObject ):
						assignButtons( GenericButtonObject( childClip ) );
						break;
					
					case getQualifiedClassName( TextObject ):
						assignTextObjects( TextObject( childClip ) );
						break;
					
					case getQualifiedClassName( MovieClip ):
						assignRest( childClip );
						break;
				}
			}
		}
		
		private function assignRest( childClip:MovieClip ):void
		{
			switch( getQualifiedClassName( childClip ) )
			{
				case getQualifiedClassName( ModGridCustomizer ):
					MGC = ModGridCustomizer( childClip );
					break;
			}
		}
		
		private function assignButtons( childClip:GenericButtonObject ):void
		{
			switch( getQualifiedClassName( childClip ) )
			{
				case getQualifiedClassName( playAgainButton ):
					BTPlayAgain = playAgainButton( childClip );
					BTPlayAgain.addEventListener(MouseEvent.CLICK, returnPlayAgain );
					break;
				
				case getQualifiedClassName( ContinueButton ):
					BTContinue = ContinueButton( childClip );
					BTContinue.addEventListener( MouseEvent.CLICK, returnMainMenu );
					break;
				
				case getQualifiedClassName( GOMainMenuButton ):
					BTMainMenu = GOMainMenuButton( childClip );
					BTMainMenu.addEventListener( MouseEvent.CLICK, returnMainMenu ); 
					break;
			}
		}
		
		private function assignTextObjects( childClip:TextObject ):void
		{
			switch( getQualifiedClassName( childClip ) )
			{
				case getQualifiedClassName( Sum_AttackText ):
					sum_attackText = Sum_AttackText( childClip );
					break;
				
				case getQualifiedClassName( Sum_DefenseText ):
					sum_defenseText = Sum_DefenseText( childClip );
					break;
				
				case getQualifiedClassName( Sum_SpeedText ):
					sum_speedText = Sum_SpeedText( childClip );
					break;
				
				case getQualifiedClassName( Price_AttackPixel ):
					price_attackPixel = Price_AttackPixel( childClip );
					break;
				
				case getQualifiedClassName( Price_SpeedPixel ):
					price_speedPixel = Price_SpeedPixel( childClip );
					break;
				
				case getQualifiedClassName( Price_DefensePixel ):
					price_defensePixel = Price_DefensePixel( childClip );
					break;
				
				case getQualifiedClassName( Ship_ScrapTotalText ):
					ship_scrapTotalText = Ship_ScrapTotalText( childClip );
					break;
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
		
		private function OnClick_AttackModSpawner( click:MouseEvent ):void
		{
			
		}
		
		private function OnClick_DefenseModSpawner( click:MouseEvent ):void
		{
		}
		
		private function OnClick_SpeedModSpawner( click:MouseEvent ):void
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