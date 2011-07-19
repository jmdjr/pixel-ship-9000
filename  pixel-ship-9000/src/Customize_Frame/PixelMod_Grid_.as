package src.Customize_Frame
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import src.GameDataTracker;
	import src.Game_Frame.Shot_;
	import src.Ship;

	public class PixelMod_Grid_
	{
		private var grid:Array;
		private var rows:Number;
		private var cols:Number;
		
		public function PixelMod_Grid_()
		{
			rows = 3; 
			cols = 3;
			
			grid = new Array( rows * cols );
		}
		
		public function Update( tick:Event ):void
		{
			grid.forEach(
				function( item:ModPixel_, index:int, array:Array )
				{
					if( item != null )
					{
						item.Update( tick );
					}
				});
		}
		
		public function DrawModPixelsOnShip( ship:Ship ):void
		{
			var mod:ModPixel_ = null;
			for( var r = 0; r < rows; ++r )
			{
				for( var c = 0; c < cols; ++c )
				{
					mod = ModPixel_(grid[r*cols+c]);
					if( mod != null )
					{
						mod.x = mod.positionX;
						mod.y = mod.positionY;
						
						ship.addChild( mod );
					}
				}
			}
		}
		public function AddModPixel( item:ModPixel_, r:Number, c:Number ):void
		{
			if( r >= rows || c >= cols || r < 0 || c < 0  || item == null )
			{
				return;
			}
			if( r*cols+c == 4 )
			{
				return;
			}
			
			grid[r*cols+c] = item;
			item.positionX = item.width * (r - 1); // -1, 0, 1
			item.positionY = item.height * (c - 1);
		}
		
		public function DeleteModPixel( ship:Ship, r:Number, c:Number ):void
		{
			if( r >= rows || c >= cols || r < 0 || c < 0 || ship == null || grid[r*cols+c] == null || !ship.contains( ModPixel_(grid[r*cols+c]) ) )
			{
				return;
			}
			
			ship.removeChild( ModPixel_(grid[r*cols+c]) );
			grid[r*cols+c] = null;  // hopefully this is handeled by the garbage collector.
		}
		
		public function DeleteAllMods( ship:Ship ):void
		{
			for( var i = 0; i < rows; ++i )
			{
				for( var j = 0; j < cols; ++j )
				{
					DeleteModPixel( ship, i, j );
				}
			}
		}
			
		/**
		 * Calculates the total Health accured from all mods on the ship.
		 * */
		public function CalcModHealth():Number
		{
			var totalMods:Array = grid.filter(
				function( item:Object, index:int, array:Array )
				{
					if( item != null )
					{
						return true;
					}
					
					return false;
				});
			
			return totalMods.length;
		}
		
		/**
		 * Calculates the total speed additions made by the Speed mods.
		 * Currently returns the number of Speed Mods on the ship.
		 * */
		public function CalcModSpeed():Number
		{
			var totalMods:Array = grid.filter(
				function( item:Object, index:int, array:Array )
				{
					if( item is ModPixel_Speed )
					{
						return true;
					}
					
					return false;
				});
			
			return totalMods.length;
		}
		
		/**
		 * Calculates the total defense made by the Defense mods.
		 * Currently returns the number of Defense mods on the ship.
		 * */
		
		public function CalcModDefense():Number
		{
			var totalMods:Array = grid.filter(
				function( item:Object, index:int, array:Array )
				{
					if( item is ModPixel_Defense )
					{
						return true;
					}
					
					return false;
				});
			
			return totalMods.length;
		}
		
		/**
		 * Makes all attack mods aware of the grid, and sets their firing
		 *  Directions.
		 * */
		public function CalibrateModAttack():void
		{
			//Step through and assign appropriate directions to fire for.
/*			for( var i = 0; i < rows; ++i )
			{
				for( var j = 0; j < cols; ++j )
				{
					if( grid[i*cols+j] is ModPixel_Attack )
					{
						
					}
				}
			}*/
		}
		
		/**
		 * Makes all attack mods aware of the grid, and sets their firing
		 *  Directions.
		 * */
		public function CalcModAttack():Number
		{
			var totalMods:Array = grid.filter(
				function( item:Object, index:int, array:Array )
				{
					if( item is ModPixel_Attack )
					{
						return true;
					}
					
					return false;
				});
			
			return totalMods.length;
		}
		
		/**
		 * Steps through all Attack Mods and Fires each one.
		 */
		public function FireOffAttackMods( gameData:GameDataTracker, ship:MovieClip ):void
		{
			var bullet:Shot_;
			
			for( var i = 0; i < grid.length; ++i )
			{
				if( grid[i] is ModPixel_Attack )
				{
					ModPixel_Attack(grid[i]).Fire( gameData, ship );
				}
			}
		}
		
		/**
		 * Returns true if a Mod exists at the designated row|col position.
		 *  these are zero based indecies.
		 * */
		public function CheckModAt( r:Number, c:Number ):ModPixel_
		{
			if( r >= rows || c >= cols || r < 0 || c < 0 )
			{
				return null;
			}
			if( r*cols + c == 4 )
			{
				return null;
			}
			
			return ModPixel_( grid[c*cols + r] );
		}
		
		public function DeletePixelModGrid( ship:Ship ):void
		{
			for( var i = 0; i < grid.length; ++i )
			{
				DeleteModPixel( ship, int(i/cols), i%cols );
			}	
		}
	}
}