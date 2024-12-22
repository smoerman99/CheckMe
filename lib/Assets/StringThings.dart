extension StringExtension on String {
  String makeFirstLetterCapitalize() {
    if (this.isEmpty) return this; // Handle empty string case
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

String stripHtmlIfNeeded(String text) {
  return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;|\d+|¶'), ' ');
}

String getGreeting() {
  final now = DateTime.now();

  if (now.hour >= 0 && now.hour < 12) {
    return 'Good Morning';
  }

  if (now.hour >= 12 && now.hour < 19) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}
