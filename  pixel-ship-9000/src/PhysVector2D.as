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
		
		public static function Add( Left:PhysVector2D, Right:PhysVector2D ):PhysVector2D
		{
			return new PhysVector2D( Left.X + Right.X, Left.Y + Right.Y );
		}
		
		public static function Subtract( Left:PhysVector2D, Right:PhysVector2D ):PhysVector2D
		{
			return new PhysVector2D( Left.X - Right.X, Left.Y - Right.Y );
		}
		
		public static function Multiply( Left:PhysVector2D, Scalar:Number ):PhysVector2D
		{
			return new PhysVector2D( Left.X * Scalar, Left.Y * Scalar );
		}
		
		public function Add( Right:PhysVector2D ):void
		{
			X += Right.X;
			Y += Right.Y;
		}
		
		/** Subtracts the Right vector from the current vector*/
		public function Subtract( Right:PhysVector2D  ):void
		{
			X -= Right.X;
			Y -= Right.Y;
		}
		
		public function Multiply( Scalar:Number ):void
		{
			this.X *= Scalar;
			this.Y *= Scalar;
		}
		
		/** Assigns the Right vector to the current vector.  
		 * This will overwright the contents of the current vector.
		 * */
		public function Equal( Right:PhysVector2D ):void
		{
			if( Right != null )
			{
				X = Right.X;
				Y = Right.Y;
			}
		}
		
		/**
		 * This function will normalize the vector and return the magnitude 
		 *  simultaneously.  allowing the vector to be separated into its
		 *  magnitude and direction components.
		 * <br/><br/>
		 * <b>Returns:</b>
		 *   the magnitude of the vector before normalization.
		 */
		public function Normalize():Number
		{
			var magnitude = Magnitude();
			if( magnitude != 1 && magnitude != 0 )
			{
				X /= magnitude;
				Y /= magnitude;
			}
			
			return magnitude;
		}
		
		/** returns the magnitude of this velocity vector*/
		public function Magnitude():Number
		{
			return Math.sqrt( DotP( this ) );
		}
		
		/**returns the dot product between this velocity and the rVelocity*/
		public function DotP( Right:PhysVector2D ):Number
		{
			return X*Right.X + Y*Right.Y;
		}
		
		/**
		 * Returns a value that represents the magnitude of the 
		 * vector that would be perpendicular to the left and right vectors.
		 */
		public function CrossP( Right:PhysVector2D ):Number
		{
			return X * Right.Y - Y * Right.X;
		}
		
		/** 
		 * returns a Velocity object representing the Unit vector version.
		 *  this is different than Normalize in that it does not modify the current
		 *  velocity.
		 */
		public function UnitV():PhysVector2D
		{
			var unitV:PhysVector2D = new PhysVector2D( X, Y );
			unitV.Normalize();
			return unitV;
		}
		
		/** 
		 * returns a Velocity Object that is the magnitude of the current velocity,
		 * projected onto rVelocity.
		 * */
		public function Projection( Right:PhysVector2D ):PhysVector2D
		{
			var unitRVel:PhysVector2D = Right.UnitV();
			var projMag = DotP( unitRVel );
			unitRVel.Multiply( projMag );
			
			return unitRVel;
		}
		
		/** compares the current vector with another, returning the following equivelents:
		//  1: lVector  > rVector
		//  0: lVector == rVector
		// -1: lVector <  rVector
		// Note: this only applies to the vectors' magnitude.
		 * */
		public function CompareMagnitudes( Right:PhysVector2D ):Number
		{
			var left = Magnitude();
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
		
		public function TestDirOpposite( Right:PhysVector2D ):Boolean
		{
			var opposite:PhysVector2D = PhysVector2D.Multiply( UnitV(), -1 );
			var right = Right.UnitV();
			return ( opposite.X == right.X && opposite.Y == right.Y );
		}
		
		/**
		 * Returns a number which represents the directon of rotation needed for the
		 * current vector to point in the same direction as the Right vector.
		 * <br/><br/>
		 * <b>Returns:</b><br/>
		 *  -1: if right is counter clockwise at most 179.99 degrees from left.<br/> 
		 *   0: if left and right are either pointing in the same direction, or opposite directions.<br/>
		 *   1: if right is clockwise at most 179.99 degrees from the left.<br/>
		 * 	 */
		public function TestDirRelative( Right:PhysVector2D ):Number
		{
			var dotp = this.DotP( Right );
			var crossp = this.CrossP( Right );
			var opposite = this.TestDirOpposite( Right );
			
			if( opposite || dotp == 0 )
			{
				return 0;	
			}
			
			return 0;
		}
		
		public function toString():String
		{
			return "< X: " + X.toString() + ", Y: " + Y.toString() + " >";
		}
	}
}