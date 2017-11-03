package lant.extension.volume
{
	import flash.events.Event;
	
	public class VolumeEvent extends Event
	{
		public static const VOLUME_CHANGED:String = "volumeChanged";
		public var volume:Number;
		public function VolumeEvent( type:String, volume:Number, bubbles:Boolean=false, cancelable:Boolean=false )
		{
			super(type,bubbles,cancelable);
		}
	}
}