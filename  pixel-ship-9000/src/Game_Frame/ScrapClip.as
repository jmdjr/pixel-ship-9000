package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import src.PhysVector2D;
	
	public class ScrapClip extends MovieClip
	{
		var direction:PhysVector2D;
		var fade:Number;
		
		public function ScrapClip()
		{
			super();
			fade = 0.02;
			alpha = 1;
			direction = new PhysVector2D();
			this.addEventListener(Event.ADDED_TO_STAGE, Loaded );
		}
		
		public function Loaded( tick:Event ):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, Loaded );
			addEventListener( Event.ENTER_FRAME, Update );
		}
		
		public function set Velocity( _v:PhysVector2D ):void
		{
			direction.Equal( _v );
			direction.Normalize();
		}
		
		public function Update( tick:Event ):void
		{
			x += direction.X;
			y += direction.Y;
			alpha -= fade;
			
			if( alpha <= 0 )
			{
				removeEventListener( Event.ENTER_FRAME, Update );
				if( parent != null )
				{
					parent.removeChild( this );
					stop();
				}
			}
		}
	}
}