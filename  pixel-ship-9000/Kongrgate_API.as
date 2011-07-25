package
{
	import flash.display.MovieClip;
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	
	public class Kongrgate_API  extends MovieClip
	{
		// Pull the API path from the FlashVars
		private var paramObj:Object;
		
		// The API path. The "shadow" API will load if testing locally. 
		private var apiPath:String;
	
		// Load the API
		private var request:URLRequest;
		private var loader:Loader;

		// Kongregate API reference
		public var kongregate:*;
		
		// This function is called when loading is complete
		private function loadComplete( event:Event ):void
		{
			// Save Kongregate API reference
			kongregate = event.target.content;
			
			// Connect to the back-end
			if( kongregate.services != null )
			{
				kongregate.services.connect();
				trace( kongregate.getUsername() );
				// You can now access the API via:
				// kongregate.services
				// kongregate.user
				// kongregate.scores
				// kongregate.stats
				// etc...
			}
		}
		
		public function Kongrgate_API()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, AddToStage );
		}
		
		private function AddToStage( event:Event )
		{
			removeEventListener( Event.ADDED_TO_STAGE, AddToStage );
			
			// Pull the API path from the FlashVars
			paramObj = LoaderInfo( root.loaderInfo ).parameters;
			
			// The API path. The "shadow" API will load if testing locally. 
			apiPath = paramObj.kongregate_api_path ||  "http://www.kongregate.com/flash/API_AS3_Local.swf";
			
			// Allow the API access to this SWF
			Security.allowDomain( apiPath );
			
			// Load the API
			request = new URLRequest( apiPath );
			loader = new Loader();
			loader.load(request);
			addChild(loader);
			
			addEventListener( Event.COMPLETE, loadComplete );
		}
	}
}