package com.colorpicker.sections.palletview.events {
	import flash.events.Event;

	/**
	 * @author mikesven
	 */
	public class PalletChangeEvent extends Event {
		
		public var pallet:Vector.<String>;
		
		public static const PALLET_CHANGE:String = "PALLET_CHANGE";
		
		public function PalletChangeEvent(type : String, newPallet:Vector.<String>, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			pallet = newPallet;
		}
		
		
		override public function clone() : Event {
			return new PalletChangeEvent(type, pallet, bubbles, true);
		}
		
	}
}
