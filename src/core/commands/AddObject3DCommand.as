package core.commands 
{
	import away3d.containers.ObjectContainer3D;
	import core.display.scenes.layers.SceneLayer3D;
	
	public class AddObject3DCommand extends Command 
	{
		public var objectToAdd:ObjectContainer3D;
		
		private var layer3D:SceneLayer3D;
		
		public function AddObject3DCommand(layer3D:SceneLayer3D) 
		{
			super();
			
			this.layer3D = layer3D;
		}
		
		override public function execute():void 
		{
			super.execute();
			
			layer3D.addChild3D(objectToAdd);
		}
		
		override public function cancel():void 
		{
			super.cancel();
			
			layer3D.removeChild3D(objectToAdd);
		}
	}
}