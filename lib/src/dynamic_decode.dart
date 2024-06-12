part of '../parse_json.dart';

sealed class _Decoding {
  const _Decoding();
}

final class _Decoded extends _Decoding {
  final _DecoderNode? node;
  final dynamic value;

  const _Decoded(this.node, this.value);
}

final class _DecodingError extends _Decoding {
  const _DecodingError();
}

_Decoding _dynamicDecodeProperty(dynamic json) => switch (json) {
      null => _Decoded(null, null),
      num() || bool() || String() => switch (_enumNodes.dynamicDecode(json)) {
          _Decoded(node: final node, value: final value) =>
            _Decoded(node, value),
          _DecodingError() => _Decoded(null, json),
        },
      List<dynamic>() => switch (_listEnumNodes.dynamicDecode(json)) {
          _Decoded(node: final node, value: final value) =>
            _Decoded(node, value),
          _DecodingError() => switch (_listNodes.dynamicDecode(json)) {
              _Decoded(node: final node, value: final value) =>
                _Decoded(node, value),
              _DecodingError() => switch (
                    _nestedEnumListNodesDepthOne.dynamicDecode(json)) {
                  _Decoded(node: final node, value: final value) =>
                    _Decoded(node, value),
                  _DecodingError() => switch (
                        _nestedListNodesDepthOne.dynamicDecode(json)) {
                      _Decoded(node: final node, value: final value) =>
                        _Decoded(node, value),
                      _DecodingError() => switch (
                            _nestedEnumListNodesDepthTwo.dynamicDecode(json)) {
                          _Decoded(node: final node, value: final value) =>
                            _Decoded(node, value),
                          _DecodingError() => switch (
                                _nestedListNodesDepthTwo.dynamicDecode(json)) {
                              _Decoded(node: final node, value: final value) =>
                                _Decoded(node, value),
                              _DecodingError() => const _DecodingError(),
                            },
                        },
                    },
                },
            },
        },
      Map<String, dynamic>() => switch (_objectNodes.dynamicDecode(json)) {
          _Decoded(node: final node, value: final value) =>
            _Decoded(node, value),
          _DecodingError() => switch (_mapEnumNodes.dynamicDecode(json)) {
              _Decoded(node: final node, value: final value) =>
                _Decoded(node, value),
              _DecodingError() => switch (_mapNodes.dynamicDecode(json)) {
                  _Decoded(node: final node, value: final value) =>
                    _Decoded(node, value),
                  _DecodingError() => switch (
                        _nestedEnumMapNodesDepthOne.dynamicDecode(json)) {
                      _Decoded(node: final node, value: final value) =>
                        _Decoded(node, value),
                      _DecodingError() => switch (
                            _nestedMapNodesDepthOne.dynamicDecode(json)) {
                          _Decoded(node: final node, value: final value) =>
                            _Decoded(node, value),
                          _DecodingError() => switch (
                                _nestedEnumMapNodesDepthTwo
                                    .dynamicDecode(json)) {
                              _Decoded(node: final node, value: final value) =>
                                _Decoded(node, value),
                              _DecodingError() => switch (
                                    _nestedMapNodesDepthTwo
                                        .dynamicDecode(json)) {
                                  _Decoded(
                                    node: final node,
                                    value: final value
                                  ) =>
                                    _Decoded(node, value),
                                  _DecodingError() => const _DecodingError(),
                                },
                            },
                        },
                    },
                },
            },
        },
      _ => const _DecodingError(),
    };
