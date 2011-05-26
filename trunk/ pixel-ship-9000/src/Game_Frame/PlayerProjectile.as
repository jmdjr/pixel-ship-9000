package src.Game_Frame
{
	import flash.events.Event;
	import flash.geom.Point;

	public class PlayerProjectile extends Projectile
	{
		protected var CollectedTargets:Array;
		
		public function PlayerProjectile()
		{
			super();
			CollectedTargets = null;
			this._CurrentClass = PlayerProjectile;
		}
		
		public override function Update(tick:Event):void
		{
			super.Update( tick );
			
			if(this.parent != null )
			{
				CollectedTargets = this.parent.getObjectsUnderPoint( new Point( this.x + this.Center.X, this.y + this.Center.Y ) );
				
				if( CollectedTargets != null && CollectedTargets.length > 0 )
				{
					CollectedTargets = CollectedTargets.filter((
						function( item:Object, index:int, array:Array )
						{
							if( item.parent is EnemyObject )
							{
								return true;
							}
							
							return false;
						}));
				}
			}
		}
	}
}