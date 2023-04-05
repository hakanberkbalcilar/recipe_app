typedef RecipeDigestList = List<RecipeDigest>;

abstract class RecipeDigest {
  RecipeDigest({
    required this.label,
    required this.tag,
    required this.schemaOrgTag,
    required this.total,
    required this.hasRDI,
    required this.daily,
    required this.unit,
  });
  final String label;
  final String tag;
  final String? schemaOrgTag;
  final double total;
  final bool hasRDI;
  final double daily;
  final String unit;
}
