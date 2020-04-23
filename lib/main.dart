import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ArCoreController arCoreController;
  var isCatNode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ArCore'),),
      body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
          enableTapRecognizer: true,
        ),
    );
  }
  void onTapHandler(String name) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(content: Text('onNodeTap on $name')),
    );
  }

    void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    arCoreController.onNodeTap = (name) => onTapHandler(name);
    arCoreController.onPlaneDetected = (ArCorePlane plane) => {
      print("Plane detected " + plane.toString())
    };
    arCoreController.onPlaneTap = (List<ArCoreHitTestResult> hits){
    final hit = hits.first;
    final catNode = ArCoreReferenceNode(
        name: "catNode",
        objectUrl: isCatNode ?
            "https://raw.githubusercontent.com/dlather/Spark/0747a334881641c6051a98bf79c2f1a3a2fdbb4d/cat.gltf"
            : "https://raw.githubusercontent.com/dlather/Spark/master/charmender.gltf",
        position: hit.pose.translation,
        rotation: hit.pose.rotation);
    arCoreController.addArCoreNodeWithAnchor(catNode);
    isCatNode = !isCatNode;
    
    // final moonMaterial = ArCoreMaterial(color: Colors.grey);
    
    // final moonShape = ArCoreSphere(
    //   materials: [moonMaterial],
    //   radius: 0.03,
    // );
    
    // final moon = ArCoreNode(
    //   shape: moonShape,
    //   position: vector.Vector3(0.0, 0, 0),
    //   rotation: vector.Vector4(0, 0, 0, 0),
    // );

    // final earthMaterial = ArCoreMaterial(
    //     color: Color.fromARGB(120, 66, 134, 244));
    
    // final earthShape = ArCoreSphere(
    //   materials: [earthMaterial],
    //   radius: 0.1,
    // );
    
    // final earth = ArCoreNode(
    //     shape: earthShape,
    //     children: [moon],
    //     position: hit.pose.translation + vector.Vector3(0.0, 0.0, 0.0),
    //     rotation: hit.pose.rotation);

    // arCoreController.addArCoreNodeWithAnchor(earth);
    };

    // _addSphere(arCoreController);
    // _addCylindre(arCoreController);
    // _addCube(arCoreController);
  }

  // void _addSphere(ArCoreController controller) {
  //   final material = ArCoreMaterial(
  //       color: Color.fromARGB(120, 66, 134, 244));
  //   final sphere = ArCoreSphere(
  //     materials: [material],
  //     radius: 0.1,
  //   );
  //   final node = ArCoreNode(
  //     shape: sphere,
  //     position: vector.Vector3(0, 0, -1.5),
  //   );
  //   controller.addArCoreNodeWithAnchor(node);
  // }

  // void _addCylindre(ArCoreController controller) {
  //   final material = ArCoreMaterial(
  //     color: Colors.red,
  //     reflectance: 1.0,
  //   );
  //   final cylindre = ArCoreCylinder(
  //     materials: [material],
  //     radius: 0.5,
  //     height: 0.3,
  //   );
  //   final node = ArCoreNode(
  //     shape: cylindre,
  //     position: vector.Vector3(0.0, -0.5, -2.0),
  //   );
  //   controller.addArCoreNode(node);
  // }

  // void _addCube(ArCoreController controller) {
  //   final material = ArCoreMaterial(
  //     color: Color.fromARGB(120, 66, 134, 244),
  //     metallic: 1.0,
  //   );
  //   final cube = ArCoreCube(
  //     materials: [material],
  //     size: vector.Vector3(0.5, 0.5, 0.5),
  //   );
  //   final node = ArCoreNode(
  //     shape: cube,
  //     position: vector.Vector3(-0.5, 0.5, -3.5),
  //   );
  //   controller.addArCoreNode(node);
  // }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}


