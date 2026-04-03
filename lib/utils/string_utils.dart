extension StringUtils on String {
  String get capitalize {
    return split(' ')
        .map((word) {
          return '${word[0].toUpperCase()}${word.substring(1)}';
        })
        .join(' ');
  }
}
