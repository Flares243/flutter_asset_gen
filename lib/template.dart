import 'package:path/path.dart' as path_library;

class Template {
  Template(this.className);

  final String className;

  String license = '''
/// Generate by [asset_generator](https://github.com/fluttercandies/flutter_asset_generator) library.
/// PLEASE DO NOT EDIT MANUALLY.
// ignore_for_file: constant_identifier_names\n''';

  String get classDeclare => '''
class $className {\n
  const $className._();\n''';

  String get classDeclareFooter => '}\n';

  String formatFiled(String path, String projectPath, bool isPreview) {
    if (isPreview) {
      return '''

  /// ![preview](file://$projectPath${path_library.separator}${_formatPreviewName(path)})
  static const String ${_formatFiledName(path)} = '$path';\n''';
    }
    return '''

  static const String ${_formatFiledName(path)} = '$path';\n''';
  }

  String _formatPreviewName(String path) {
    path = path.replaceAll(' ', '%20').replaceAll('/', path_library.separator);
    return path;
  }

  String _formatFiledName(String path) {
    return toCamelCase(path);
  }

  String toCamelCase(String input) {
    final List<String> words = input.split(RegExp(r'\s+|_+|-+'));

    if (words.isEmpty) {
      return '';
    }

    String camelCaseString = words[0].toLowerCase();

    for (int i = 1; i < words.length; i++) {
      camelCaseString +=
          words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }

    return camelCaseString;
  }

  String toUppercaseFirstLetter(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }
}
