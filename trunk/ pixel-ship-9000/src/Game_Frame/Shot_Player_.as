package src.Game_Frame
{
	import flash.events.Event;
	import flash.geom.Point;

	public class Shot_Player_ extends Shot_
	{
		protected var CollectedTargets:Array;
		
		public function Shot_Player_()
		{
			super();
			CollectedTargets = null;
			_CurrentClass = Shot_Player_;
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
						function( item:Object, index:int, array:Array ):Boolean
						{
							if( item.parent is Enemy_ )
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