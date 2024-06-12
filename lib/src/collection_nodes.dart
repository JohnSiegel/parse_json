part of '../parse_json.dart';

List<T> _callWithPrimitiveTypes<T>(T Function<V>() function) => [
      function<int>(),
      function<double>(),
      function<String>(),
      function<bool>(),
    ];

_ListNode<T> _listNode<T>(_DecoderNode decoder) => _ListNode(decoder);

_MapNode<T> _mapNode<T>(_DecoderNode decoder) => _MapNode(decoder);

MapEntry<Type, _ListNode<T>> _listNodeEntry<T>(_DecoderNode decoder) =>
    MapEntry(T, _listNode(decoder));

MapEntry<Type, _MapNode<T>> _mapNodeEntry<T>(_DecoderNode decoder) =>
    MapEntry(T, _mapNode(decoder));

MapEntry<Type, _ListNode<T>> _primitiveListNode<T>() =>
    _listNodeEntry(_PrimitiveNode<T>());

MapEntry<Type, _MapNode<T>> _primitiveMapNode<T>() =>
    _mapNodeEntry(_PrimitiveNode<T>());

final _primitiveListNodes = _NodeMap<_ListNode<dynamic>>(
    Map.fromEntries(_callWithPrimitiveTypes(_primitiveListNode)));

final _primitiveMapNodes = _NodeMap<_MapNode<dynamic>>(
    Map.fromEntries(_callWithPrimitiveTypes(_primitiveMapNode)));

MapEntry<Type, _ListNode<Container>> _nestedListNode<Container, T>(
  _NodeMap<_DecoderNode> nodeMap,
) =>
    _listNodeEntry<Container>(nodeMap[T]);

MapEntry<Type, _ListNode<List<T>>> _nestedListListNode<T>() =>
    _nestedListNode<List<T>, T>(_primitiveListNodes);

MapEntry<Type, _ListNode<Map<String, T>>> _nestedListMapNode<T>() =>
    _nestedListNode<Map<String, T>, T>(_primitiveMapNodes);

final _nestedListNodesDepthOne = _NodeMap<_ListNode<dynamic>>(Map.fromEntries([
  ..._callWithPrimitiveTypes(_nestedListListNode),
  ..._callWithPrimitiveTypes(_nestedListMapNode),
]));

MapEntry<Type, _MapNode<Container>> _nestedMapNode<Container, T>(
  _NodeMap<_DecoderNode> nodeMap,
) =>
    _mapNodeEntry<Container>(nodeMap[T]);

MapEntry<Type, _MapNode<List<T>>> _nestedMapListNode<T>() =>
    _nestedMapNode<List<T>, T>(_primitiveListNodes);

MapEntry<Type, _MapNode<Map<String, T>>> _nestedMapMapNode<T>() =>
    _nestedMapNode<Map<String, T>, T>(_primitiveMapNodes);

final _nestedMapNodesDepthOne = _NodeMap<_MapNode<dynamic>>(Map.fromEntries([
  ..._callWithPrimitiveTypes(_nestedMapListNode),
  ..._callWithPrimitiveTypes(_nestedMapMapNode),
]));

MapEntry<Type, _ListNode<List<Container>>>
    _nestedListListNodeDepthTwo<Container, T>(
  _NodeMap<_DecoderNode> nodeMap,
) =>
        _listNodeEntry<List<Container>>(nodeMap[List<T>]);

MapEntry<Type, _ListNode<Map<String, Container>>>
    _nestedListMapNodeDepthTwo<Container, T>(
  _NodeMap<_DecoderNode> nodeMap,
) =>
        _listNodeEntry<Map<String, Container>>(nodeMap[Map<String, T>]);

MapEntry<Type, _ListNode<List<List<T>>>> _nestedListListListNode<T>() =>
    _nestedListListNodeDepthTwo<List<T>, T>(_nestedListNodesDepthOne);

MapEntry<Type, _ListNode<List<Map<String, T>>>> _nestedListListMapNode<T>() =>
    _nestedListListNodeDepthTwo<Map<String, T>, T>(_nestedMapNodesDepthOne);

MapEntry<Type, _ListNode<Map<String, List<T>>>> _nestedListMapListNode<T>() =>
    _nestedListMapNodeDepthTwo<List<T>, T>(_nestedListNodesDepthOne);

MapEntry<Type, _ListNode<Map<String, Map<String, T>>>>
    _nestedListMapMapNode<T>() =>
        _nestedListMapNodeDepthTwo<Map<String, T>, T>(_nestedMapNodesDepthOne);

final _nestedListNodesDepthTwo = _NodeMap<_ListNode<dynamic>>(Map.fromEntries([
  ..._callWithPrimitiveTypes(_nestedListListListNode),
  ..._callWithPrimitiveTypes(_nestedListListMapNode),
  ..._callWithPrimitiveTypes(_nestedListMapListNode),
  ..._callWithPrimitiveTypes(_nestedListMapMapNode),
]));

MapEntry<Type, _MapNode<List<Container>>>
    _nestedMapListNodeDepthTwo<Container, T>(
  _NodeMap<_DecoderNode> nodeMap,
) =>
        _mapNodeEntry<List<Container>>(nodeMap[List<T>]);

MapEntry<Type, _MapNode<Map<String, Container>>>
    _nestedMapMapNodeDepthTwo<Container, T>(
  _NodeMap<_DecoderNode> nodeMap,
) =>
        _mapNodeEntry<Map<String, Container>>(nodeMap[Map<String, T>]);

MapEntry<Type, _MapNode<List<List<T>>>> _nestedMapListListNode<T>() =>
    _nestedMapListNodeDepthTwo<List<T>, T>(_nestedListNodesDepthOne);

MapEntry<Type, _MapNode<List<Map<String, T>>>> _nestedMapListMapNode<T>() =>
    _nestedMapListNodeDepthTwo<Map<String, T>, T>(_nestedMapNodesDepthOne);

MapEntry<Type, _MapNode<Map<String, List<T>>>> _nestedMapMapListNode<T>() =>
    _nestedMapMapNodeDepthTwo<List<T>, T>(_nestedListNodesDepthOne);

MapEntry<Type, _MapNode<Map<String, Map<String, T>>>>
    _nestedMapMapMapNode<T>() =>
        _nestedMapMapNodeDepthTwo<Map<String, T>, T>(_nestedMapNodesDepthOne);

final _nestedMapNodesDepthTwo = _NodeMap<_MapNode<dynamic>>(Map.fromEntries([
  ..._callWithPrimitiveTypes(_nestedMapListListNode),
  ..._callWithPrimitiveTypes(_nestedMapListMapNode),
  ..._callWithPrimitiveTypes(_nestedMapMapListNode),
  ..._callWithPrimitiveTypes(_nestedMapMapMapNode),
]));
