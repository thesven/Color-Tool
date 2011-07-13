package com.colorpicker.image.loading {
	import flash.utils.ByteArray;
	import flash.events.Event;

	/**
	 * @author mikesven
	 */
	public class ImageLoadingEvent extends Event {
		
		public var data:ByteArray;
		
		public static const GIF_IMAGE_LOADED:String = "GIF_IMAGE_LOADED";
		
		public function ImageLoadingEvent(type : String, imageData:ByteArray, bubbles : Boolean = false, cancelable : Boolean = false) {
			
			data = imageData;
			
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone() : Event {
			return new ImageLoadingEvent(type, data, bubbles, cancelable);
		}
		
	}
}
