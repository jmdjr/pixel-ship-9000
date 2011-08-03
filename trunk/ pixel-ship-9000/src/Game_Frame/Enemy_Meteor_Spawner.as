package src.Game_Frame
{
	import flash.geom.Rectangle;
	
	import src.PhysVector2D;
	
	public class Enemy_Meteor_Spawner extends Enemy_
	{
		private var MeteorA:Enemy_Meteor_A = new Enemy_Meteor_A();
		private var MeteorB:Enemy_Meteor_B = new Enemy_Meteor_B();
		private var MeteorC:Enemy_Meteor_C = new Enemy_Meteor_C();
		
		public function Enemy_Meteor_Spawner()
		{
			super();
		}
		
		public override function LoadBoundary(_bound:Rectangle, _weaponBound:Rectangle=null):void
		{
			MeteorA.LoadBoundary( _bound, _weaponBound );
			MeteorB.LoadBoundary( _bound, _weaponBound );
			MeteorC.LoadBoundary( _bound, _weaponBound );
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Enemy_
		{
			var rand:Number = Math.random() * 3;
			if( rand == 0 )
			{
				return MeteorA.Spawn( _x, _y, _v );
			}
			else if( rand == 1 )
			{
				return MeteorB.Spawn( _x, _y, _v );
			}
			else
			{
				return MeteorC.Spawn( _x, _y, _v );
			}
		}
	}
}