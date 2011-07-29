package src.Game_Frame
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Juke_Box.JukeBox;
	
	public class Clip_Explosion extends MovieClip
	{
		private var timer:Number;
		public function Clip_Explosion()
		{
			super();
			timer = this.totalFrames;
			addEventListener( Event.ADDED_TO_STAGE, Loaded );
			addEventListener(Event.REMOVED_FROM_STAGE, Unloaded );
		}
		 
		private function Loaded( load:Event ):void
		{
			//JukeBox.PlaySE( JukeBox.EXPLODE_SE );
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
				this.enabled = false;
				this.visible = false;
				this.stop();
			}
		}
	}
}