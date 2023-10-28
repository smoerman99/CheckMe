extension StringExtension on String {
  String makeFirstLetterCapitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

String doSomething() {
  final now = DateTime.now();

  if (now.hour >= 0 && now.hour < 12) {
    return 'Good morning';
  }

  if (now.hour >= 12 && now.hour < 19) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
