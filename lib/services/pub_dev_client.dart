import 'dart:convert';
import 'dart:io';

/// Fetches package metadata from pub.dev.
class PubDevClient {
  static const _baseUrl = 'https://pub.dev/api/packages';

  /// Returns the latest stable version string for [package].
  /// Throws an [Exception] if the package is not found or the request fails.
  Future<String> latestVersion(String package) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse('$_baseUrl/$package'));
      final response = await request.close();

      if (response.statusCode != HttpStatus.ok) {
        throw Exception(
          'Could not fetch version for "$package" '
          '(HTTP ${response.statusCode})',
        );
      }

      final body = await response.transform(utf8.decoder).join();
      final data = jsonDecode(body) as Map<String, dynamic>;
      return data['latest']['version'] as String;
    } finally {
      client.close();
    }
  }
}
