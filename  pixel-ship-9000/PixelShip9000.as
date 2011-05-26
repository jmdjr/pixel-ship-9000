package
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import src.Game_Frame.Customize_Frame.CustomizeFrame;
	import src.GameDataTracker;
	import src.Game_Frame.GameFrame;
	import src.Title_Frame.TitleFrame;
	import src.Frames;
	
	public class PixelShip9000 extends Sprite
	{
		var titleFrame:TitleFrame;
		var gameFrame:GameFrame;
		var customFrame:CustomizeFrame;
		
		var myData:GameDataTracker;
		
		public function PixelShip9000()
		{
			myData = new GameDataTracker();
			gameFrame = new GameFrame(); 
			titleFrame = new TitleFrame();
			customFrame = new CustomizeFrame();
			
			// Initialize all of the variables and load data.
			init();
		}
		
		private function init():void
		{
			gameFrame.LoadGameData( myData );
			titleFrame.LoadGameData( myData );
			customFrame.LoadGameData( myData ); 
			
			addEventListener( Frames.GAME, gotoGameFrame );
			addEventListener( Frames.CUSTOM, gotoGameOverFrame );
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
		
		private function gotoGameOverFrame( event:Event ):void
		{
			while( this.numChildren > 0 )
			{
				var SomeFrame:MovieClip = MovieClip( this.removeChildAt(0) );
				SomeFrame.visible = false;
				SomeFrame.enabled = false;
			}
			
			this.customFrame.visible = true;
			this.customFrame.enabled = true;
			
			this.addChild( this.customFrame );
		}
	}
}