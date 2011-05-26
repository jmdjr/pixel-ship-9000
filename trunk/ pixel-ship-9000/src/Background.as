/*
The Background class is linked to a background movie clip on the stage. 
The background will slowly scroll left (negative on the x axis) 1 pixel per frame (30 pixels per second)
The background image is 2110 pixel long, but is duplicated so it will appear to scroll seamlessly. 
When the background has scrolled all 2110 pixels, it will snap back to zero and keep scrolling. 
This will create the effect of an infinitely scrolling backdrop. 

Johnny Update: 
  The background is now updated to be compatible with AS 3.0.  Structure of objects are now
  more familiar.  The invocation of any function has now been left up to the parent object 
  containning the background.  This way, a scrolling background effect will only be activated
  when the parent object decides it should update, ensure a smaller and more managable event structure.

  The image is still associated with this class, but its starting postition has been added and all 
  magic numbers have been removed.
*/

package src
{	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Background extends MovieClip
	{
		public var startY:Number;
		public var scrollRate:Number;
		
		public function Background()
		{
			super();
			startY = 0;
			scrollRate = 0;
		}
		
		public function Update( tick:Event ):void
		{
			//move the background image one pixel to the left
			y += scrollRate;
			
			//if it has travelled its entire length (2110 pixels)
			if( y > this.height - this.startY )
			{
				//then snap it back to zero, it will appear to scroll seamlessly
				y = this.startY;
			}
		}
	}
}