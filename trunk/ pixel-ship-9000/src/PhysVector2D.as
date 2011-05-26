package src 
{
	public class PhysVector2D
	{
		public var X:Number;
		public var Y:Number;
		
		public static var UP:PhysVector2D    = new PhysVector2D( 0, -1 );
		public static var DOWN:PhysVector2D  = new PhysVector2D( 0,  1 );
		public static var LEFT:PhysVector2D  = new PhysVector2D( -1, 0 );
		public static var RIGHT:PhysVector2D = new PhysVector2D(  1, 0 );
		public static var ZERO:PhysVector2D  = new PhysVector2D(  0, 0 );
		
		public function PhysVector2D( x:Number = 0, y:Number = 0 )
		{
			X = x;
			Y = y;
		}
		
		// returns the magnitude of this velocity vector
		public function Magnitude():Number
		{
			return Math.sqrt( Math.pow( this.X, 2 ) + Math.pow( this.Y, 2 ) );
		}
		
		// returns the dot product between this velocity and the rVelocity
		public function DotP( Right:PhysVector2D ):Number
		{
			return this.X*Right.X + this.Y*Right.Y;
		}
		
		/**
		 * Author: John M Davis Jr
		 * 
		 * Normalize():Number
		 * 
		 * This function will normalize the vector and return the magnitude 
		 *  simultaneously.  allowing the vector to be separated into its
		 *  magnitude and direction components.
		 * 
		 * Returns:
		 *   Number - the magnitude of the vector before normalization.
		 * 
		 */
		public function Normalize():Number
		{
			var magnitude = this.Magnitude();
			if( magnitude != 1 && magnitude != 0 )
			{
				this.X /= magnitude;
				this.Y /= magnitude;
			}
			
			return magnitude;
		}
		
		// returns a Velocity object representing the Unit vector version.
		//  this is different than Normalize in that it does not modify the current
		//  velocity.
		public function UnitV():PhysVector2D
		{
			var unitV:PhysVector2D = new PhysVector2D( this.X, this.Y );
			unitV.Normalize();
			return unitV;
		}
		
		// returns a Velocity Object that is the magnitude of the current velocity,
		//  projected onto rVelocity.
		public function Projection( Right:PhysVector2D ):PhysVector2D
		{
			var unitRVel = Right.UnitV();
			var projMag = this.DotP( unitRVel );
			unitRVel.X *= projMag;
			unitRVel.Y *= projMag;
			
			return unitRVel;
		}
		
		public static function Add( Left:PhysVector2D, Right:PhysVector2D ):PhysVector2D
		{
			return new PhysVector2D( Left.X + Right.X, Left.Y + Right.Y );
		}
		
		public function Add( Right:PhysVector2D ):void
		{
			this.X += Right.X;
			this.Y += Right.Y;
		}
		
		public static function Subtract( Left:PhysVector2D, Right:PhysVector2D ):PhysVector2D
		{
			return new PhysVector2D( Left.X - Right.X, Left.Y - Right.Y );
		}
		
		// Subtracts the Right vector from the current vector
		public function Subtract( Right:PhysVector2D  ):void
		{
			this.X -= Right.X;
			this.Y -= Right.Y;
		}
		
		public static function Multiply( Left:PhysVector2D, Scalar:Number ):PhysVector2D
		{
			return new PhysVector2D( Left.X * Scalar, Left.Y * Scalar );
		}
		
		public function Multiply( Scalar:Number ):void
		{
			this.X *= Scalar;
			this.Y *= Scalar;
		}
		
		// Assigns the Right vector to the current vector.  This will overwright the contents of the current vector
		public function Equal( Right:PhysVector2D ):void
		{
			if( Right != null )
			{
				this.X = Right.X;
				this.Y = Right.Y;
			}
		}
		
		// compares the current vector with another, returning the following equivelents:
		//  1: lVector  > rVector
		//  0: lVector == rVector
		// -1: lVector <  rVector
		// Note: this only applies to the vectors' magnitude.
		public function ComparedTo( Right:PhysVector2D ):Number
		{
			var left = this.Magnitude();
			var right = Right.Magnitude();
			
			if( left > right )
			{
				return 1;
			}
			else if( left == right )
			{
				return 0;
			}
			
			return -1;
		}
		
		public function OppositeDirection( Right:PhysVector2D ):Boolean
		{
			var opposite = PhysVector2D.Multiply( this.UnitV(), -1 );
			var right = Right.UnitV();
			return ( this.X == right.X && this.Y == right.Y );
		}
		
		public function toString():String
		{
			return "< X: " + this.X.toString() + ", Y: " + this.Y.toString() + " >";
		}
	}
}