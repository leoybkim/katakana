import 'dart:collection';

class CircularLinkedList<T> implements HasNextIterator {
  final List<T> _iterable;

  CircularLinkedList._(this._iterable)
      : current = _iterable.isEmpty ? _iterable.first : null, _state = _iterable.isEmpty ? _NO_NEXT : _NOT_MOVED_YET,
        _iterator = _iterable.iterator;
  T current;
  Iterator<T> _iterator;

  CircularLinkedList([int length]) : _iterable = new List(length);

  factory CircularLinkedList.fromIterable(List<T> iterable) {
    return CircularLinkedList._(iterable);
  }

  @override
  next() {
    if (!hasNext) _iterator = _iterable.iterator;
    current = _iterator.current;
    _move();
    return current;
  }

  static const int _HAS_NEXT_AND_NEXT_IN_CURRENT = 0;
  static const int _NO_NEXT = 1;
  static const int _NOT_MOVED_YET = 2;

  int _state = _NOT_MOVED_YET;


  bool get hasNext {
    if (_state == _NOT_MOVED_YET) _move();
    return _state == _HAS_NEXT_AND_NEXT_IN_CURRENT;
  }

  void _move() {
    if (_iterator.moveNext()) {
      _state = _HAS_NEXT_AND_NEXT_IN_CURRENT;
    } else {
      _state = _NO_NEXT;
    }
  }
}
