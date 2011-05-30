package src.Game_Frame
{
	import explode2.wav;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Explosion extends MovieClip
	{
		var timer:Number;
		public function Explosion()
		{
			super();
			timer = this.totalFrames;
			addEventListener( Event.ADDED_TO_STAGE, Loaded );
			addEventListener(Event.REMOVED_FROM_STAGE, Unloaded );
		}
		 
		private function Loaded( load:Event ):void
		{
			var tempSound:explode2.wav = new wav();
			tempSound.play(0, 0);
			addEventListener(Event.ENTER_FRAME, Update );
		}
		
		private function Unloaded( uload:Event ):void
		{
			removeEventListener( Event.ENTER_FRAME, Update );
		}
		
		private function Update( tick:Event ):void
		{
			--timer;
			
			if( timer <= 0 )
			{
				removeEventListener(Event.ENTER_FRAME, Update );
				parent.removeChild( this );
			}
		}
	}
}