package core.fileSystem.data 
{

	public class MaterialData 
	{
		public var type:int;
		
		public var smooth:Boolean;
		public var repeat:Boolean;
		public var useMipMaps:Boolean;
		public var animateUVs:Boolean;
		public var alpha:Boolean;
		
		public var anisotropy:int;
		
		public var alphaThreshold:Number;
		
		public var blendMode:String;
		
		public var diffuseTeturePath:String;
		public var normalTexturePath:String;
		public var ambientTexturePath:String;
		public var specularTeturePath:String;
		public var glossTexturePath:String;
		
		public function MaterialData() 
		{
			
		}
		
	}

}