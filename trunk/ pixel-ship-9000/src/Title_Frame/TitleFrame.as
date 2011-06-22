package src.Title_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import src.Background;
	import src.Frames;
	import src.GameDataTracker;
	
	public class TitleFrame extends MovieClip
	{
		var myHeight:Number;
		var myWidth:Number;
		
		var gameData:GameDataTracker;
		var menuExp:menuExplosion;
		var playBT:PlayButton;
		var shootLogo:menuShootLogo;
		var background:Background;
		
		public function TitleFrame()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, Loaded );
		}
		
		public function Loaded( tick:Event )
		{
			menuExp = new menuExplosion();
			playBT = new PlayButton();
			shootLogo = new menuShootLogo();
			background = new Background();
			ResetFrame();
			addEventListener( Event.ENTER_FRAME, Update );
		}
		
		public function ResetFrame()
		{
			with( this.menuExp )
			{
				x = 324/800 * this.stage.stageWidth;
				y = 330/600 * this.stage.stageHeight;
			}
			
			with( playBT )
			{
				x = 246/800 * this.stage.stageWidth;
				y = 400/600 * this.stage.stageHeight;
				addEventListener( MouseEvent.CLICK, ChangeToTitleFrame );
			}
			
			with( shootLogo )
			{
				x = 0.5 * this.stage.stageWidth;
				y = 0.5 * this.stage.stageHeight;
			}
			
			with( background )
			{
				width = this.stage.stageWidth;
				startY = this.stage.stageHeight;
				x = width / 2;
				y = startY; 
				scrollRate = 10;
			}
			
			if( !contains( background ) )
			{
				addChild( background );
			}
			
			if( !contains( menuExp ) )
			{
				addChild( menuExp );
			}
			
			if( !contains( playBT ) )
			{
				addChild( playBT );
			}
			
			if( !contains( shootLogo ) )
			{
				addChild( shootLogo );
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
				background.Update( tick );
			}
		}
		
		private function ChangeToTitleFrame( click:MouseEvent ):void
		{
			this.dispatchEvent( new Event( Frames.GAME, true ) );
		}
		
		private function ChangeToCustomFrame( click:MouseEvent ):void
		{
			this.dispatchEvent( new Event( Frames.CUSTOM, true ) );
		}
	}
}