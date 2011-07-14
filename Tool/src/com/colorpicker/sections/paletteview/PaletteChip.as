package com.colorpicker.sections.paletteview {
	import com.colorpicker.sections.paletteview.events.PaletteChipEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author mikesven
	 */
	public class PaletteChip extends Sprite {
		
		private var color:uint;
		private var id:int;
		private var theWidth:Number;
		private var theHeight:int;
		private var xPos:Number;
		
		public function PaletteChip(chipColor:uint, chipID:int, chipWidth:Number, chipHeight:Number, chipPos:Number) {
			
			color = chipColor;
			id = chipID;
			theWidth = chipWidth;
			theHeight = chipHeight;
			xPos = chipPos;
			this.x = xPos;
			
			this.mouseEnabled = true;
			this.addEventListener(MouseEvent.RIGHT_CLICK, onDoubleClick);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			draw();
			
		}
		
		public function get chipID():int{
			return id;
		}
		
		public function update(chipID:int, chipPos:Number, chipWidth:Number):void{
			
			id = chipID;
			theWidth = chipWidth;
			xPos = chipPos;
			this.x = xPos;
			
			draw();
			
		}
		
				
		public function destroy():void{
			this.graphics.clear();
			this.removeEventListener(MouseEvent.RIGHT_CLICK, onDoubleClick);
			this.removeEventListener(MouseEvent.MIDDLE_MOUSE_UP, onMouseUp);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function onMouseDown(e : MouseEvent) : void {
			
			PaletteView(this.parent).addChild(this);
			var bounds:Rectangle = PaletteView(this.parent).getBounds(this.parent);
			bounds.height = 1;
			this.startDrag(false, bounds);;
			
		}

		private function onMouseUp(e : MouseEvent) : void {
			this.stopDrag();
			if(this.x != xPos){
				dispatchEvent(new PaletteChipEvent(PaletteChipEvent.REPOSTION_CHIP, id, true, false));
			}
		}
		
		private function draw() : void {
			
			graphics.clear();
			//graphics.lineStyle(1, 0x000000, 1, true, "normal", null, null, null);
			graphics.beginFill(color, 1);
			graphics.drawRect(0, 0, theWidth, theHeight);
			graphics.endFill();
			
		}
		
		private function onDoubleClick(e:MouseEvent):void{
			
			dispatchEvent(new PaletteChipEvent(PaletteChipEvent.REMOVE_CHIP, id, true, false));
			
		}
		
	}
}
