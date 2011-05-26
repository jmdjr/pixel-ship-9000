package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	import src.PhysVector2D;
	
	public class Missile extends PlayerProjectile
	{
		public function Missile() 
		{
			super();
			_CurrentClass = Missile;
			
			Speed = 10; 
			Damage = 1;
			Center = new PhysVector2D( height/2, width/2 );
			Velocity = new PhysVector2D( 0, 0 );
		}
		
		public override function Update(tick:Event):void
		{
			super.Update( tick );
			
			if( CollectedTargets != null && CollectedTargets.length > 0 )
			{
				EnemyObject( CollectedTargets[0].parent ).TakeDamage( Damage );
				Disappear();
			}
		}
	}
}