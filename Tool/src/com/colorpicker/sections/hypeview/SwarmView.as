package com.colorpicker.sections.hypeview {
	import flash.display.MovieClip;
	import com.colorpicker.sections.hypeview.utils.HypeViewUtils;
	import hype.extended.color.ColorPool;
	import hype.framework.core.ObjectPool;
	import flash.display.Sprite;

	import com.colorpicker.sections.interfaces.IHypeView;

	/**
	 * @author mikesven
	 */
	public class SwarmView extends Sprite implements IHypeView {
		
		private var objPool:ObjectPool;
		private var colorPool:ColorPool;
		
		public function SwarmView() {
		}

		public function init(colorList : Vector.<String>) : void {
			
			objPool = new ObjectPool([Geo01, Geo02, Geo03, Geo04, Geo05], 152);
			
			colorPool = new ColorPool();
			HypeViewUtils.setColorPool(colorList, colorPool);
			
			objPool.onRequestObject = onPoolRequest;
			
		}

		public function reset(colorList : Vector.<String>) : void {
		}

		public function destroy() : void {
		}
		
		private function onPoolRequest(clip:MovieClip):void{
			
			colorPool.colorChildren(clip);
			
		}
	}
}
