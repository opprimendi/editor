package core.display.scenes 
{
	import core.display.scenes.layers.SceneLayer;
	import core.IUpdatable;
	import core.WorldStep;
	import flash.display.Sprite;
	
	public class BaseSceneView extends Sprite implements IUpdatable
	{
		protected var isActive:Boolean;
		protected var layers:Vector.<SceneLayer> = new Vector.<SceneLayer>;
		
		public function BaseSceneView() 
		{
			
		}
		
		public function addLayer(sceneLayer:SceneLayer):void
		{
			layers.push(sceneLayer);
			addChild(sceneLayer);
		}
		
		public function update(worldStep:WorldStep = null):void 
		{
			var i:int;
			
			for (i = 0; i < layers.length; i++)
			{
				layers[i].update(worldStep);
			}
		}
		
		public function onResize():void 
		{
			
		}
		
		public function deactivate():void
		{
			isActive = false;
		}
		
		public function activate():void
		{
			isActive = true;
		}
		
		protected function initialize():void 
		{
			
		}
	}
}