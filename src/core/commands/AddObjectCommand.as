package core.commands 
{
	import away3d.containers.ObjectContainer3D;
	import core.display.scenes.mainScene.data.MainSceneContext;
	/**
	 * ...
	 * @author Asfel
	 */
	public class AddObjectCommand extends Command 
	{
		public var objectToAdd:ObjectContainer3D;
		
		private var sceneContext:MainSceneContext;
		
		public function AddObjectCommand(sceneContext:MainSceneContext) 
		{
			super();
			this.sceneContext = sceneContext;
		}
		
		override public function execute():void 
		{
			super.execute();
			
			sceneContext.layerView.addChild3D(objectToAdd);
		}
		
		override public function cancel():void 
		{
			super.cancel();
			
			sceneContext.layerView.removeChild3D(objectToAdd);
		}
		
	}

}