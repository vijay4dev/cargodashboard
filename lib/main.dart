import 'package:cargodashboard/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
      final width = MediaQuery.of(context).size.width;

  // Example: only allow app to work if width >= 600 (typical tablet)
  if (width < 600) {
    return Center(
      child: Text('This app is designed for tablet devices.'),
    );
  }

  return MaterialApp(
      title: 'Flutter Demo',
      home: WarehouseScreen(),
    );
  }
}
