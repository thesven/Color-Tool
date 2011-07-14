package com.colorpicker.sections.paletteview {
	import com.colorpicker.sections.paletteview.events.PaletteChangeEvent;
	import com.colorpicker.sections.paletteview.events.PaletteChipEvent;
	import flash.display.Sprite;



	/**
	 * @author mikesven
	 */
	public class PaletteView extends Sprite {
		
		private var theWidth:int;
		private var theHeight:int;
		
		private var currentColors:Vector.<String>;
		private var currentChips:Vector.<PaletteChip>;
		private var currentChipWidth:Number;
		
		public function PaletteView(colorList:Vector.<String>, palletWidth:int, palletHeight:int) {
			
			theWidth = palletWidth;
			theHeight = palletHeight;
			
			currentColors = colorList;
			addEventListener(PaletteChipEvent.REMOVE_CHIP, onRemoveChip);
			addEventListener(PaletteChipEvent.REPOSTION_CHIP, onRepositionChip);
			
			init();	
			
		}
		
		public function destroy():void{
			clearPalletView();
			removeEventListener(PaletteChipEvent.REMOVE_CHIP, onRemoveChip);
			removeEventListener(PaletteChipEvent.REPOSTION_CHIP, onRepositionChip);
		}
		
		public function clearPalletView():void{
			
			if(currentChips != null){
				var len:int = currentChips.length;
				var i:int = 0;
				for(i; i < len; i++){
					removeChild(currentChips[i]);
				}
				
				currentChips = null;
				currentColors = null;
			}
			
		}

		private function init() : void {
			
			var chipCount:int = currentColors.length;
			currentChipWidth = theWidth / chipCount;
			
			if(currentChips == null){
				currentChips = new Vector.<PaletteChip>();
				currentColors.forEach(createChip);
			} else {
				currentChips.forEach(redrawChip);
			}
			
			
		}
		
		private function createChip(color:String, index:int, vec:Vector.<String>):void{
			
			var chip:PaletteChip = new PaletteChip(uint(color), index, currentChipWidth, theHeight, currentChipWidth * index);
			currentChips.push(chip);
			
			addChild(chip);
			
		}
		
		private function redrawChip(color:PaletteChip, index:int, vec:Vector.<PaletteChip>):void{
			
			color.update(index, index * currentChipWidth, currentChipWidth);
			addChild(color);
			
		}
		
		private function onRemoveChip(e:PaletteChipEvent):void{
			
			currentChips.forEach(removeAllChips);
			
			currentChips[e.chipID].destroy();
			currentChips[e.chipID] = null;
			
			currentChips.splice(e.chipID, 1);
			currentColors.splice(e.chipID, 1);
			
			dispatchEvent(new PaletteChangeEvent(PaletteChangeEvent.PALLET_CHANGE, currentColors, true, false));
			
			init();
			
			
		}
		
		private function onRepositionChip(e:PaletteChipEvent):void{
			
			var targetID:int = e.chipID;
			var targetChip:PaletteChip = currentChips[targetID];
			
			var i:int = 0;
			var max:int = currentChips.length;
			for(i; i < max; i++){
				
				var chip:PaletteChip = currentChips[i];
				
				if(chip.getBounds(this).contains(targetChip.x, targetChip.y) && chip.chipID != targetID){
					insertItemAt(targetID, chip.chipID);
					init();
					return;
				}
					
			}
			
			init();
			
		}
		
		private function removeAllChips(color:PaletteChip, index:int, vec:Vector.<PaletteChip>):void{
			removeChild(color);
		}
		
		private function insertItemAt(item:int, positionB:int):void{
			
			var tempChip:PaletteChip = currentChips[item];
			currentChips.splice(item, 1);
			currentChips.splice(positionB, 0, tempChip);
			
			var tempColor:String = currentColors[item];
			currentColors.splice(item, 1);
			currentColors.splice(positionB, 0, tempColor);
			
			dispatchEvent(new PaletteChangeEvent(PaletteChangeEvent.PALLET_CHANGE, currentColors, true, false));
			
		}
		
	}
}
