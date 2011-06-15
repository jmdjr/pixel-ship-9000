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
			_CurrentClass = PlayerProjectile;
		}
		
		public override function Update( tick:Event ):void
		{
			super.Update( tick );
			
			if( parent != null )
			{
				CollectedTargets = parent.getObjectsUnderPoint( new Point( x, y ) );
				
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