package core.camera 
{
	import away3d.cameras.Camera3D;
	import away3d.containers.ObjectContainer3D;
	import away3d.core.math.Quaternion;
	import core.utils.MathUtils;
	import core.WorldStep;
	import flash.geom.Vector3D;
	
	public class HoverCameraController implements ICameraController
	{
		//x axis degree
		public var xDegree:Number = 0;
		//y axis degree
		public var yDegree:Number = 15;	
		
		public var hasMoved:Boolean = false;
		
		private var offset:Vector3D = new Vector3D();				
		
		//distance of camera
		private var _radius:Number = 500;
		//minimum distance of camera
		private var _minRadius:Number = 10;			
		
		//point of interest
		private var poi:ObjectContainer3D;
		//helping quaternion
		private var quat:Quaternion;
		
		private var camera:Camera3D;
		
		public function HoverCameraController(camera:Camera3D) 
		{
			this.camera = camera;

			initialize();
		}
		
		private function initialize():void 
		{
			poi = new ObjectContainer3D();
			
			quat = new Quaternion();
			quat.fromMatrix(camera.transform);		
			
			setCameraPosition(xDegree, -yDegree);		
			camera.eulers = quat.rotatePoint(new Vector3D(yDegree, xDegree, camera.rotationZ));	
		}
		
		public function update(worldStep:WorldStep = null):void
		{
			updateCamera();
		}
		
		private function updateCamera():void 
		{
			setCameraPosition(xDegree, -yDegree);							
			camera.eulers = quat.rotatePoint(new Vector3D(yDegree, xDegree, camera.rotationZ));

			if (hasMoved) //if camera moved then recalcualte radius from poi and position
				_radius = Vector3D.distance(camera.position, poi.scenePosition);
		}
		
		/**
		 * Update panning
		 * @param	dx - x delta
		 * @param	dy - y delta
		 */
		public function updatePanning(dx:Number, dy:Number):void
		{
			poi.rotationX = camera.rotationX;
			poi.rotationY = camera.rotationY;
			poi.rotationZ = camera.rotationZ;		
			
			dx *= (_radius / 500);
			dy *= (_radius / 500);
			
			if (dx != 0 || dy != 0) 
				hasMoved = true;
			
			//move along 2 axis up(y) and left(x)
			poi.moveUp(dy);
			poi.moveLeft(dx);
		}		
		
		/**
		 * Update rotation
		 * @param	dx - delta x degrees
		 * @param	dy - delta y degress
		 */
		public function updateRotation(dx:Number, dy:Number):void
		{			
			if (dx != 0 || dy != 0) 
				hasMoved = true;
				
			xDegree += dx;
			yDegree += dy;
		}		
		
		/**
		 * set camera position by calculating rotation and position
		 * @param	xDegree
		 * @param	yDegree
		 */
		private function setCameraPosition(xDegree:Number, yDegree:Number):void
		{
			var cy:Number = Math.cos(MathUtils.convertToRadian(yDegree)) * _radius;			
			
			camera.x = (poi.scenePosition.x + offset.x) - Math.sin(MathUtils.convertToRadian(xDegree)) * cy;
			camera.y = (poi.scenePosition.y + offset.y) - Math.sin(MathUtils.convertToRadian(yDegree)) * _radius;
			camera.z = (poi.scenePosition.z + offset.z) - Math.cos(MathUtils.convertToRadian(xDegree)) * cy;
		}			
		
	}

}