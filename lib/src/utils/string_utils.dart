extension StringFunctions on String? {
  bool get hasValue => this != null && this!.replaceAll(" ", "").replaceAll("\n", "").isNotEmpty;}
