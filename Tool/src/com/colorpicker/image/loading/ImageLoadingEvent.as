package com.colorpicker.image.loading {
	import flash.utils.ByteArray;
	import flash.events.Event;

	/**
	 * @author mikesven
	 */
	public class ImageLoadingEvent extends Event {
		
		public var data:ByteArray;
		public var extension:String;
		
		public static const IMAGE_LOADED:String = "IMAGE_LOADED";
		
		public function ImageLoadingEvent(type : String, imageData:ByteArray, fileExtension:String, bubbles : Boolean = false, cancelable : Boolean = false) {
			
			data = imageData;
			extension = fileExtension;
			
			super(type, bubbles, cancelable);
		}
		
		
		override public function clone() : Event {
			return new ImageLoadingEvent(type, data, extension, bubbles, cancelable);
		}
		
	}
}
