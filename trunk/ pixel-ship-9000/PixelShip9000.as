package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import src.Credits_Frame._Frame_Credits;
	import src.Customize_Frame._Frame_Customize;
	import src.Frames;
	import src.GameDataTracker;
	import src.Game_Frame._Frame_Game;
	import src.Ship;
	import src.Title_Frame._Frame_Title;
	
	public class PixelShip9000 extends Sprite
	{
		private var gameMask:GameMask;
		private var titleFrame:_Frame_Title;
		private var gameFrame:_Frame_Game;
		private var customFrame:_Frame_Customize;
		private var creditsFrame:_Frame_Credits;
		private var masterShipReference:Ship;
		private var myData:GameDataTracker;
		private var KongAPI:Kongrgate_API;
		
		public function PixelShip9000()
		{ 
			gameMask = null;
			//KongAPI = new Kongrgate_API();
			myData = new GameDataTracker();
			gameFrame = new _Frame_Game(); 
			titleFrame = new _Frame_Title();
			customFrame = new _Frame_Customize();
			creditsFrame = new _Frame_Credits();
			masterShipReference = new Ship();
			
			// Initialize all of the variables and load data.
			init();
		}
		
		private function init():void
		{
			//**********************************************
			//  Testing values for gamedata.
			//**********************************************
			myData.AddScrap( 100000 );
			
			gameFrame.LoadGameData( myData );
			titleFrame.LoadGameData( myData );
			customFrame.LoadGameData( myData );
			creditsFrame.LoadGameData( myData );
			
			addEventListener( Frames.CUSTOM, gotoCustomizeFrame );
			addEventListener( Frames.CREDITS, gotoCreditsFrame );
			customFrame.LoadShipReference( masterShipReference );
			gameFrame.LoadShipReference( masterShipReference );
			addEventListener( Frames.TITLE, gotoTitleFrame );
			addEventListener( Event.ADDED_TO_STAGE, Start );
			addEventListener( Frames.GAME, gotoGameFrame );
		}
		
		private function Start( event:Event ):void
		{
			if( this.stage != null )
			{
				this.removeEventListener(Event.ADDED_TO_STAGE, Start );
				
				//addChild( KongAPI );
				
				this.gotoTitleFrame( null );
				//this.gotoGameFrame( null );
				//this.gotoCustomizeFrame( null );
				//this.gotoCreditsFrame( null );
			}
		}
		
		private function enableFrame( frame:MovieClip ):void
		{
			while( this.numChildren > 0 )
			{
				var SomeFrame:MovieClip = MovieClip( removeChildAt(0) );
				SomeFrame.visible = false;
				SomeFrame.enabled = false;
			}
			
			frame.visible = true;
			frame.enabled = true;
			
			addChild( frame );
			
			if( gameMask != null )
			{
				gameMask.visible = true;
				gameMask.enabled = true;
				addChild( gameMask );
				mask = gameMask;
			}
		}
		 
		private function gotoTitleFrame( event:Event ):void
		{
			enableFrame( titleFrame );
		}
		
		private function gotoGameFrame( event:Event ):void
		{
			enableFrame( gameFrame );
		}
		
		private function gotoCustomizeFrame( event:Event ):void
		{
			if( stage != null )
			{
				customFrame.x = stage.stageWidth / 2;
				customFrame.y = stage.stageHeight / 2;
			}
			
			enableFrame( customFrame );
		}
		
		private function gotoCreditsFrame( event:Event ):void
		{
			
			enableFrame( creditsFrame );
		}
	}
}