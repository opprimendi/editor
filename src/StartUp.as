package
{
	import core.display.DisplayManager;
	import core.display.scenes.mainScene.MainScene;
	import core.display.scenes.ScenesController;
	import core.display.scenes.streamUploadScene.StreamUploadScene;
	import core.display.scenes.testFeatureScene.TestFeatureScene;
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
			
			//scenesController.addScene(new MainScene(0));
			scenesController.addScene(new TestFeatureScene(0));
			//scenesController.addScene(new StreamUploadScene(0));
			
			scenesController.setScene(0);
		}
	}
	
}