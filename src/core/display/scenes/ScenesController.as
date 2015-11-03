package core.display.scenes  
{
	import core.display.DisplayManager;

	public class ScenesController 
	{
		public var displayManager:DisplayManager;
		
		private var scenesMap:Object = { };
		
		public function ScenesController() 
		{
			
		}
		
		public function addScene(scene:BaseScene):void
		{
			scenesMap[scene.sceneId] = scene;
		}
		
		public function setScene(sceneId:int):void
		{
			var sceneEntity:BaseScene = scenesMap[sceneId];
			displayManager.showScene(sceneEntity);
		}
		
	}
}