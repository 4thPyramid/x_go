String cleanText(String text) {
  // Remove Plus Codes (like VXG+CR or similar codes, including + signs)
  text = text.replaceAll(RegExp(r'\b[A-Z0-9]{4,}\+?[A-Z0-9]{2,}\b'), '');

  // Remove digits (both English and Arabic)
  text = text.replaceAll(RegExp(r'\d'), '');

  // Clean up some common symbols or unwanted characters (optional, for more specific cleaning)
  text = text.replaceAll(RegExp(r'[^A-Za-z0-9\s,،]+'), '');

  // Split by comma/Arabic comma and also handle spaces around the commas
  List<String> parts = text
      .split(RegExp(r'[،,]'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();

  // Remove repeated parts (e.g. "سيدى سالم، سيدى سالم" or "New York, New York")
  final uniqueParts = <String>{};
  List<String> cleanedParts = [];

  for (var part in parts) {
    if (!uniqueParts.contains(part)) {
      uniqueParts.add(part);
      cleanedParts.add(part);
    }
  }

  // Join cleaned parts with English commas
  return cleanedParts.join(', ');
}
