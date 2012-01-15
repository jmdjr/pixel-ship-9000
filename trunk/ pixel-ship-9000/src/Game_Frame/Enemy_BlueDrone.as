package src.Game_Frame
{
	import Juke_Box.JukeBox;
	import org.flixel.*;
	import src.PhysVector2D;

	public class Enemy_BlueDrone extends Enemy_
	{
		public function Enemy_BlueDrone()
		{
			super();
			FireRate = 1;
			FullHealth = 1;
			scrapAmount = 1;
			ResetHealth();
			PrimaryWeapon = new Shot_Enemy_Missile();
			PrimaryWeapon.ProjectileDamage = 1;
			_CurrentClass = Enemy_BlueDrone;
		}
			
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D ):Enemy_
		{
			var temp:Enemy_ = super.Spawn( _x, _y, _v );
			temp.rotation = 0;
			return temp;
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				var tempX:Number;
				var tempY:Number;
				var startX:Number;
				var startY:Number;
				var tempPoint:FlxPoint;
				
				tempX = FireDirection.X;
				tempY = -1 * FireDirection.Y;
				
				startX = tempX;
				startY = tempY;
				
				tempPoint = FlxU.rotatePoint(tempX, tempY, 0, 0, -15);
				
				FireDirection.X = tempPoint.x;
				FireDirection.Y = tempPoint.y;

				super.DoCombatChecks();
				
				tempX = startX;
				tempY = startY;
				
				tempPoint = FlxU.rotatePoint(tempX, tempY, 0, 0, 15);
				
				FireDirection.X = tempPoint.x;
				FireDirection.Y = tempPoint.y;

				super.DoCombatChecks();
				
				JukeBox.PlaySE( JukeBox.ATTACK1_SE );
				
				FireDirection.X = startX;
				FireDirection.Y = -1 * startY;
			}
		}
	}
}