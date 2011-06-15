package src.Game_Frame
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import src.PhysVector2D;
	
	public class EnemyJavelin extends EnemyObject
	{
		var HasFired:Boolean;
		
		public function EnemyJavelin()
		{
			super();
			_CurrentClass = EnemyJavelin;
			FireRate = 1;
			FireTimer = 1;
			fullHealth = 3;
			ResetHealth();
			HasFired = false;
			PrimaryWeapon = new Javbeam();
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):EnemyObject
		{
			var temp:EnemyObject = super.Spawn( _x, _y, _v );
			
			switch( _v )
			{
				case PhysVector2D.LEFT:
					temp.rotation = 90;
					break;
				
				case PhysVector2D.RIGHT:
					temp.rotation = -90;
					break;
				
				case PhysVector2D.UP:
					temp.rotation = 180;
					break;
				
				default:
					temp.rotation = 0;
					break;
			}
			
			return temp;
		}
		
		protected override function DoCombatChecks():void
		{
			if( !HasFired && FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				super.DoCombatChecks();
				HasFired = true;
			}
		}
	}
}