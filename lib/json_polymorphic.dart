import 'json.dart';

/// Reserved key for polymorphic types.
const kPolymorphicTypeJsonKey = '__poly__';

/// A polymorphic parser for [Json] objects.
abstract class JsonPolymorphic<T extends JsonPolymorphic<T>> extends Json {
  JsonPolymorphic() : super();

  JsonPolymorphic.parse(super.json) : super.parse();

  /// The type specifier for this polymorphic object. This is used to determine
  /// the type of the object when parsing.
  String get type;

  /// Parse a json map while maintaining polymorphic types.
  static T polymorphicParse<T extends JsonPolymorphic<T>>(
      Map<String, dynamic> json, List<T Function()> parsers) {
    final type = json[kPolymorphicTypeJsonKey];
    if (type != null) {
      return parsers.firstWhere((element) => element().type == type,
          orElse: () => throw FormatException(
              'Polymorphic type "$type" is not included for this key.', json))()
        ..parse(json);
    } else {
      throw FormatException(
        'Polymorphic type key "$kPolymorphicTypeJsonKey" is required.',
        json,
      );
    }
  }

  @override
  Map<String, dynamic> toJson() => super.toJson()
    ..update(
      kPolymorphicTypeJsonKey,
      (val) => throw ArgumentError(
          'Polymorphic type key "$kPolymorphicTypeJsonKey" is reserved. You'
          'have set this key with value: $val.'),
      ifAbsent: () => type,
    );
}

/// A [JsonKey] that parses a [JsonPolymorphic] object.
final class JsonPolymorphicKey<T extends JsonPolymorphic<T>>
    extends JsonKey<T, Map<String, dynamic>> {
  JsonPolymorphicKey.parser(String key, List<T Function()> parsers)
      : super.parser(
            key, (json) => JsonPolymorphic.polymorphicParse(json, parsers));

  JsonPolymorphicKey.populated(super.key, super.val) : super.populated();

  @override
  Map<String, dynamic> serialize(T value) => value.toJson();
}

/// A [JsonKey] that parses an optional [JsonPolymorphic] object.
final class JsonOptionalPolymorphicKey<T extends JsonPolymorphic<T>>
    extends JsonKey<T?, Map<String, dynamic>?> {
  JsonOptionalPolymorphicKey.parser(String key, List<T Function()> parsers)
      : super.parser(
            key,
            (json) => json != null
                ? JsonPolymorphic.polymorphicParse(json, parsers)
                : null);

  JsonOptionalPolymorphicKey.populated(super.key, super.val)
      : super.populated();

  @override
  Map<String, dynamic>? serialize(T? value) => value?.toJson();
}
