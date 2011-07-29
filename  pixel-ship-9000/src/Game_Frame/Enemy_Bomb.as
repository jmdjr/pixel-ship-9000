package src.Game_Frame
{
	import Juke_Box.JukeBox;
	import flash.events.Event;
	import src.PhysVector2D;

	public class Enemy_Bomb extends Enemy_
	{
		public function Enemy_Bomb()
		{
			super();
			Speed = 1;
			FireRate = 1;
			FullHealth = 2;
			scrapAmount = 1;
			ResetHealth();
			Attack = FullHealth;
			_CurrentClass = Enemy_Bomb;
			PrimaryWeapon = new Shot_Enemy_Explosion();
		}
		
		public override function Update(tick:Event):void
		{
			super.Update( tick );
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Enemy_
		{
			var temp:Enemy_ = super.Spawn( _x, _y, _v );
			temp.rotation = 0;
			return temp;
		}
		
		protected override function DoCombatChecks():void
		{
			if( stage != null && FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				JukeBox.PlaySE( JukeBox.EXPLODE_SE );
				super.DoCombatChecks();
				Explode();
			}
		}
	}
}