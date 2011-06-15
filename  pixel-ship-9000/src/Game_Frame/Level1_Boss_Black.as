package src.Game_Frame
{
	public class Level1_Boss_Black extends EnemyObject
	{
		public function Level1_Boss_Black()
		{
			super();
		}
		
/*		public override function get IsDead():Boolean
		{
			if( this.parent != null )
			{
				return EnemyObject( parent ).IsDead;
			}
			
			return isDead;
		}
		
		public override function get Health():Number
		{
			var amount = health;
			if( parent != null )
			{
				amount = EnemyObject( parent ).Health;
			}
			
			return amount;
		}
		
		public override function set Health(_h:Number):void
		{
			if( parent != null )
			{
				EnemyObject( parent ).Health = _h;
			}
		}*/
	}
}