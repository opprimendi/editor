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
		
		public function addScene(scene:AbstractScene):void
		{
			scenesMap[scene.sceneId] = scene;
		}
		
		public function setScene(sceneId:int):void
		{
			var sceneEntity:AbstractScene = scenesMap[sceneId];
			displayManager.showScene(sceneEntity);
		}
		
	}
}