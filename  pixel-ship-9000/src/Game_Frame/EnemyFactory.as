package src.Game_Frame
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import src.PhysVector2D;
	import src.Ship;

	// The factory data type is a loosely defined OO object which acts as the machine which spawns an object.
	// Here, we will define a factory for the enemies.  This object will contain a single instance of each enemy
	// (used as the master copy) to spawn the enemies.  No other functionality should be added into this class
	//  to maintain simplicity.
	public class EnemyFactory 
	{
		private var MasterCopyList:Dictionary;
		
		public function EnemyFactory()
		{
			MasterCopyList = new Dictionary();
			MasterCopyList["Drone"] = new EnemyDrone(); 
			MasterCopyList["Jav"] = new EnemyJavelin();
			MasterCopyList["Bomb"] = new EnemyBomb();
			
			MasterCopyList["MidBoss"] = new Lvl01_MidBoss();
		} 
		
		public function LoadBoundary( _bound:Rectangle, _wepBound:Rectangle ):void
		{
			EnemyDrone( MasterCopyList["Drone"] ).LoadBoundary( _bound, _wepBound );
			EnemyJavelin( MasterCopyList["Jav"] ).LoadBoundary( _bound, _wepBound );
			EnemyBomb( MasterCopyList["Bomb"] ).LoadBoundary( _bound, _wepBound );
			
			Lvl01_MidBoss( MasterCopyList["MidBoss"] ).LoadBoundary( _bound, _wepBound );
		}
		
		public function Spawn( _enemy:String, _x:Number, _y:Number, _v:PhysVector2D, _s:Ship ):EnemyObject
		{
			var spawnedShip:EnemyObject = MasterCopyList[_enemy].Spawn( _x, _y, _v );
			spawnedShip.LoadPlayerReference( _s );
			return spawnedShip;
		}
	}
}