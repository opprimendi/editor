package
{
	import core.display.DisplayManager;
	import core.display.scenes.ScenesController;
	import editor.display.scenes.editorScene.EditorScene;
	import editor.display.scenes.testFeatureScene.TestFeatureScene;
	import core.WorldTimeController;
	import flash.display.Sprite;
	
	public class StartUp extends Sprite 
	{
		public function StartUp() 
		{
			//entry point
			initialize();
		}
		
		private function initialize():void 
		{
			//will be added preloader code etc...
			
			var worldTimeController:WorldTimeController = new WorldTimeController();
			
			//setting up scenes
			var displayManager:DisplayManager = new DisplayManager(stage);
			displayManager.worldTimeController = worldTimeController;
			
			var scenesController:ScenesController = new ScenesController();
			scenesController.displayManager = displayManager;
			
			scenesController.addScene(new EditorScene(0));
			//scenesController.addScene(new TestFeatureScene(0));
			//scenesController.addScene(new StreamUploadScene(0));
			
			scenesController.setScene(0);
		}
	}
	
}