extension StringExt on String {
  String capitalize() {
    if (isEmpty) return "";
    return this[0].toUpperCase() + substring(1);
  }

  String toUppercaseFirstLetter() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
