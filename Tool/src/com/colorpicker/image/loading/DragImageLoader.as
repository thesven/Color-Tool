package com.colorpicker.image.loading {
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileReference;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author mikesven
	 */
	public class DragImageLoader extends EventDispatcher {
		
		private var file:File;
		private var extension:String;
		
		public function DragImageLoader(url:String) {
			
			file = new File();
			file.addEventListener(Event.COMPLETE, onLoadComplete);
			file.url = url;
			file.load();
			
			
		}

		private function onLoadComplete(e : Event) : void {
		
			extension = file.extension;
			
			file.removeEventListener(Event.COMPLETE, onLoadComplete);
			
			dispatchEvent(new ImageLoadingEvent(ImageLoadingEvent.IMAGE_LOADED, file.data, extension, true, false));
			
		}
		
		
		
	}
}
