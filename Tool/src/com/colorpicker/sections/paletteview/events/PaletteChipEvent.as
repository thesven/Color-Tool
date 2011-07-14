package com.colorpicker.sections.paletteview.events {
	import flash.events.Event;

	/**
	 * @author mikesven
	 */
	public class PaletteChipEvent extends Event {
		
		public var chipID:int;
		
		public static const REMOVE_CHIP:String = "REMOVE_CHIP";
		public static const REPOSTION_CHIP:String = "REPOSITION_CHIP";
		
		public function PaletteChipEvent(type : String, theID:int, bubbles : Boolean = false, cancelable : Boolean = false) {
			chipID = theID;
			super(type, bubbles, cancelable);
		}
			
		override public function clone() : Event {
			return new PaletteChipEvent(type, chipID, bubbles, cancelable);
		}
		
	}
}
