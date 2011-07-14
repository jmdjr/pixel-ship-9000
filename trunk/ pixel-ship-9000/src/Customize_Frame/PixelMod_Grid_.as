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
			Vector.<ModPixel_>(grid).forEach(
				function( item:ModPixel_, index:int, array:Vector.<ModPixel_> )
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
						mod.x = mod.positionX + ship.x;
						mod.y = mod.positionY + ship.y;
					
						ship.addChild( mod );
					}
				}
			}
		}
		public function AddModPixel( item:ModPixel_, r:Number, c:Number ):void
		{
			if( r >= rows || c >= cols || r < 0 || c < 0 )
			{
				return;
			}
			
			grid[r*cols+c] = item;
			item.positionX = item.width * (c - 1); // -1, 0, 1
			item.positionY = item.height * (r - 1);
		}
		
		public function DeleteModPixel( ship:Ship, r:Number, c:Number ):void
		{
			if( r >= rows || c >= cols || r < 0 || c < 0 )
			{
				return;
			}
			
			ship.removeChild( ModPixel_(grid[r*cols+c]) );
			grid[r*cols+c] = null;  // hopefully this is handeled by the garbage collector.
		}
			
		/**
		 * Calculates the total Health accured from all mods on the ship.
		 * */
		public function CalcModHealth():Number
		{
			var totalMods:Vector.<ModPixel_> = Vector.<ModPixel_>(grid).filter(
				function( item:ModPixel_, index:int, array:Vector.<ModPixel_> )
				{
					if( item is ModPixel_ )
					{
						return true;
					}
					
					return false;
				});
			
			return totalMods.length;
		}
		
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
		 * Calculates the total speed additions made by the Speed mods.
		 * */
		public function CalcModSpeed():Number
		{
			var totalMods:Vector.<ModPixel_> = Vector.<ModPixel_>(grid).filter(
				function( item:ModPixel_, index:int, array:Vector.<ModPixel_> )
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
		 * */
		public function CalcModDefense():Number
		{
			var totalMods:Vector.<ModPixel_> = Vector.<ModPixel_>(grid).filter(
				function( item:Object, index:int, array:Vector.<ModPixel_> )
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
		 *  Directions
		 * */
		public function CalcModAttack():void
		{
			
		}
		
		/**
		 * Returns true if a Mod exists at the designated row|col position.
		 *  these are zero based indecies.
		 * */
		public function CheckModAt( r:Number, c:Number ):Boolean
		{
			if( r >= rows || c >= cols || r < 0 || c < 0 )
			{
				return true;
			}
			
			return grid[r*cols + c] != null;
		}
	}
}