// Generated by mason - winkk_brick
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'package_info_provider.g.dart';

@Riverpod(keepAlive: true)
Future<PackageInfo> packageInfo(PackageInfoRef ref) async {
  WidgetsFlutterBinding.ensureInitialized();
  return await PackageInfo.fromPlatform();
}