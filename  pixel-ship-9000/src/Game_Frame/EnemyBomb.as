package src.Game_Frame
{
	import flash.events.Event;
	
	import src.PhysVector2D;

	public class EnemyBomb extends EnemyObject
	{
		public function EnemyBomb()
		{
			super();
			Speed = 1;
			FireRate = 1;
			fullHealth = 5;
			health = 5;
			scrapAmount = 1;
			
			Attack = fullHealth;
			_CurrentClass = EnemyBomb;
			PrimaryWeapon = new EBombSplosion();
		}
		
		public override function Update(tick:Event):void
		{
			super.Update( tick );
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):EnemyObject
		{
			var temp:EnemyObject = super.Spawn( _x, _y, _v );
			temp.rotation = 0;
			return temp;
		}
		
		protected override function DoCombatChecks():void
		{
			if( stage != null && FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				super.DoCombatChecks();
				Explode();
			}
		}
	}
}