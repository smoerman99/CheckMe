extension StringExtension on String {
  String makeFirstLetterCapitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
