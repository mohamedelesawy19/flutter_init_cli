import 'dart:io';

import 'package:path/path.dart' as p;

import 'logger.dart';

class FileWriter {
  // Writes [content] to [filePath].
  //
  // Parent directories are created automatically.
  // Skips silently when the file already exists and [overwrite] is false.
  static Future<void> write(
    String filePath,
    String content, {
    bool overwrite = false,
  }) async {
    final file = File(filePath);

    if (file.existsSync() && !overwrite) {
      Logger.info('skip (exists): ${_short(filePath)}');
      return;
    }

    await file.parent.create(recursive: true);
    await file.writeAsString(content);
    Logger.success(_short(filePath));
  }

  static Future<void> createDir(String dirPath) async {
    final dir = Directory(dirPath);
    if (!dir.existsSync()) await dir.create(recursive: true);
  }

  // Show path starting from lib/ for a cleaner log.
  static String _short(String filePath) {
    final parts = p.split(filePath);
    final libIdx = parts.lastIndexOf('lib');
    if (libIdx != -1) return parts.sublist(libIdx).join('/');
    return p.basename(filePath);
  }
}
