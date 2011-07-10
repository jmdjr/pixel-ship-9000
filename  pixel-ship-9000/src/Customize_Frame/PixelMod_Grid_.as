package src.Customize_Frame
{

	public class PixelMod_Grid_
	{
		private var grid:Vector.<ModPixel_>;
		private var rows:Number;
		private var cols:Number;
		
		public function PixelMod_Grid_()
		{
			rows = 3;
			cols = 3;
		}
			
		/**
		 * Calculates the total Health accured from all mods on the ship.
		 * */
		public function CalcModHealth():Number
		{
			var totalMods:Vector.<ModPixel_> = grid.filter(
				function( item:Object, index:int, array:Array )
				{
					if( item is ModPixel_ )
					{
						return true;
					}
					
					return false;
				});
			
			return totalMods.length;
		}
		
		
		/**
		 * Calculates the total speed additions made by the Speed mods.
		 * */
		public function CalcModSpeed():Number
		{
			var totalMods:Vector.<ModPixel_> = grid.filter(
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
		 * */
		
		public function CalcModDefense():Number
		{
			var totalMods:Vector.<ModPixel_> = grid.filter(
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
		 *  Directions
		 * */
		public function CalcModAttack():void
		{
			
		}
	}
}