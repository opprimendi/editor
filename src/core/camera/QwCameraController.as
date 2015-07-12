package core.camera 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.Scene3D;
	import away3d.controllers.HoverController;
	import away3d.core.math.MathConsts;
	import away3d.core.math.Quaternion;
	import away3d.core.math.Vector3DUtils;
	import away3d.debug.Trident;
	import away3d.entities.Mesh;
	import away3d.primitives.SphereGeometry;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	/**
	 * ...
	 * @author Asfel
	 */
	public class QwCameraController 
	{
		private var camera:Camera3D;
		private var _distance:Number = 250;
		
		private var rotation:Vector3D = new Vector3D(45, 0, 0);
		private var lookAtPoint:Vector3D = new Vector3D();
		
		private var sceneContainer:Sprite;
		
		private var lastMouseX:Number = 0;
		private var lastMouseY:Number = 0;
		
		private var move:Boolean = false;
		private var scene3D:Scene3D;
		private var tracer:Mesh;
		
		
		/////////////////////
		
		private static var quaternionHelper:Quaternion = new Quaternion();
		
		private var rotationQ1:Quaternion = new Quaternion();
		private var rotationQ2:Quaternion = new Quaternion();
		
		private var cameraPosition:Vector3D = new Vector3D();
		
		public function QwCameraController(camera:Camera3D, sceneContainer:Sprite, scene3D:Scene3D) 
		{
			this.scene3D = scene3D;
			this.camera = camera;
			this.sceneContainer = sceneContainer;
			
			tracer = new Mesh(new SphereGeometry());

			tracer.addChild(new Trident(100));
			scene3D.addChild(tracer);




			
			initialize();
		}
		
		private function initialize():void 
		{
			sceneContainer.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
			sceneContainer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			sceneContainer.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			sceneContainer.addEventListener(Event.MOUSE_LEAVE, onMouseUp);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			move = false;
		}
		
		private function onMouseDown(e:MouseEvent):void 
		{
			move = true;
			
			lastMouseX = sceneContainer.mouseX;
			lastMouseY = sceneContainer.mouseY;
		}
		
		private function onWheel(e:MouseEvent):void 
		{
			trace(distance);
			distance -= (e.delta * 5);
			
		}
		
		public function get distance():Number 
		{
			return _distance;
		}
		
		public function set distance(value:Number):void 
		{
			_distance = value;
			trace("set distance " + value);
			if (_distance < 0)
				_distance = 0;
		}
		
		public function update():void 
		{
			if (move)
			{
				var halfContainerWidth:Number = sceneContainer.width * 0.5;
				var halfContainerHeight:Number = sceneContainer.height * 0.5; 
				
				var rotationRateX:Number = 1.5 * (sceneContainer.mouseX - halfContainerWidth) / halfContainerWidth;
				var rotationRateY:Number = 1.5 * (sceneContainer.mouseY - halfContainerHeight) / halfContainerHeight;
				
				
				quaternionHelper.fromAxisAngle(Vector3D.Z_AXIS, Math.PI / 180 * rotationRateX);
				rotationQ1.multiply(rotationQ1, quaternionHelper);
				
				quaternionHelper.fromAxisAngle(Vector3D.X_AXIS, Math.PI / 180 * rotationRateY);
				rotationQ2.multiply(rotationQ2, quaternionHelper);
				
				
				rotation.z = sceneContainer.mouseX - lastMouseX + rotation.z;
				//rotation.y = sceneContainer.mouseY - lastMouseY + rotation.y;
				
				lastMouseX = sceneContainer.mouseX;
				lastMouseY = sceneContainer.mouseY;
			}
			
			
			setCamera();
		}
		
		private function setCamera():void
		{
			var v1:Vector3D = new Vector3D(0, _distance, 0);
			var v2:Vector3D = new Vector3D(0, 0, _distance);
			
			
			//trace(cameraPosition);
			
			rotationQ1.rotatePoint(v1, v1);
			rotationQ2.rotatePoint(v2, v2);
			cameraPosition = v1.add(v2);
			//Vector3DUtils.rotatePoint(cameraPosition, rotation);
			
			//camera.x = cameraPosition.x;
			//camera.y = cameraPosition.y;
			//camera.z = cameraPosition.z;
			
			camera.y = -500;
			camera.z = 500;
			
			

			var rot:Vector3D = new Vector3D();
			rotationQ1.toEulerAngles(rot);
			
			//tracer.rotationZ = rot.z * MathConsts.RADIANS_TO_DEGREES;
			
			rotationQ2.toEulerAngles(rot);
			
			//tracer.rotationX = -rot.x * MathConsts.RADIANS_TO_DEGREES;
			
			//tracer.transform = quat.toMatrix3D(tracer.transform);
			
			
			tracer.x = cameraPosition.x;
			tracer.y = cameraPosition.y;
			tracer.z = cameraPosition.z;
			
			var xx:Number = cameraPosition.x - 0;
			var yy:Number = cameraPosition.y - 0;
			var zz:Number = cameraPosition.z - 0;
			
			//tracer.rotationX = rot.x * MathConsts.RADIANS_TO_DEGREES;
			//tracer.rotationY = rot.y * MathConsts.RADIANS_TO_DEGREES;
			//tracer.rotationZ = rot.z * MathConsts.RADIANS_TO_DEGREES;

			
			//tracer.rotationZ = (Math.atan2(yy, xx) - Math.PI) * MathConsts.RADIANS_TO_DEGREES;
			//tracer.rotationY = (Math.atan2(xx, yy)) * MathConsts.RADIANS_TO_DEGREES;
			
			
			
			camera.lookAt(new Vector3D());
			
			if (false)
			{
				camera.position = tracer.position;
				
				camera.rotationX = tracer.rotationX - 90;
				camera.rotationY = tracer.rotationY;
				camera.rotationZ = tracer.rotationZ;
			}
			//rotation.z++;
			
		}
		
	}
}