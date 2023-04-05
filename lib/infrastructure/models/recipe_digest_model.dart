import 'package:recipe_app/domain/entities/recipe_digest.dart';

class RecipeDigestModel extends RecipeDigest {
  RecipeDigestModel({
    required super.label,
    required super.tag,
    required super.schemaOrgTag,
    required super.total,
    required super.hasRDI,
    required super.daily,
    required super.unit,
  });

  factory RecipeDigestModel.fromJson(Map<String, dynamic> json) => RecipeDigestModel(
        label: json['label'] as String,
        tag: json['tag'] as String,
        schemaOrgTag: json['schemaOrgTag'] as String?,
        total: (json['total'] as num).toDouble(),
        hasRDI: json['hasRDI'] as bool,
        daily: (json['daily'] as num).toDouble(),
        unit: json['unit'] as String,
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'tag': tag,
        'schemaOrgTag': schemaOrgTag,
        'total': total,
        'hasRDI': hasRDI,
        'daily': daily,
        'unit': unit,
      };
}
