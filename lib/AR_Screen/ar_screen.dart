import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class ArScreen extends StatefulWidget {
  const ArScreen({super.key});

  @override
  State<ArScreen> createState() => _ArScreenState();
}

class _ArScreenState extends State<ArScreen> {
  ArCoreController? _arCoreController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "AR SCREEN",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }

  augmentedRealityViewCreated(ArCoreController arCoreController) {
    _arCoreController = arCoreController;

    displayObject(_arCoreController!);
  }

  displayObject(ArCoreController arCoreController) async {
    final ByteData arImage = await rootBundle.load("assets/earth_map.jpg");

    final materials = ArCoreMaterial(
      color: Colors.blue,
      textureBytes: arImage.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(
      materials: [materials],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );

    _arCoreController!.addArCoreNode(node);
  }
}
