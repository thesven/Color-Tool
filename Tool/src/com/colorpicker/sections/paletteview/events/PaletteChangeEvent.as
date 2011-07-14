package com.colorpicker.sections.paletteview.events {
	import flash.events.Event;

	/**
	 * @author mikesven
	 */
	public class PaletteChangeEvent extends Event {
		
		public var pallet:Vector.<String>;
		
		public static const PALLET_CHANGE:String = "PALLET_CHANGE";
		
		public function PaletteChangeEvent(type : String, newPallet:Vector.<String>, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			pallet = newPallet;
		}
		
		
		override public function clone() : Event {
			return new PaletteChangeEvent(type, pallet, bubbles, true);
		}
		
	}
}
