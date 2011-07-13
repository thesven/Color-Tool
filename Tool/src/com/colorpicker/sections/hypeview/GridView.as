package com.colorpicker.sections.hypeview {
	import hype.extended.color.ColorPool;
	import hype.extended.layout.GridLayout;
	import hype.framework.core.ObjectPool;

	import com.colorpicker.sections.interfaces.IHypeView;

	import flash.display.MovieClip;
	import flash.display.Sprite;

	/**
	 * @author mikesven
	 */
	public class GridView extends Sprite implements IHypeView {
		
		private var objPool:ObjectPool;
		private var colorPool:ColorPool;
		private var layout:GridLayout;
		
		public function GridView() {
					
		}

		public function init(colorList : Vector.<String>) : void {
			
			layout = new GridLayout(50, 60, 50, 50, 19);
			objPool = new ObjectPool([Geo01, Geo02, Geo03, Geo04, Geo05], 152);
			
			objPool.onRequestObject = onPoolRequest;
			objPool.onReleaseObject = onPoolRelease;
			
			setColorPool(colorList);
			objPool.requestAll();
			
		}

		public function reset(colorList : Vector.<String>) : void {
			
			objPool.activeSet.forEach(startRelease);
			init(colorList);
			
		}
		
		public function destroy() : void {
			objPool.activeSet.forEach(startRelease);
			colorPool = null;
			layout = null;
			objPool.destroy();
		}
		
		private function setColorPool(colorList : Vector.<String>):void{
			
			colorPool = new ColorPool();
			for each(var color:String in colorList){
				var c:uint = uint(color);
				colorPool.addColor(c);
			}
			
		}
		
		private function onPoolRequest(clip:MovieClip):void{
			colorPool.colorChildren(clip);
			layout.applyLayout(clip);
			addChild(clip);
			
		}
		
		private function startRelease(clip:MovieClip):void{
			objPool.release(clip);
		}
		
		private function onPoolRelease(clip:MovieClip):void{
			removeChild(clip);
		}
		
	}
}
