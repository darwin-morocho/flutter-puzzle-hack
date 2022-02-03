import 'package:flutter/material.dart';
import 'package:my_puzzle/src/inject_dependencies.dart';

import 'src/my_app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await injectDependencies();
  runApp(const MyApp());
}

