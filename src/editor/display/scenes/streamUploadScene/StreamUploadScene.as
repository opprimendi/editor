package editor.display.scenes.streamUploadScene 
{
	import away3d.entities.Mesh;
	import away3d.materials.methods.EnvMapMethod;
	import away3d.materials.SkyBoxMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SkyBox;
	import away3d.textures.Anisotropy;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.BitmapTexture;
	import core.commands.AddObject3DCommand;
	import editor.display.scenes.editorScene.EditorScene;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	public class StreamUploadScene extends EditorScene 
	{
		[Embed(source = "../../../../../bin/sample.jpg")]
		private var sampleTextureSoruce:Class;
		
		private var bitmapData:BitmapData = new sampleTextureSoruce().bitmapData;
		
		
		[Embed(source = "../../../../../bin/sky/sky_negX.jpg")]
		private var sky_negX:Class;
		[Embed(source = "../../../../../bin/sky/sky_negY.jpg")]
		private var sky_negY:Class;
		[Embed(source = "../../../../../bin/sky/sky_negZ.jpg")]
		private var sky_negZ:Class;
		[Embed(source = "../../../../../bin/sky/sky_posX.jpg")]
		private var sky_posX:Class;
		[Embed(source = "../../../../../bin/sky/sky_posY.jpg")]
		private var sky_posY:Class;
		[Embed(source = "../../../../../bin/sky/sky_posZ.jpg")]
		private var sky_posZ:Class;
		
		private var skyboxMaterial:SkyBoxMaterial;
		
		
		public function StreamUploadScene(sceneId:int) 
		{
			super(sceneId);
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			var helpText:TextField = new TextField();
			helpText.defaultTextFormat = new TextFormat("FixedSys")
			helpText.text = "Press 1 to add/reset skybox\nPress 2 to add new object to scene";
			helpText.textColor = 0xFFFFFF;
			helpText.autoSize = TextFieldAutoSize.LEFT;
			
			helpText.antiAliasType = "advanced";
			
			helpText.sharpness = -5;
			helpText.thickness = 75;
			
			helpText.gridFitType = "subpixel";
			
			mainSceneView.addChild(helpText);
			
			helpText.y = 100;
				
			keyboardController.registerKeyDownReaction(Keyboard.NUMBER_2, createAddObjectAction);
			keyboardController.registerKeyDownReaction(Keyboard.NUMBER_1, resetSkybox);
		}
		
		private function resetSkybox():void 
		{
			
			
			var skyboxTexture:BitmapCubeTexture = new BitmapCubeTexture(new sky_posX().bitmapData, new sky_negX().bitmapData, new sky_posY().bitmapData,
																		new sky_negY().bitmapData, new sky_posZ().bitmapData, new sky_negZ().bitmapData, true);
			skyboxTexture.isUseStreamingUpload = true;
			skyboxMaterial.cubeMap = skyboxTexture;
			
			if (!skyboxMaterial)
			{
				skyboxMaterial = new SkyBoxMaterial(skyboxTexture);
				var skybox:SkyBox = new SkyBox(skyboxMaterial);
				sceneContext.layerView.addChild3D(skybox);
			}
		}
		
		private function createAddObjectAction():void 
		{
			var addObjectCommand:AddObject3DCommand = new AddObject3DCommand(sceneContext);
			
			var texture:BitmapTexture = new BitmapTexture(bitmapData);
			texture.isUseStreamingUpload = true;
			
			var material:TextureMaterial = new TextureMaterial(texture, true, true, true, Anisotropy.ANISOTROPIC8X);
			
			var object:Mesh = new Mesh(new CubeGeometry(), material);
			
			object.x = -500 + Math.random() * 1000;
			object.y = -50 + Math.random() * 100;
			object.z = -500 + Math.random() * 1000;
			
			addObjectCommand.objectToAdd = object;
			
			addObjectCommand.execute();
			
			commandProcessor.pushCommand(addObjectCommand);
		}
		
	}

}