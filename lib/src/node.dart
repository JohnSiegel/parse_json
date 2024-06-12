part of '../parse_json.dart';

sealed class _DecoderNode {
  final dynamic Function(dynamic json) decoder;

  const _DecoderNode(this.decoder) : super();
}

final class _ListNode<T> extends _DecoderNode {
  final _DecoderNode elementDecoder;

  _ListNode(this.elementDecoder)
      : super((json) {
          json as List;
          return json.map(elementDecoder.decoder).cast<T>().toList();
        });
}

final class _MapNode<T> extends _DecoderNode {
  final _DecoderNode valueDecoder;

  _MapNode(this.valueDecoder)
      : super((json) {
          json as Map;
          return json
              .map((key, value) => MapEntry(key, valueDecoder.decoder(value)))
              .cast<String, T>();
        });
}

sealed class _JsonNode extends _DecoderNode {
  const _JsonNode(super.decoder) : super();
}

final class _PrimitiveNode<T> extends _JsonNode {
  _PrimitiveNode() : super((json) => json is T ? json : throw Exception());
}

final class _ObjectNode extends _JsonNode {
  final Function constructor;
  final List<String> keys;
  final Map<String, _DecoderNode> children;

  _ObjectNode(this.constructor, this.keys, this.children)
      : super((json) {
          try {
            return Function.apply(constructor, [], {
              for (var key in {...keys}
                  .intersection({...(json as Map<String, dynamic>).keys}))
                Symbol(key): (() {
                  if (children[key] != null) {
                    return children[key]!.decoder(json[key]);
                  }
                  switch (_dynamicDecodeProperty(json[key])) {
                    case _DecodingError():
                      throw Exception();
                    case _Decoded(node: final node, value: final value):
                      if (node != null) {
                        children[key] = node;
                      }
                      return value;
                  }
                })()
            });
          } catch (_) {
            children.clear();
            rethrow;
          }
        });
}

final class _EnumNode extends _JsonNode {
  const _EnumNode(super.decoder) : super();
}
