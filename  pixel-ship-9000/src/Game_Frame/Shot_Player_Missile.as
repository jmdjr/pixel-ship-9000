package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import src.PhysVector2D;
	import Juke_Box.JukeBox;
	
	public class Shot_Player_Missile extends Shot_Player_
	{
		public function Shot_Player_Missile() 
		{
			super();
			_CurrentClass = Shot_Player_Missile;
			
			Speed = 10;
			Damage = 1;
			Center = new PhysVector2D( height/2, width/2 );
			Velocity = new PhysVector2D( 0, 0 );
		}
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
			
			if( CollectedTargets != null && CollectedTargets.length > 0 )
			{
				Enemy_( CollectedTargets[0].parent ).TakeDamage( Damage );
				Disappear();
			}
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Shot_
		{
			return super.Spawn( _x, _y, _v );
		}
	}
}