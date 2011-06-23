package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import src.Frames;
	import src.GameDataTracker;
	import src.Customize_Frame.CustomizeFrame;
	import src.Game_Frame.GameFrame;
	import src.Ship;
	import src.Title_Frame.TitleFrame;
	
	public class PixelShip9000 extends Sprite
	{
		var titleFrame:TitleFrame;
		var gameFrame:GameFrame;
		var customFrame:CustomizeFrame;
		var masterShipReference:Ship;
		var myData:GameDataTracker;
		
		public function PixelShip9000()
		{
			myData = new GameDataTracker();
			gameFrame = new GameFrame(); 
			titleFrame = new TitleFrame();
			customFrame = new CustomizeFrame();
			masterShipReference = new Ship();
			// Initialize all of the variables and load data.
			init();
		}
		
		private function init():void
		{
			gameFrame.LoadGameData( myData );
			titleFrame.LoadGameData( myData );
			customFrame.LoadGameData( myData );
			
			gameFrame.LoadShipReference( masterShipReference );
			customFrame.LoadShipReference( masterShipReference );

			addEventListener( Frames.GAME, gotoGameFrame );
			addEventListener( Frames.CUSTOM, gotoCustomizeFrame );
			addEventListener( Frames.TITLE, gotoTitleFrame ); 
			addEventListener( Event.ADDED_TO_STAGE, Start );
		}
		
		private function Start( event:Event ):void
		{
			if( this.stage != null )
			{
				this.removeEventListener(Event.ADDED_TO_STAGE, Start );
				this.gotoTitleFrame( null );
			}
		}
		 
		private function gotoTitleFrame( event:Event ):void
		{
			while( this.numChildren > 0 )
			{
				var SomeFrame:MovieClip = MovieClip( this.removeChildAt(0) );
				SomeFrame.visible = false;
				SomeFrame.enabled = false;
			}
			
			this.titleFrame.visible = true;
			this.titleFrame.enabled = true;
			
			this.addChild( this.titleFrame );
		}
		
		private function gotoGameFrame( event:Event ):void
		{
			while( this.numChildren > 0 )
			{
				var SomeFrame:MovieClip = MovieClip( this.removeChildAt(0) );
				SomeFrame.visible = false;
				SomeFrame.enabled = false;
			}
			
			this.gameFrame.visible = true;
			this.gameFrame.enabled = true;
			
			this.addChild( this.gameFrame );
		}
		
		private function gotoCustomizeFrame( event:Event ):void
		{
			while( this.numChildren > 0 )
			{
				var SomeFrame:MovieClip = MovieClip( this.removeChildAt(0) );
				SomeFrame.visible = false;
				SomeFrame.enabled = false;
			}
			
			this.customFrame.visible = true;
			this.customFrame.enabled = true;
			
			if( stage != null )
			{
				customFrame.x = stage.stageWidth / 2;
				customFrame.y = stage.stageHeight / 2;
			}
			
			this.addChild( this.customFrame );
		}
	}
}