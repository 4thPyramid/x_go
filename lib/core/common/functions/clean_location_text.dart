String cleanText(String text) {
  // Remove Plus Codes (like VXG+CR or similar codes)
  text = text.replaceAll(RegExp(r'^[A-Z0-9+]{4,}[،,\s]*'), '');

  // Remove digits
  text = text.replaceAll(RegExp(r'\d'), '');

  // Split by comma/Arabic comma
  List<String> parts = text.split(RegExp(r'[،,]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  // Remove repeated parts (e.g. "سيدى سالم، سيدى سالم")
  final uniqueParts = <String>{};
  List<String> cleanedParts = [];

  for (var part in parts) {
    if (!uniqueParts.contains(part)) {
      uniqueParts.add(part);
      cleanedParts.add(part);
    }
  }

  return cleanedParts.join(', ');
}
