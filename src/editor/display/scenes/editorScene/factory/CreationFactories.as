package editor.display.scenes.editorScene.factory 
{
	import away3d.core.base.Object3D;
	import core.commands.AddObject3DCommand;
	import core.commands.CommandProcessor;
	import editor.display.scenes.editorScene.EditorSceneView;
	
	public class CreationFactories 
	{
		private var _currentSceneView:EditorSceneView;
		
		private var commandProcessor:CommandProcessor;
		
		public function CreationFactories(commandProcessor:CommandProcessor) 
		{
			this.commandProcessor = commandProcessor;	
		}
		
		public function get currentSceneView():EditorSceneView 
		{
			return _currentSceneView;
		}
		
		public function set currentSceneView(value:EditorSceneView):void 
		{
			_currentSceneView = value;
		}
		
		public function create3DObjectFromPrototype(prototype:Object3D):void
		{
			var addObjectCommand:AddObject3DCommand = new AddObject3DCommand(_currentSceneView.layer3D);
			commandProcessor.pushCommand(addObjectCommand);
			addObjectCommand.execute();
			
		}
	}

}