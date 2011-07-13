package com.colorpicker.sections.palletview {
	import com.colorpicker.sections.palletview.events.PalletChangeEvent;
	import com.colorpicker.sections.palletview.events.PalletChipEvent;

	import flash.display.Sprite;


	/**
	 * @author mikesven
	 */
	public class PalletView extends Sprite {
		
		private var theWidth:int;
		private var theHeight:int;
		
		private var currentColors:Vector.<String>;
		private var currentChips:Vector.<PalletChip>;
		private var currentChipWidth:Number;
		
		public function PalletView(colorList:Vector.<String>, palletWidth:int, palletHeight:int) {
			
			theWidth = palletWidth;
			theHeight = palletHeight;
			
			currentColors = colorList;
			addEventListener(PalletChipEvent.REMOVE_CHIP, onRemoveChip);
			addEventListener(PalletChipEvent.REPOSTION_CHIP, onRepositionChip);
			
			init();	
			
		}
		
		public function destroy():void{
			clearPalletView();
			removeEventListener(PalletChipEvent.REMOVE_CHIP, onRemoveChip);
			removeEventListener(PalletChipEvent.REPOSTION_CHIP, onRepositionChip);
		}
		
		public function clearPalletView():void{
			
			var len:int = currentChips.length;
			var i:int = 0;
			for(i; i < len; i++){
				removeChild(currentChips[i]);
			}
			
			currentChips = null;
			currentColors = null;
			
		}

		private function init() : void {
			
			var chipCount:int = currentColors.length;
			currentChipWidth = theWidth / chipCount;
			
			if(currentChips == null){
				currentChips = new Vector.<PalletChip>();
				currentColors.forEach(createChip);
			} else {
				currentChips.forEach(redrawChip);
			}
			
			
		}
		
		private function createChip(color:String, index:int, vec:Vector.<String>):void{
			
			var chip:PalletChip = new PalletChip(uint(color), index, currentChipWidth, theHeight, currentChipWidth * index);
			currentChips.push(chip);
			
			addChild(chip);
			
		}
		
		private function redrawChip(color:PalletChip, index:int, vec:Vector.<PalletChip>):void{
			
			color.update(index, index * currentChipWidth, currentChipWidth);
			addChild(color);
			
		}
		
		private function onRemoveChip(e:PalletChipEvent):void{
			
			currentChips.forEach(removeAllChips);
			
			currentChips[e.chipID].destroy();
			currentChips[e.chipID] = null;
			
			currentChips.splice(e.chipID, 1);
			currentColors.splice(e.chipID, 1);
			
			dispatchEvent(new PalletChangeEvent(PalletChangeEvent.PALLET_CHANGE, currentColors, true, false));
			
			init();
			
			
		}
		
		private function onRepositionChip(e:PalletChipEvent):void{
			
			var targetID:int = e.chipID;
			var targetChip:PalletChip = currentChips[targetID];
			
			var i:int = 0;
			var max:int = currentChips.length;
			for(i; i < max; i++){
				
				var chip:PalletChip = currentChips[i];
				
				if(chip.getBounds(this).contains(targetChip.x, targetChip.y) && chip.chipID != targetID){
					insertItemAt(targetID, chip.chipID);
					init();
					return;
				}
					
			}
			
			init();
			
		}
		
		private function removeAllChips(color:PalletChip, index:int, vec:Vector.<PalletChip>):void{
			removeChild(color);
		}
		
		private function insertItemAt(item:int, positionB:int):void{
			
			var tempChip:PalletChip = currentChips[item];
			currentChips.splice(item, 1);
			currentChips.splice(positionB, 0, tempChip);
			
			var tempColor:String = currentColors[item];
			currentColors.splice(item, 1);
			currentColors.splice(positionB, 0, tempColor);
			
			dispatchEvent(new PalletChangeEvent(PalletChangeEvent.PALLET_CHANGE, currentColors, true, false));
			
		}
		
	}
}
