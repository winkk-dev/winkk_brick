import 'dart:io';
import 'package:mason/mason.dart';
import 'package:yaml_edit/yaml_edit.dart';

Future<void> run(HookContext context) async {
  // Inner function for adding packages at once
  Future<void> addPackages(List<String> packages, {bool dev = false}) async {
    final args = ['pub', 'add'];
    if (dev) {
      args.add('--dev');
    }
    args.addAll(packages);

    final result = await Process.run('flutter', args);

    if (result.exitCode != 0) {
      context.logger.err('Error adding packages: ${result.stderr}');
    } else {
      context.logger.info('Successfully added packages to ${dev ? 'dev_dependencies' : 'dependencies'}');
    }
  }

  // Modify pubspec
  var progress = context.logger.progress('Updating config from pubspec.yaml');
  try {
    final pubspecFile = File('pubspec.yaml');

    if (!pubspecFile.existsSync()) {
      progress.fail('pubspec.yaml not found');
      return;
    }

    // Load the content of the pubspec.yaml file
    final yamlEditor = YamlEditor(pubspecFile.readAsStringSync());
    yamlEditor.update(['flutter'], {
      'generate': true, 
      'uses-material-design': true,
      'assets': ['assets/img/', 'assets/img/launch/'],
    });
    
    // Save the updated pubspec.yaml
    pubspecFile.writeAsStringSync(yamlEditor.toString());
    progress.complete();
    context.logger.info('pubspec.yaml updated successfully.');
  } catch (e) {
    progress.fail('Failed to update pubspec.yaml: $e');
  }

  // Add packages
  progress = context.logger.progress('Installing packages');
  try {
    await Process.run('flutter', ['pub', 'get']);

    await addPackages([
      // General packages
      'logger',
      'dio',
      'native_dio_adapter',
      'freezed_annotation',
      'json_annotation',
      'reactive_forms',
      'flutter_animate',
      'confetti',
      'share_plus',
      'url_launcher',
      'skeletonizer',
      // Sentry packages
      'sentry_flutter',
      'sentry_dio',
      if (context.vars['inAppWebView'] == true) 'flutter_inappwebview',
      // Riverpod packages
      'flutter_hooks',
      'hooks_riverpod',
      'riverpod_annotation',
      // Navigation packages
      'go_router',
      // Storage packages
      'shared_preferences',
      // UI and image packages, layout
      'cached_network_image',
      'flutter_svg',
      'photo_view',
      'responsive_framework',
      // Localization packages
      'intl',
      'flutter_localization',
      // Metadata
      'device_info_plus',
      'package_info_plus',
      'universal_platform',
      // Init and splash screen
      'flutter_native_splash',
    ]);

    // Dev dependencies
    await addPackages([
      'build_runner',
      'freezed',
      'json_serializable',
      'flutter_lints',
      'riverpod_generator',
      'riverpod_lint',
      'flutter_launcher_icons',
      'sentry_dart_plugin',
      'go_router_builder',
    ], dev: true);

    progress.complete();
  } catch (e) {
    progress.fail('Failed to install some packages');
  }

  progress = context.logger.progress('Creating icons and splash screen');
  try {
    final splashResult = await Process.run('flutter', ['pub', 'run', 'flutter_native_splash:create']);
    if (splashResult.exitCode != 0) {
      progress.fail('Failed to create splash screen: ${splashResult.stderr}');
      return;
    }

    final iconsResult = await Process.run('flutter', ['pub', 'run', 'flutter_launcher_icons']);
    if (iconsResult.exitCode != 0) {
      progress.fail('Failed to create icons: ${iconsResult.stderr}');
      return;
    }

    progress.complete();
    context.logger.info('Icons and Splash Screen created successfully.');
  } catch (e) {
    progress.fail('Failed to create icons: $e');
  }

  progress = context.logger.progress('Running build_runner');
  try {
    final result = await Process.run('dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);

    if (result.exitCode != 0) {
      progress.fail('Failed to run build_runner: ${result.exitCode}: "${result.stdout}" & "${result.stderr}"');
    } else {
      progress.complete();
      context.logger.info('build_runner completed successfully.');
    }
  } catch (e) {
    progress.fail('Failed to run build_runner: $e');
  }
}