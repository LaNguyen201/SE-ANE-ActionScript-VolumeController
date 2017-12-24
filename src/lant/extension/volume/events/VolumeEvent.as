package my.extension.volume.events
{
	import flash.events.Event;

	public class VolumeEvent extends Event
	{
		//check when volume change
		public static const VOLUME_CHANGED:String = "volumeChanged";
		//system volum
		public var volume:Number;
		
		public function VolumeEvent(type:String, volume:Number, bubbles:Boolean=false, cacelable:Boolean=false)
		{
			this.volume = volume;
			super(type, bubbles, cacelable);
		}
	}
}