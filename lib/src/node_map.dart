part of '../parse_json.dart';

final class _NodeMap<T extends _DecoderNode> {
  final Map<Type, T> _nodes;

  _NodeMap(this._nodes);

  T operator [](Type type) => _nodes[type]!;
  void operator []=(Type type, T node) => _nodes[type] = node;

  _Decoding dynamicDecode(dynamic json) {
    for (final entry in _nodes.entries) {
      try {
        final result = entry.value.decoder(json);
        return _Decoded(entry.value, result);
      } catch (_) {}
    }
    return const _DecoderNotFound();
  }
}
