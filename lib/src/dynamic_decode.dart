part of '../parse_json.dart';

sealed class _Decoding {
  const _Decoding();
}

final class _Decoded extends _Decoding {
  final _DecoderNode? node;
  final dynamic value;

  const _Decoded(this.node, this.value);
}

final class _DecoderNotFound extends _Decoding {
  const _DecoderNotFound();
}

_Decoding _dynamicDecode(dynamic json, List<_NodeMap> nodeMaps) {
  for (final nodeMap in nodeMaps) {
    final result = nodeMap.dynamicDecode(json);
    if (result is _Decoded) {
      return result;
    }
  }
  return const _DecoderNotFound();
}

_Decoding _dynamicDecodeProperty(dynamic json) => switch (json) {
      null => _Decoded(null, null),
      num() || bool() || String() => switch (_enumNodes.dynamicDecode(json)) {
          _Decoded(node: final node, value: final value) =>
            _Decoded(node, value),
          _DecoderNotFound() => _Decoded(null, json),
        },
      List<dynamic>() => _dynamicDecode(json, [
          _listEnumNodes,
          _primitiveListNodes,
          _nestedEnumListNodesDepthOne,
          _nestedListNodesDepthOne,
          _nestedEnumListNodesDepthTwo,
          _nestedListNodesDepthTwo
        ]),
      Map<String, dynamic>() => _dynamicDecode(json, [
          _objectNodes,
          _mapEnumNodes,
          _primitiveMapNodes,
          _nestedEnumMapNodesDepthOne,
          _nestedMapNodesDepthOne,
          _nestedEnumMapNodesDepthTwo,
          _nestedMapNodesDepthTwo,
        ]),
      _ => const _DecoderNotFound(),
    };
