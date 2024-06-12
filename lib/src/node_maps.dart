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
    return const _DecodingError();
  }
}

final _enumNodes = _NodeMap<_EnumNode>({});

_ListNode<T> _listNode<T>(_DecoderNode decoder) => _ListNode(decoder);

_MapNode<T> _mapNode<T>(_DecoderNode decoder) => _MapNode(decoder);

MapEntry<Type, _ListNode<T>> _listNodeEntry<T>(_DecoderNode decoder) =>
    MapEntry(T, _listNode(decoder));

MapEntry<Type, _MapNode<T>> _mapNodeEntry<T>(_DecoderNode decoder) =>
    MapEntry(T, _mapNode(decoder));

final _listEnumNodes = _NodeMap<_ListNode<dynamic>>({});

final _NodeMap<_ListNode<dynamic>> _listNodes =
    _NodeMap<_ListNode<dynamic>>(Map.fromEntries([
  _listNodeEntry<int>(_PrimitiveNode<int>()),
  _listNodeEntry<double>(_PrimitiveNode<double>()),
  _listNodeEntry<bool>(_PrimitiveNode<bool>()),
  _listNodeEntry<String>(_PrimitiveNode<String>()),
]));

final _mapEnumNodes = _NodeMap<_MapNode<dynamic>>({});

final _mapNodes = _NodeMap<_MapNode<dynamic>>(Map.fromEntries([
  _mapNodeEntry<int>(_PrimitiveNode<int>()),
  _mapNodeEntry<double>(_PrimitiveNode<double>()),
  _mapNodeEntry<bool>(_PrimitiveNode<bool>()),
  _mapNodeEntry<String>(_PrimitiveNode<String>()),
]));

final _nestedEnumListNodesDepthOne = _NodeMap<_ListNode<dynamic>>({});

final _nestedListNodesDepthOne = _NodeMap<_ListNode<dynamic>>(Map.fromEntries([
  _listNodeEntry<List<int>>(_listNodes[int]),
  _listNodeEntry<List<double>>(_listNodes[double]),
  _listNodeEntry<List<String>>(_listNodes[String]),
  _listNodeEntry<List<bool>>(_listNodes[bool]),
  _listNodeEntry<Map<String, int>>(_mapNodes[int]),
  _listNodeEntry<Map<String, double>>(_mapNodes[double]),
  _listNodeEntry<Map<String, String>>(_mapNodes[String]),
  _listNodeEntry<Map<String, bool>>(_mapNodes[bool]),
]));

final _nestedEnumMapNodesDepthOne = _NodeMap<_MapNode<dynamic>>({});

final _nestedMapNodesDepthOne = _NodeMap<_MapNode<dynamic>>(Map.fromEntries([
  _mapNodeEntry<List<int>>(_listNodes[int]),
  _mapNodeEntry<List<double>>(_listNodes[double]),
  _mapNodeEntry<List<String>>(_listNodes[String]),
  _mapNodeEntry<List<bool>>(_listNodes[bool]),
  _mapNodeEntry<Map<String, int>>(_mapNodes[int]),
  _mapNodeEntry<Map<String, double>>(_mapNodes[double]),
  _mapNodeEntry<Map<String, String>>(_mapNodes[String]),
  _mapNodeEntry<Map<String, bool>>(_mapNodes[bool]),
]));

final _nestedEnumListNodesDepthTwo = _NodeMap<_ListNode<dynamic>>({});

final _nestedListNodesDepthTwo = _NodeMap<_ListNode<dynamic>>(Map.fromEntries([
  _listNodeEntry<List<List<int>>>(_nestedListNodesDepthOne[List<int>]),
  _listNodeEntry<List<List<double>>>(_nestedListNodesDepthOne[List<double>]),
  _listNodeEntry<List<List<String>>>(_nestedListNodesDepthOne[List<String>]),
  _listNodeEntry<List<List<bool>>>(_nestedListNodesDepthOne[List<bool>]),
  _listNodeEntry<List<Map<String, int>>>(
      _nestedListNodesDepthOne[Map<String, int>]),
  _listNodeEntry<List<Map<String, double>>>(
      _nestedListNodesDepthOne[Map<String, double>]),
  _listNodeEntry<List<Map<String, String>>>(
      _nestedListNodesDepthOne[Map<String, String>]),
  _listNodeEntry<List<Map<String, bool>>>(
      _nestedListNodesDepthOne[Map<String, bool>]),
  _listNodeEntry<Map<String, List<int>>>(_nestedMapNodesDepthOne[List<int>]),
  _listNodeEntry<Map<String, List<double>>>(
      _nestedMapNodesDepthOne[List<double>]),
  _listNodeEntry<Map<String, List<String>>>(
      _nestedMapNodesDepthOne[List<String>]),
  _listNodeEntry<Map<String, List<bool>>>(_nestedMapNodesDepthOne[List<bool>]),
  _listNodeEntry<Map<String, Map<String, int>>>(
      _nestedMapNodesDepthOne[Map<String, int>]),
  _listNodeEntry<Map<String, Map<String, double>>>(
      _nestedMapNodesDepthOne[Map<String, double>]),
  _listNodeEntry<Map<String, Map<String, String>>>(
      _nestedMapNodesDepthOne[Map<String, String>]),
  _listNodeEntry<Map<String, Map<String, bool>>>(
      _nestedMapNodesDepthOne[Map<String, bool>]),
]));

final _nestedEnumMapNodesDepthTwo = _NodeMap<_MapNode<dynamic>>({});

final _nestedMapNodesDepthTwo = _NodeMap<_MapNode<dynamic>>(Map.fromEntries([
  _mapNodeEntry<List<List<int>>>(_nestedListNodesDepthOne[List<int>]),
  _mapNodeEntry<List<List<double>>>(_nestedListNodesDepthOne[List<double>]),
  _mapNodeEntry<List<List<String>>>(_nestedListNodesDepthOne[List<String>]),
  _mapNodeEntry<List<List<bool>>>(_nestedListNodesDepthOne[List<bool>]),
  _mapNodeEntry<List<Map<String, int>>>(
      _nestedListNodesDepthOne[Map<String, int>]),
  _mapNodeEntry<List<Map<String, double>>>(
      _nestedListNodesDepthOne[Map<String, double>]),
  _mapNodeEntry<List<Map<String, String>>>(
      _nestedListNodesDepthOne[Map<String, String>]),
  _mapNodeEntry<List<Map<String, bool>>>(
      _nestedListNodesDepthOne[Map<String, bool>]),
  _mapNodeEntry<Map<String, List<int>>>(_nestedMapNodesDepthOne[List<int>]),
  _mapNodeEntry<Map<String, List<double>>>(
      _nestedMapNodesDepthOne[List<double>]),
  _mapNodeEntry<Map<String, List<String>>>(
      _nestedMapNodesDepthOne[List<String>]),
  _mapNodeEntry<Map<String, List<bool>>>(_nestedMapNodesDepthOne[List<bool>]),
  _mapNodeEntry<Map<String, Map<String, int>>>(
      _nestedMapNodesDepthOne[Map<String, int>]),
  _mapNodeEntry<Map<String, Map<String, double>>>(
      _nestedMapNodesDepthOne[Map<String, double>]),
  _mapNodeEntry<Map<String, Map<String, String>>>(
      _nestedMapNodesDepthOne[Map<String, String>]),
  _mapNodeEntry<Map<String, Map<String, bool>>>(
      _nestedMapNodesDepthOne[Map<String, bool>]),
]));

final _objectNodes = _NodeMap<_ObjectNode>({});

void registerEnum<T>(dynamic Function(dynamic) constructor) {
  _enumNodes[T] = _EnumNode(constructor);

  _listEnumNodes[T] = _listNode<T>(_enumNodes[T]);
  _mapEnumNodes[T] = _mapNode<T>(_enumNodes[T]);

  _nestedEnumListNodesDepthOne[List<T>] = _listNode<List<T>>(_listEnumNodes[T]);
  _nestedEnumListNodesDepthOne[Map<String, T>] =
      _listNode<Map<String, T>>(_mapEnumNodes[T]);

  _nestedEnumMapNodesDepthOne[List<T>] = _mapNode<List<T>>(_listEnumNodes[T]);
  _nestedEnumMapNodesDepthOne[Map<String, T>] =
      _mapNode<Map<String, T>>(_mapEnumNodes[T]);

  _nestedEnumListNodesDepthTwo[List<List<T>>] =
      _listNode<List<List<T>>>(_nestedEnumListNodesDepthOne[List<T>]);
  _nestedEnumListNodesDepthTwo[List<Map<String, T>>] =
      _listNode<List<Map<String, T>>>(
          _nestedEnumListNodesDepthOne[Map<String, T>]);
  _nestedEnumListNodesDepthTwo[Map<String, List<T>>] =
      _listNode<Map<String, List<T>>>(_nestedEnumMapNodesDepthOne[List<T>]);
  _nestedEnumListNodesDepthTwo[Map<String, Map<String, T>>] =
      _listNode<Map<String, Map<String, T>>>(
          _nestedEnumMapNodesDepthOne[Map<String, T>]);

  _nestedEnumMapNodesDepthTwo[List<List<T>>] =
      _mapNode<List<List<T>>>(_nestedEnumListNodesDepthOne[List<T>]);
  _nestedEnumMapNodesDepthTwo[List<Map<String, T>>] =
      _mapNode<List<Map<String, T>>>(
          _nestedEnumListNodesDepthOne[Map<String, T>]);
  _nestedEnumMapNodesDepthTwo[Map<String, List<T>>] =
      _mapNode<Map<String, List<T>>>(_nestedEnumMapNodesDepthOne[List<T>]);
  _nestedEnumMapNodesDepthTwo[Map<String, Map<String, T>>] =
      _mapNode<Map<String, Map<String, T>>>(
          _nestedEnumMapNodesDepthOne[Map<String, T>]);
}

void registerJson<T>(Function constructor, List<String> keys) {
  _objectNodes[T] = _ObjectNode(constructor, keys, {});

  _listNodes[T] = _listNode<T>(_objectNodes[T]);
  _mapNodes[T] = _mapNode<T>(_objectNodes[T]);

  _nestedListNodesDepthOne[List<T>] = _listNode<List<T>>(_listNodes[T]);
  _nestedListNodesDepthOne[Map<String, T>] =
      _listNode<Map<String, T>>(_mapNodes[T]);

  _nestedMapNodesDepthOne[List<T>] = _mapNode<List<T>>(_listNodes[T]);
  _nestedMapNodesDepthOne[Map<String, T>] =
      _mapNode<Map<String, T>>(_mapNodes[T]);

  _nestedListNodesDepthTwo[List<List<T>>] =
      _listNode<List<List<T>>>(_nestedListNodesDepthOne[List<T>]);
  _nestedListNodesDepthTwo[List<Map<String, T>>] =
      _listNode<List<Map<String, T>>>(_nestedListNodesDepthOne[Map<String, T>]);
  _nestedListNodesDepthTwo[Map<String, List<T>>] =
      _listNode<Map<String, List<T>>>(_nestedMapNodesDepthOne[List<T>]);
  _nestedListNodesDepthTwo[Map<String, Map<String, T>>] =
      _listNode<Map<String, Map<String, T>>>(
          _nestedMapNodesDepthOne[Map<String, T>]);

  _nestedMapNodesDepthTwo[List<List<T>>] =
      _mapNode<List<List<T>>>(_nestedListNodesDepthOne[List<T>]);
  _nestedMapNodesDepthTwo[List<Map<String, T>>] =
      _mapNode<List<Map<String, T>>>(_nestedListNodesDepthOne[Map<String, T>]);
  _nestedMapNodesDepthTwo[Map<String, List<T>>] =
      _mapNode<Map<String, List<T>>>(_nestedMapNodesDepthOne[List<T>]);
  _nestedMapNodesDepthTwo[Map<String, Map<String, T>>] =
      _mapNode<Map<String, Map<String, T>>>(
          _nestedMapNodesDepthOne[Map<String, T>]);
}

T fromJson<T>(dynamic json) =>
    (_dynamicDecodeProperty(json) as _Decoded).value as T;
