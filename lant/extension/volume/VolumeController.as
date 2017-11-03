package lant.extension.volume
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	import flash.text.ReturnKeyLabel;
	
	import lant.extension.volume.VolumeEvent;
	
	public class VolumeController extends EventDispatcher
	{
		private static var instace1:VolumeController;
		private var extContext:ExtensionContext;
		
		private var systemVolume1:Number = NaN;
		
		public function get systemVolume():Number 
		{
			return systemVolume1;
		}
		
		public function set systemVolume( value:Number ):void 
		{
			if ( systemVolume1 == value ) {
				return;
			}
			systemVolume1 = value;
		}
		
		
		public function VolumeController()
		{
			super();
			
			extContext = ExtensionContext.createExtensionContext("lant.extension.volume", "" );
			
			if ( !extContext ) {
				throw new Error ( "Volume native extension is not supported on this platform." );
				
			}
			extContext.addEventListener( StatusEvent.STATUS, onStatus );
		}
		
		public static function get instance():VolumeController 
		{
			if ( !instace1) {
				instace1 = new VolumeController( );
				instace1.init();
			}
			
			return instace1;
		}
		
		
		public function setVolume( newVolume:Number ):void 
		{
			if ( isNaN(newVolume) ) {
				newVolume = 1;
			}
			
			if ( newVolume < 0 ) {
				newVolume = 0;
			}
			
			if ( newVolume > 1 ) {
				newVolume = 1;
			}
			
			extContext.call( "setVolume", newVolume );
			
			systemVolume = newVolume;
		}
		
		
		public function dispose():void 
		{
			extContext.dispose();
		}
		
		private function init():void {
			extContext.call( "init" );
		}
		
		private function onStatus( event:StatusEvent ):void {
			systemVolume = Number(event.level);
			dispatchEvent( new VolumeEvent( VolumeEvent.VOLUME_CHANGED, systemVolume, false, false ) );
		}
		
	}
}
class SingletonEnforcer
{
	
}


