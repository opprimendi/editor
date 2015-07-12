package core.utils 
{
	import away3d.core.math.Quaternion;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author Asfel
	 */
	public class OrientationCube 
	{
		public var cubeRotation:Vector3D = new Vector3D();
		public var prevcubeRotation:Vector3D = new Vector3D();
		
		public var qRotationX:Quaternion = new Quaternion();
		public var qRotationY:Quaternion = new Quaternion();
		public var qRotationZ:Quaternion = new Quaternion();
		
		public var qAccum:Quaternion = new Quaternion();
		
		protected const DEGREES_TO_RADIANS:Number = Math.PI / 180.0;
		
		public function OrientationCube() 
		{
			
		}

		/**
		* PITCH = Z
		* 
		*/
		public function SetPitch( angle:Number ):void
		{
			var rotationAngle:Number = angle * DEGREES_TO_RADIANS;//( cubeRotation.z - prevcubeRotation.z ) * DEGREES_TO_RADIANS;

			qRotationZ.copyFrom( qAccum );
			qRotationZ.fromAxisAngle( Vector3D.X_AXIS, rotationAngle );
			qAccum.multiply( qAccum, qRotationZ );
			qAccum.normalize();
			prevcubeRotation.z = cubeRotation.z;
			cubeRotation.z = rotationAngle;
		}

		/**
		* YAW = Y
		* 
		*/
		public function SetYaw( angle:Number ):void
		{
			var rotationAngle:Number = angle * DEGREES_TO_RADIANS;//( cubeRotation.y - prevcubeRotation.y ) * DEGREES_TO_RADIANS;

			QRotationY.copyFrom( qAccum );
			QRotationY.fromAxisAngle( Vector3D.Y_AXIS, rotationAngle );
			qAccum.multiply( qAccum, QRotationY );
			qAccum.normalize();
			prevcubeRotation.y = cubeRotation.y;
			cubeRotation.y = rotationAngle;
		}

		/**
		* ROLL = X
		* 
		*/
		public function SetRoll( angle:Number ):void
		{
			var rotationAngle:Number = angle * DEGREES_TO_RADIANS;// ( cubeRotation.x - prevcubeRotation.x ) * DEGREES_TO_RADIANS;
			
			qRotationX.copyFrom( qAccum );
			qRotationX.fromAxisAngle( Vector3D.Z_AXIS, rotationAngle );
			qAccum.multiply( qAccum, qRotationX );
			qAccum.normalize();
			
			prevcubeRotation.x = cubeRotation.x;
			cubeRotation.x = rotationAngle;
		}
		
	}

}