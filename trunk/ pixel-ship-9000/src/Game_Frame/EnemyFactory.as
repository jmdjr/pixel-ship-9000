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
			MasterCopyList["Drone"] = new Enemy_Drone(); 
			MasterCopyList["BlueDrone"] = new Enemy_BlueDrone();
			MasterCopyList["Jav"] = new Enemy_Javelin();
			MasterCopyList["Bomb"] = new Enemy_Bomb();
			MasterCopyList["Meteor"] = new Enemy_Meteor_();
			MasterCopyList["GreenDrone"] = new Enemy_GreenDrone();
			
					
			MasterCopyList["MidBoss"] = new Enemy_L1MidBoss();
			MasterCopyList["BigBoss"] = new Enemy_L1Boss_Real();
		} 
		
		public function LoadBoundary( _bound:Rectangle, _wepBound:Rectangle ):void
		{
			Enemy_Drone( MasterCopyList["Drone"] ).LoadBoundary( _bound, _wepBound );
			Enemy_BlueDrone( MasterCopyList["BlueDrone"] ).LoadBoundary( _bound, _wepBound );
			Enemy_Javelin( MasterCopyList["Jav"] ).LoadBoundary( _bound, _wepBound );
			Enemy_Bomb( MasterCopyList["Bomb"] ).LoadBoundary( _bound, _wepBound );
			Enemy_Meteor_( MasterCopyList["Meteor"] ).LoadBoundary( _bound, _wepBound );
			Enemy_GreenDrone( MasterCopyList["GreenDrone"] ).LoadBoundary( _bound, _wepBound );
			
			
			Enemy_L1Boss_Real( MasterCopyList["BigBoss"] ).LoadBoundary( _bound, _wepBound );
			Enemy_L1MidBoss( MasterCopyList["MidBoss"] ).LoadBoundary( _bound, _wepBound );
		}
		
		public function Spawn( _enemy:String, _x:Number, _y:Number, _v:PhysVector2D, _s:Ship ):Enemy_
		{
			var spawnedShip:Enemy_ = MasterCopyList[_enemy].Spawn( _x, _y, _v );
			spawnedShip.LoadPlayerReference( _s );
			return spawnedShip;
		}
	}
}