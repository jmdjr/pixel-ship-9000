package src.Title_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
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
		
		public function TitleFrame()
		{
			super();
			this.myHeight = 500;
			this.myWidth = 500;
			
			this.menuExp = menuExplosion( this.addChild( new menuExplosion() ) );
			with( this.menuExp )
			{
				x = 324/800 * this.myWidth;
				y = 330/600 * this.myHeight;
				height = scaleY * this.myHeight;
				width = scaleX * this.myWidth;
			}
			
			this.playBT = PlayButton( this.addChild( new PlayButton() ) );
			with( this.playBT )
			{
				x = 246/800 * this.myWidth;
				y = 400/600 * this.myHeight;
				height = scaleY * this.myHeight;
				width = scaleX * this.myWidth;
				addEventListener( MouseEvent.CLICK, ChangeToTitleFrame );
			}
			
			this.shootLogo = menuShootLogo( this.addChild( new menuShootLogo() ) );
			with( this.shootLogo )
			{
				x = 19/800 * this.myWidth;
				y = 263/600 * this.myHeight;
				height = scaleY * this.myHeight; 
				width = scaleX * this.myWidth;
			}
		}
		
		public function LoadGameData( data:GameDataTracker )
		{
			this.gameData = data;
		}
		
		public function Update( tick:Event ):void
		{
			if( this.enabled )
			{
				
			}
		}
		
		private function ChangeToTitleFrame( click:MouseEvent ):void
		{
			this.dispatchEvent( new Event( Frames.GAME, true ) );
		}
	}
}