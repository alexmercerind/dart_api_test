// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:io';
import 'dart:ffi';
import 'package:flutter/material.dart';

const lib = 'dart_api_test';

void main() {
  runApp(const MyApp());
}

class Isolate extends Opaque {}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final dylib = () {
      if (Platform.isMacOS || Platform.isIOS) {
        return DynamicLibrary.open('$lib.framework/$lib');
      }
      if (Platform.isAndroid || Platform.isLinux) {
        return DynamicLibrary.open('lib$lib.so');
      }
      if (Platform.isWindows) {
        return DynamicLibrary.open('$lib.dll');
      }
      throw UnsupportedError('Unknown platform: ${Platform.operatingSystem}');
    }();

    final Dart_InitializeApiDL = dylib.lookupFunction<
        Int32 Function(Pointer<Void>), int Function(Pointer<Void>)>(
      'Dart_InitializeApiDL',
    );
    final Dart_CurrentIsolate_DL = dylib.lookupFunction<
        Pointer<Isolate> Function(), Pointer<Isolate> Function()>(
      'Dart_CurrentIsolate_DL',
    );
    final Dart_EnterIsolate_DL = dylib.lookupFunction<
        Int32 Function(Pointer<Isolate>), int Function(Pointer<Isolate>)>(
      'Dart_EnterIsolate_DL',
    );
    final Dart_ExitIsolate_DL =
        dylib.lookupFunction<Int32 Function(), int Function()>(
      'Dart_ExitIsolate_DL',
    );

    Dart_InitializeApiDL(NativeApi.initializeApiDLData);
    Dart_CurrentIsolate_DL();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Native Packages'),
        ),
        body: const Center(),
      ),
    );
  }
}
