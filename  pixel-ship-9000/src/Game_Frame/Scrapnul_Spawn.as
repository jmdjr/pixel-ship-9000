package src.Game_Frame
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	
	import src.PhysVector2D;

	// this class is invoked when an enemy ship explodes, specifically for spawning a specific amount of shrapnul
	// for display.  uses ScrapClip objects to do so.
	public class Scrapnul_Spawn
	{
		public function Scrapnul_Spawn()
		{
		}
		
		/**This will spawn a number of scrapnulbits at a specific location, giving each one a random
		 * direction to move. this function spawns the scraps to be the children of a different movieclip
		 * since the movieclip at which they spawn will most likely be gone.
		 * @param toSpawnAt The movieclip where the scrapnul will spawn.
		 * @param toSpawnOn The movieclip where the scrapnul will be added.
		 * @param amountToSpawn The given amount of scrapnul that will be spawned.
		 * */
		public static function Spawn_Scraps( toSpawnAt:MovieClip, toSpawnOn:DisplayObjectContainer, amountToSpawn:Number )
		{
			var ranDir;
			while( amountToSpawn > 0 )
			{
				--amountToSpawn;
				var tempSpawn:ScrapClip = new ScrapClip();
				
				tempSpawn.x = toSpawnAt.x;
				tempSpawn.y = toSpawnAt.y;
				
				ranDir = Math.random() * 360;
				if( ranDir <= 22 || ranDir > 338 )
				{
					tempSpawn.Velocity = PhysVector2D.RIGHT;
				}
				else if( ranDir > 22 && ranDir <= 67 )
				{
					tempSpawn.Velocity = new PhysVector2D( 1, 1 );
				}
				else if( ranDir > 67 && ranDir <= 112 )
				{
					tempSpawn.Velocity = PhysVector2D.UP;
				}
				else if( ranDir > 112 && ranDir <= 157 )
				{
					tempSpawn.Velocity = new PhysVector2D( -1, 1 );
				}
				else if( ranDir > 157 && ranDir <= 202 )
				{
					tempSpawn.Velocity = PhysVector2D.LEFT;
				}
				else if( ranDir > 202 && ranDir <= 247 )
				{
					tempSpawn.Velocity = new PhysVector2D( -1, -1 );
				}
				else if( ranDir > 247 && ranDir <= 292 )
				{
					tempSpawn.Velocity = PhysVector2D.DOWN;
				}
				else if( ranDir > 292 && ranDir <= 338 )
				{
					tempSpawn.Velocity = new PhysVector2D( 1, -1 );
				}
				
				toSpawnOn.addChild( tempSpawn );
			}
		}
	}
}