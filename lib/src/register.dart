part of '../parse_json.dart';

final _enumNodes = _NodeMap<_EnumNode>({});

final _listEnumNodes = _NodeMap<_ListNode<dynamic>>({});

final _mapEnumNodes = _NodeMap<_MapNode<dynamic>>({});

final _nestedEnumListNodesDepthOne = _NodeMap<_ListNode<dynamic>>({});

final _nestedEnumMapNodesDepthOne = _NodeMap<_MapNode<dynamic>>({});

final _nestedEnumListNodesDepthTwo = _NodeMap<_ListNode<dynamic>>({});

final _nestedEnumMapNodesDepthTwo = _NodeMap<_MapNode<dynamic>>({});

final _objectNodes = _NodeMap<_ObjectNode>({});

void _registerCollectionTypes<T>(
  _NodeMap<_DecoderNode> baseNodes,
  _NodeMap<_ListNode<dynamic>> listNodes,
  _NodeMap<_MapNode<dynamic>> mapNodes,
  _NodeMap<_ListNode<dynamic>> listNestedNodesDepthOne,
  _NodeMap<_MapNode<dynamic>> mapNestedNodesDepthOne,
  _NodeMap<_ListNode<dynamic>> listNestedNodesDepthTwo,
  _NodeMap<_MapNode<dynamic>> mapNestedNodesDepthTwo,
) {
  listNodes[T] = _listNode<T>(baseNodes[T]);
  mapNodes[T] = _mapNode<T>(baseNodes[T]);

  listNestedNodesDepthOne[List<T>] = _listNode<List<T>>(listNodes[T]);
  listNestedNodesDepthOne[Map<String, T>] =
      _listNode<Map<String, T>>(mapNodes[T]);

  mapNestedNodesDepthOne[List<T>] = _mapNode<List<T>>(listNodes[T]);
  mapNestedNodesDepthOne[Map<String, T>] =
      _mapNode<Map<String, T>>(mapNodes[T]);

  listNestedNodesDepthTwo[List<List<T>>] =
      _listNode<List<List<T>>>(listNestedNodesDepthOne[List<T>]);
  listNestedNodesDepthTwo[List<Map<String, T>>] =
      _listNode<List<Map<String, T>>>(listNestedNodesDepthOne[Map<String, T>]);
  listNestedNodesDepthTwo[Map<String, List<T>>] =
      _listNode<Map<String, List<T>>>(mapNestedNodesDepthOne[List<T>]);
  listNestedNodesDepthTwo[Map<String, Map<String, T>>] =
      _listNode<Map<String, Map<String, T>>>(
          mapNestedNodesDepthOne[Map<String, T>]);

  mapNestedNodesDepthTwo[List<List<T>>] =
      _mapNode<List<List<T>>>(listNestedNodesDepthOne[List<T>]);
  mapNestedNodesDepthTwo[List<Map<String, T>>] =
      _mapNode<List<Map<String, T>>>(listNestedNodesDepthOne[Map<String, T>]);
  mapNestedNodesDepthTwo[Map<String, List<T>>] =
      _mapNode<Map<String, List<T>>>(mapNestedNodesDepthOne[List<T>]);
  mapNestedNodesDepthTwo[Map<String, Map<String, T>>] =
      _mapNode<Map<String, Map<String, T>>>(
          mapNestedNodesDepthOne[Map<String, T>]);
}

void registerEnum<T>(dynamic Function(dynamic) constructor) {
  _enumNodes[T] = _EnumNode(constructor);
  _registerCollectionTypes<T>(
    _enumNodes,
    _listEnumNodes,
    _mapEnumNodes,
    _nestedEnumListNodesDepthOne,
    _nestedEnumMapNodesDepthOne,
    _nestedEnumListNodesDepthTwo,
    _nestedEnumMapNodesDepthTwo,
  );
}

void registerJson<T>(Function constructor, List<String> keys) {
  _objectNodes[T] = _ObjectNode(constructor, keys, {});
  _registerCollectionTypes<T>(
    _objectNodes,
    _primitiveListNodes,
    _primitiveMapNodes,
    _nestedListNodesDepthOne,
    _nestedMapNodesDepthOne,
    _nestedListNodesDepthTwo,
    _nestedMapNodesDepthTwo,
  );
}

T fromJson<T>(dynamic json) =>
    (_dynamicDecodeProperty(json) as _Decoded).value as T;
