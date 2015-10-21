package core.display.scenes.testFeatureScene 
{
	import away3d.animators.data.JointPose;
	import away3d.animators.ParticleAnimator;
	import away3d.animators.ParticleGroupAnimator;
	import away3d.animators.SkeletonAnimator;
	import away3d.animators.states.ISkeletonAnimationState;
	import away3d.animators.states.SkeletonClipState;
	import away3d.animators.utils.SkeletonUtils;
	import away3d.containers.ObjectContainer3D;
	import away3d.core.math.Quaternion;
	import away3d.debug.Trident;
	import away3d.entities.Mesh;
	import away3d.entities.ParticleGroup;
	import away3d.events.AssetEvent;
	import away3d.events.LoaderEvent;
	import away3d.loaders.Loader3D;
	import away3d.loaders.misc.SingleFileLoader;
	import away3d.loaders.parsers.OBJParser;
	import away3d.loaders.parsers.Parsers;
	import away3d.loaders.parsers.ParticleAnimationParser;
	import away3d.loaders.parsers.ParticleGroupParser;
	import away3d.materials.ColorMaterial;
	import away3d.materials.SkyBoxMaterial;
	import away3d.materials.TextureMaterial;
	import away3d.primitives.CubeGeometry;
	import away3d.primitives.SkyBox;
	import away3d.primitives.SphereGeometry;
	import away3d.textures.Anisotropy;
	import away3d.textures.BitmapCubeTexture;
	import away3d.textures.BitmapTexture;
	import core.commands.AddObjectCommand;
	import core.display.scenes.mainScene.MainScene;
	import core.WorldStep;
	import flash.display.Loader;
	import flash.geom.Vector3D;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	public class TestFeatureScene extends MainScene 
	{
		[Embed(source = "../../../../../bin/sample.jpg")]
		private var sampleTextureSoruce:Class;
		private var material:TextureMaterial;
		
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
		
		[Embed(source = "../../../../../bin/Magoth.jpg")]
		private var modelTextureSource:Class;
		
		
		
		public function TestFeatureScene(sceneId:int) 
		{
			super(sceneId);
			
			helpText = new TextField();
			helpText.defaultTextFormat = new TextFormat("FixedSys")
			helpText.text = "Use 1 to change anisotropy level\nUse 2 to bia +1 and 3 to bias -1\nUse space to switch smooth\n";
			helpText.text += "UP/DOWN to change animation\nLEFT/RIGHT to +/- playback speed";
			
			helpText.textColor = 0xFFFFFF;
			helpText.autoSize = TextFieldAutoSize.LEFT;
			
			helpText.antiAliasType = "advanced";
			
			helpText.sharpness = -5;
			helpText.thickness = 75;
			
			helpText.gridFitType = "subpixel";
			
			
			
			helpText.y = 100;
		}
		
		private var ccc:int = 0;
		
		private var markers:Array = [];
		override public function update(worldStep:WorldStep = null):void 
		{
			super.update(worldStep);
			
			if (skeletonAnimator)
			{
				if (skeletonAnimator.globalPose.jointPoses.length < 1)
					return;
					
				for (var i:int = 0; i < skeletonAnimator.globalPose.jointPoses.length; i++)
				{
					var pose:JointPose = skeletonAnimator.globalPose.jointPoses[i];
					var pos:Vector3D = pose.translation;
					var rotation:Quaternion = pose.orientation;
					
					pos = pos.clone();
					
					if (markers.length - 1 < i)
					{
						var marker:ObjectContainer3D = new ObjectContainer3D();// Mesh = new Mesh(new SphereGeometry(0.15));
						markers.push(marker);
						mesh.addChild(marker);
						
						var trident:Trident = new Trident();
						trident.scale(0.001);
						//marker.addChild(trident);
					}
					
					markers[i].transform = pose.toMatrix3D(markers[i].transform);
				}
			}
			
		
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			mainSceneView.addChild(helpText);
			
			Parsers.enableAllBundled();
			SingleFileLoader.enableParsers(new <Class>[ParticleAnimationParser, ParticleGroupParser]);
			
			effectLoader = new Loader3D();
			
			effectLoader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onEffectLoaded);
			
			var loader:Loader3D = new Loader3D();
			loader.load(new URLRequest("./Magoth.awd"));
			loader.addEventListener(AssetEvent.MESH_COMPLETE, onMeshComplete);
			loader.addEventListener(LoaderEvent.RESOURCE_COMPLETE, onMeshLoadFullyComplete);
			
			loader.scaleX = loader.scaleY = loader.scaleZ = 100;
			
			sceneContext.layerView.addChild3D(loader);
			
			
			var texture:BitmapTexture = new BitmapTexture(new sampleTextureSoruce().bitmapData);
			texture.isUseStreamingUpload = true;
			
			material = new TextureMaterial(texture, true, true, true, Anisotropy.NONE);
			
			for (var i:int = 0; i < 5; i++)
				createAddObjectAction();
				
			
			
			
			var skyboxTexture:BitmapCubeTexture = new BitmapCubeTexture(new sky_posX().bitmapData, new sky_negX().bitmapData, new sky_posY().bitmapData,
																		new sky_negY().bitmapData, new sky_posZ().bitmapData, new sky_negZ().bitmapData);
			skyboxMaterial = new SkyBoxMaterial(skyboxTexture);
			
			var skybox:SkyBox = new SkyBox(skyboxMaterial);
			sceneContext.layerView.addChild3D(skybox);
		}
		
		private var animi:int = 0;
		private var anims:Array = ['stun', 'ability1', 'ability2', 'ability3', 'ability4', 'idle1', 'idle2', 'idle3', 'idle4', 'attack', 'attack2', 'walk', 'die']
		private function decSpeed():void 
		{
			skeletonAnimator.playbackSpeed -= 0.1
			helpText.text = "Use 1 to change anisotropy level\nUse 2 to bia +1 and 3 to bias -1\nUse space to switch smooth\n";
			helpText.text += "UP/DOWN to change animation\nLEFT/RIGHT to +/- playback speed\n";
			helpText.text += "current animation: " + anims[animi] + ', ' + 'anim speed: ' + (skeletonAnimator.playbackSpeed).toFixed(1);
		}
		
		private function addSpeed():void 
		{
			skeletonAnimator.playbackSpeed += 0.1
			helpText.text = "Use 1 to change anisotropy level\nUse 2 to bia +1 and 3 to bias -1\nUse space to switch smooth\n";
			helpText.text += "UP/DOWN to change animation\nLEFT/RIGHT to +/- playback speed\n";
			helpText.text += "current animation: " + anims[animi] + ', ' + 'anim speed: ' + (skeletonAnimator.playbackSpeed).toFixed(1);
		}
		
		private function changeAnim2():void 
		{
			animi--;
			
			if (animi == -1)
				animi = anims.length - 1;
			
			skeletonAnimator.play(anims[animi]);
			
				
			helpText.text = "Use 1 to change anisotropy level\nUse 2 to bia +1 and 3 to bias -1\nUse space to switch smooth\n";
			helpText.text += "UP/DOWN to change animation\nLEFT/RIGHT to +/- playback speed\n";
			helpText.text += "current animation: " + anims[animi] + ', ' + 'anim speed: ' + (skeletonAnimator.playbackSpeed).toFixed(1);
		}
		
		private function changeAnim():void 
		{
			animi++;
			
			if (animi == anims.length - 1)
				animi = 0;
				
			skeletonAnimator.play(anims[animi]);
			
			
				
			helpText.text = "Use 1 to change anisotropy level\nUse 2 to bia +1 and 3 to bias -1\nUse space to switch smooth\n";
			helpText.text += "UP/DOWN to change animation\nLEFT/RIGHT to +/- playback speed\n";
			helpText.text += "current animation: " + anims[animi] + ', ' + 'anim speed: ' + (skeletonAnimator.playbackSpeed).toFixed(1);
		}
		
		private function onEffectLoaded(e:LoaderEvent):void 
		{
			markers[7].addChild(effectLoader);
			effectLoader.rotationY = 180;
			effectLoader.scaleX = effectLoader.scaleY = effectLoader.scaleZ = 1 / 180;
			//sceneContext.layerView.addChild3D(effectLoader);
			(effectLoader.getChildAt(0) as ParticleGroup).animator.start();
			
			
		}
		
		private function onMeshLoadFullyComplete(e:LoaderEvent):void 
		{
			skeletonAnimator = mesh.animator as SkeletonAnimator
			skeletonAnimator.play(anims[animi]);
			skeletonAnimator.playbackSpeed = 1;
			
			helpText.text = "Use 1 to change anisotropy level\nUse 2 to bia +1 and 3 to bias -1\nUse space to switch smooth\n";
			helpText.text += "UP/DOWN to change animation\nLEFT/RIGHT to +/- playback speed\n";
			helpText.text += "current animation: " + anims[animi] + ', ' + 'anim speed: ' + (skeletonAnimator.playbackSpeed).toFixed(1);
			
			effectLoader.load(new URLRequest("effect/Legionnaire.weapon.awp"));
			
			keyboardController.registerKeyDownReaction(Keyboard.NUMBER_1, changeAnisotropy);
			keyboardController.registerKeyDownReaction(Keyboard.NUMBER_2, biasAdd);
			keyboardController.registerKeyDownReaction(Keyboard.NUMBER_3, biasSub);
			keyboardController.registerKeyDownReaction(Keyboard.SPACE, changeSmooth);
			keyboardController.registerKeyDownReaction(Keyboard.UP, changeAnim);
			keyboardController.registerKeyDownReaction(Keyboard.DOWN, changeAnim2);
			keyboardController.registerKeyDownReaction(Keyboard.RIGHT, addSpeed);
			keyboardController.registerKeyDownReaction(Keyboard.LEFT, decSpeed);
		}
		
		private function onMeshComplete(e:AssetEvent):void 
		{
			mesh = e.asset as Mesh;
			
			var texture:BitmapTexture = new BitmapTexture(new modelTextureSource().bitmapData);
			texture.isUseStreamingUpload = true;
			
			meshMaterial = new TextureMaterial(texture, true, true, true, Anisotropy.NONE);
			
			
			mesh.material = meshMaterial;
		}
		
		private function changeSmooth():void
		{
			ccc++;
			skyboxMaterial.smooth = !skyboxMaterial.smooth;
			material.smooth = !material.smooth;
			meshMaterial.smooth = !meshMaterial.smooth;
		}
		
		private function biasSub():void
		{
			material.bias--;
			skyboxMaterial.bias--;
			meshMaterial.bias--;
		}
		
		private function biasAdd():void
		{
			material.bias++;
			skyboxMaterial.bias++;
			meshMaterial.bias++;
		}
		
		private var aniso:int = 0;
		private var meshMaterial:TextureMaterial;
		private var mesh:Mesh;
		private var skeletonAnimator:SkeletonAnimator;
		private var marker:Mesh;
		private var effectLoader:Loader3D;
		private var helpText:TextField;
		private function changeAnisotropy():void 
		{
			aniso++;
			
			if (aniso > 4)
				aniso = 0;
			
			material.anisotropy = aniso;
			skyboxMaterial.anisotropy = aniso;
			meshMaterial.anisotropy = aniso;
			//trace("asniso", aniso);
			
			
		}
		
		private function createAddObjectAction():void 
		{
			var addObjectCommand:AddObjectCommand = new AddObjectCommand(sceneContext);
			
			
			
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