package src.Game_Frame
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import src.Credits_Frame._Frame_Credits;
	import src.PhysVector2D;
	
	public class Enemy_Boss_Hull extends Enemy_
	{
		protected var startingPos:Point;
		protected var endingPos:Point;
		protected var toStartDirection:PhysVector2D;
		protected var toEndDirection:PhysVector2D;
		
		protected var weapon_pos:int;
		protected var weapon_cycleClock:int;
		protected var weapon_list:Array;
		
		
		public function Enemy_Boss_Hull()
		{
			super();
			this._CurrentClass = Enemy_Boss_Hull;
			
			this.FullHealth = 20;
			this.ResetHealth();
			
			this.FireRate = 5;
			
			this.startingPos = new Point(250, 100);
			this.endingPos = new Point(250, 300);
			this.toStartDirection = new PhysVector2D( this.startingPos.x - this.endingPos.x, this.startingPos.y - this.endingPos.y);
			this.toEndDirection = new PhysVector2D( this.endingPos.x - this.startingPos.x, this.endingPos.y - this.startingPos.y);
			
			this.weapon_pos = 0;
			this.weapon_cycleClock = 0;
			this.weapon_list  = new Array(); 
			this.weapon_list[0] = new Shot_Enemy_Missile();
			this.weapon_list[1] = new Shot_Enemy_Beam();
			this.weapon_list[2] = new Shot_Boss_Homing();
			this.weapon_list[3] = new Shot_Enemy_Bee();
			
			this.PrimaryWeapon = this.weapon_list[this.weapon_pos];
		}
		
		protected function isAtEndPosition():Boolean
		{
			return (this.x == this.endingPos.x && this.y == this.endingPos.y);
		}
		
		protected function isAtStartPosition():Boolean
		{
			return (this.x == this.startingPos.x && this.y == this.startingPos.y);
		}
		
		protected function cycleWeapon():void
		{
			this.weapon_pos += 1;
			
			if( this.weapon_pos >= this.weapon_list.length )
			{
				this.weapon_pos = 0;
			}
			
			this.PrimaryWeapon = this.weapon_list[this.weapon_pos];
		}
		
		protected override function DoMoveChecks():void
		{
			super.DoMoveChecks();
			if( this.isAtStartPosition() )
			{
				this.Velocity = this.toEndDirection;
			}
			if( this.isAtEndPosition() )
			{
				this.Velocity = this.toStartDirection;
			}
		}
		
		protected override function DoCombatChecks():void
		{
			if( FireTimer % ( stage.frameRate / FireRate ) == 0 )
			{
				super.DoCombatChecks();
			}
			
			if( this.weapon_cycleClock % 5*stage.frameRate == 0 )
			{
				this.cycleWeapon();
			}
			
			this.weapon_cycleClock += 1;
		}
		
		public override function Spawn(_x:Number, _y:Number, _v:PhysVector2D):Enemy_
		{
			var spawn:Enemy_ = super.Spawn( this.startingPos.x, this.startingPos.y, new PhysVector2D(this.endingPos.x - this.startingPos.x, this.endingPos.y - this.startingPos.y));
			return spawn;
		}
		
		
		public override function Update(tick:Event):void
		{
			super.Update(tick);
		}
	}
}