
// Author URL: http://bikramkawan.com.np
// Email : bikramkawan@gmail.com
// Version: 18.03.2016


			var shipcordx=[];
var shipcordy=[];
var shipcordh=[];
var animationset=false;
			var container, stats,camera, scene, renderer,controls,ship,shipdata,waterNormals;
			var t=0;
			var step = 0;
			var time;
			var Radius=0;
			var timer = Date.now() * 0.01;	
   			var dummydata = [10,0,0,0,  0.2, 0.1, -0.1, 1,   0.35, 0.15,-0.2, 1.5,   0.30, 0.1, -0.15, 2,   0.20, 0.0, -0.05, 0.5];
   			var xcord=[-5.784123,-6.790224,-7.79872,-8.809078,-9.82082,-10.833484,-11.846621,-12.8598,-13.872813];
   			var zcord=[2.861738,4.860663,5.859165,6.85734,7.85527,8.853038,9.850723,10.8484,87.846107];
   			var startposx= [0.322371,418.694];
   			var startposy = [77.0092,773.192];

   			// var stats = initStats();
   			var keyboard = new KeyboardState();
			var parameters = {
							width: 2000,
							height: 2000,
							widthSegments: 250,
							heightSegments: 250,
							depth: 1500,
							param: 4,
							filterparam: 1
						};
			var lon=[];
			var lat =[];			
						

			
	
			
			//collada
				var loader = new THREE.ColladaLoader();
                loader.options.convertUpAxis = true;
                loader.load( 'model/vessel.dae', function ( collada ) {

                    dae = collada.scene;

                    dae.scale.x = dae.scale.y = dae.scale.z = 25;
                    dae.position.y = -8;
                    dae.updateMatrix();
                    ship = dae;

                    scene.add(dae);


                });
                
				
		//end of collada

			//Control For Speed and Movement
			var	controls1 = new function() {
              this.Frequency = 0.001;
              this.Velocity=0.3;
              	
          	}
				
			

			init();
			animate();

			function init() {

				container = document.getElementById('webgloutput');
				
				
				
				//document.getElementById("mycan").appendChild(renderer.domElement);
				



				renderer = new THREE.WebGLRenderer();
				
				renderer.setPixelRatio( window.devicePixelRatio );
				renderer.setSize( screen.width/1.12, screen.height/2);
				//container.appendChild( renderer.domElement );
				
				scene = new THREE.Scene();

				// var axes = new THREE.AxisHelper(1000);
    //     		scene.add(axes);
				camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 0.5, 3000000 );
				camera.position.set(100,0,300);
				camera.rotation.y=Math.PI*0.1;
				camera.rotation.x=Math.PI*0.1;
				//Set Camera
				// camera.position.x = 800;
			 //    camera.position.y = 300;
			 //    camera.position.z = 1300;
			 //    camera.rotation.x=45;
			    //camera.lookAt(scene.position);
			
				controls = new THREE.OrbitControls( camera, renderer.domElement );
				controls.enablePan = false;
				controls.minDistance = 1000.0;
				controls.maxDistance = 5000.0;
				controls.maxPolarAngle = Math.PI * 0.495;
				controls.center.set( 0, 500, 0 );

				scene.add( new THREE.AmbientLight( 0x444444 ) );

				var light = new THREE.DirectionalLight( 0xffffbb, 1 );
				light.position.set( - 1, 1, - 1 );
				scene.add( light );

				//Load Background
				waterNormals = new THREE.ImageUtils.loadTexture( 'Ocean_Textures/waternormals.jpg' );
				waterNormals.wrapS = waterNormals.wrapT = THREE.RepeatWrapping;

				water = new THREE.Water( renderer, camera, scene, {
					textureWidth: 512,
					textureHeight: 512,
					waterNormals: waterNormals,
					alpha: 	1.0,
					sunDirection: light.position.clone().normalize(),
					sunColor: 0xffffff,
					waterColor: 0x001e0f,
					distortionScale: 50.0,
				} );


				mirrorMesh = new THREE.Mesh(
				new THREE.PlaneBufferGeometry( parameters.width * 500, parameters.height * 500 ),
					water.material
				);

				mirrorMesh.add( water );
				mirrorMesh.rotation.x = - Math.PI * 0.5;
				scene.add( mirrorMesh );
				//Trajectory Start

				var numPoints = 50;
				
//end docReady var

//  $.getJSON('Matlab/neuralnetmodel/neuralnetresult.json', function (data) {


        
//       	   cord = data;
      	     
//       	   console.log(cord);
      	   
      	 
      	


// spline = new THREE.CatmullRomCurve3();

// for (var i = 0; i <cord.neuralnetresult.Predicted.length; i++) {
	

// 	spline.points.push(
		
	
// 	new THREE.Vector3( parseFloat(cord.neuralnetresult.Actual[i][0]), 2, parseFloat(cord.neuralnetresult.Actual[i][1])*(-1))

// 	);
// };
		
// 			//console.log(spline);
// 			var material1 = new THREE.LineDashedMaterial({
// 				color: 0x00ccff,linewidth: 5
// 			});
// 						var geometry = new THREE.Geometry();
// 			var splinePoints = spline.getPoints( numPoints );
			
// 			for( var i = 0; i < splinePoints.length; i++ ){
// 				geometry.vertices.push( splinePoints[i] );  
// 			}
			
// 			var line = new THREE.Line( geometry, material1 );
// 			scene.add( line );
			

       

      
//       });//end ajax call
	

				
				// load skybox
		
				var cubeMap = new THREE.CubeTexture( [] );
				cubeMap.format = THREE.RGBFormat;


		var aCubeMap = THREE.ImageUtils.loadTextureCube([
		  'img/px.jpg',
		  'img/nx.jpg',
		  'img/py.jpg',
		  'img/ny.jpg',
		  'img/pz.jpg',
		  'img/nz.jpg'
		]);
		aCubeMap.format = THREE.RGBFormat;
				var cubeShader = THREE.ShaderLib[ 'cube' ];
				cubeShader.uniforms[ 'tCube' ].value = aCubeMap;

				var skyBoxMaterial = new THREE.ShaderMaterial( {
					fragmentShader: cubeShader.fragmentShader,
					vertexShader: cubeShader.vertexShader,
					uniforms: cubeShader.uniforms,
					depthWrite: false,
					side: THREE.BackSide
				} );

				var skyBox = new THREE.Mesh(
					new THREE.BoxGeometry( 1000000, 1000000, 1000000 ),
					skyBoxMaterial
				);

				scene.add( skyBox );


				var geometry = new THREE.IcosahedronGeometry( 400, 4 );

				for ( var i = 0, j = geometry.faces.length; i < j; i ++ ) {

					geometry.faces[ i ].color.setHex( Math.random() * 0xffffff );

				}

				var material = new THREE.MeshPhongMaterial( {
					vertexColors: THREE.FaceColors,
					shininess: 100,
					envMap: cubeMap
				} );

container.appendChild( renderer.domElement );




			}

			//End of init function
			

			function animate() {

				requestAnimationFrame( animate );
		
				render();

				
				
				

			}

 
			
			
//Ajax Request for receiveing data from php


//End Ajax Request for receiveing data from php

var countershipid=0
	
	function render() {

		
			
		//console.log(ship.position.x);
	keyboard.update();


//Print Result of Yaw Pitch and Roll
//document.querySelector('.results').innerHTML = 'Yaw ='+yaw+' '+ 'Pitch= '+pitch+' '+ 'Roll= '+roll;



				water.material.uniforms.time.value += 1.0 / 60.0;
				controls.update();
				water.render();
				renderer.render( scene, camera );

			}

		

// 