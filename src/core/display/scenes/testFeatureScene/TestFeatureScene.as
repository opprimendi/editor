package core.display.scenes.testFeatureScene 
{
	import away3d.entities.Mesh;
	import away3d.primitives.SphereGeometry;
	import core.commands.AddObjectCommand;
	import core.display.scenes.mainScene.MainScene;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class TestFeatureScene extends MainScene 
	{
		
		public function TestFeatureScene(sceneId:int) 
		{
			super(sceneId);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			for (var i:int = 0; i < 50; i++)
				createAddObjectAction();
		}
		
		private function createAddObjectAction():void 
		{
			var addObjectCommand:AddObjectCommand = new AddObjectCommand(sceneContext);
			
			var object:Mesh = new Mesh(new SphereGeometry());
			
			object.x = -500 + Math.random() * 1000;
			object.y = -50 + Math.random() * 100;
			object.z = -500 + Math.random() * 1000;
			
			addObjectCommand.objectToAdd = object;
			
			addObjectCommand.execute();
			
			commandProcessor.pushCommand(addObjectCommand);
			
			var helpText:TextField = new TextField();
			helpText.text = "Use CTRL+Z to undo action and CTRL+Y to redo action";
			helpText.textColor = 0xFFFFFF;
			helpText.autoSize = TextFieldAutoSize.LEFT;
			
			mainSceneView.addChild(helpText);
			
			helpText.y = 100;
		}
		
	}

}