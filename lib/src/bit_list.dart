import 'dart:collection';

/// A robust list-like wrapper around an integer to provide bit-level access.
/// This adheres to the "WYSIWIS" (What You See Is What Is Sent) principle.
class BitList extends ListBase<bool> {
  final int _value;
  final int _length;

  BitList.fromInt(this._value, {int length = 8}) : _length = length;

  @override
  int get length => _length;

  @override
  set length(int newLength) => throw UnsupportedError('BitList length is fixed');

  @override
  bool operator [](int index) {
    if (index < 0 || index >= _length) {
      throw RangeError.index(index, this);
    }
    return (_value & (1 << index)) != 0;
  }

  @override
  void operator []=(int index, bool value) => throw UnsupportedError('BitList is immutable');
}
