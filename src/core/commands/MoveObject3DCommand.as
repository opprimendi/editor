package core.commands 
{
	import away3d.core.base.Object3D;
	import flash.geom.Vector3D;
	
	public class MoveObject3DCommand extends Command 
	{
		public var objectToMove:Object3D;
		
		private var newPosition:Vector3D = new Vector3D();
		private var oldPosition:Vector3D = new Vector3D();
		
		public function MoveObject3DCommand() 
		{
			super();
		}
		
		public function setNewPosition(x:int, y:int, z:int):void
		{
			newPosition.setTo(x, y, z);
		}
		
		override public function execute():void 
		{
			super.execute();
			
			oldPosition.setTo(objectToMove.x, objectToMove.y, objectToMove.z);
			
			moveTo(newPosition);
		}
		
		override public function cancel():void 
		{
			super.cancel();
			
			moveTo(oldPosition);
		}
		
		private function moveTo(position:Vector3D):void
		{
			objectToMove.x = position.x;
			objectToMove.y = position.y;
			objectToMove.z = position.z;
		}
	}
}