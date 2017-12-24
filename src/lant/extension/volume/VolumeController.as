package my.extension.volume
{
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	import my.extension.volume.events.VolumeEvent;

	public class VolumeController extends EventDispatcher
	{
		private static var _instance:VolumeController;
		private var extContext:ExtensionContext;
		private var _systemVolume:Number = NaN;
		
		//Constructor
		public function VolumeController(enforcer:SingletonEnforcer)
		{
			extContext = ExtensionContext.createExtensionContext("my.extension.volume", "");
			if ( !extContext ) {
				throw new Error( "Volume native extension is not supported on this platform." );
			}
			extContext.addEventListener(StatusEvent.STATUS, onStatus);
		}
		
 		public function get systemVolume():Number
		{
			return _systemVolume;
		}
		
		public function set systemVolume(value:Number):void
		{
			if(_systemVolume == value)
				return;
			_systemVolume = value;
		}
		
		public static function get instance():VolumeController {
			if ( !_instance ) {
				_instance = new VolumeController( new SingletonEnforcer() );
				_instance.init();
			}
			
			return _instance;
		}
		
		public function dispose():void { 
			extContext.dispose(); 
		}
		private function init():void {
			extContext.call( "init" );
		}
		public function getCurrentVolume():Number{
			return Number(extContext.call("getCurrentVolume"));
		}
		
		private function onStatus(event:StatusEvent):void
		{
			systemVolume = Number(event.level);
			dispatchEvent(new VolumeEvent(VolumeEvent.VOLUME_CHANGED, systemVolume, false, false));
			
		}
		public function setVolume(newVolume:Number):void {
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
	}
}
class SingletonEnforcer {
	
}