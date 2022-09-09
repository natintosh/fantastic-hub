import 'package:rxdart/rxdart.dart';

abstract class InMemoryCache<T> {
  InMemoryCache();

  final List<T> _cache = List.of([]);
  late BehaviorSubject<List<T>> _controller = BehaviorSubject.seeded(_cache);

  Stream<List<T>> get _stream => _controller.stream;

  Stream<List<T>> getItems() async* {
    yield* _stream;
  }

  List<T> getAllItems() {
    return List.from(_cache);
  }

  void add(T item) {
    _checkAndReOpenStream();
    _cache.add(item);
    _controller.sink.add(List.from(_cache));
  }

  void addAll(List<T> items) {
    if (items.isEmpty && isEmpty()) {
      return;
    }
    _checkAndReOpenStream();
    _cache.addAll(items);
    _controller.sink.add(List.from(_cache));
  }

  void deleteAll() {
    if (isEmpty()) {
      return;
    }
    _checkAndReOpenStream();
    _cache.clear();
    _controller.sink.add(List.from(_cache));
  }

  void deleteWhere(bool Function(T element) predicate) {
    if (isEmpty()) {
      return;
    }
    _checkAndReOpenStream();
    _cache.removeWhere(predicate);
    _controller.sink.add(List.from(_cache));
  }

  bool updateWhere(bool Function(T element) predicate, T? item) {
    if (null == item) return false;
    final index = _cache.indexWhere(predicate);
    if (index != -1) {
      _cache
        ..removeAt(index)
        ..insert(index, item);
    } else {
      _cache.add(item);
    }
    _checkAndReOpenStream();
    _controller.sink.add(List.from(_cache));
    return true;
  }

  T removeAt(int index) {
    _checkAndReOpenStream();
    final removed = _cache.removeAt(index);
    _controller.sink.add(List.from(_cache));
    return removed;
  }

  void _checkAndReOpenStream() {
    if (_controller.isClosed) {
      _controller = BehaviorSubject.seeded(_cache);
    }
  }

  bool isEmpty() {
    final _cachedData = _controller.valueOrNull ?? [];
    return _cachedData.isEmpty && _cache.isEmpty;
  }

  void dispose() {
    _cache.clear();
    _controller.close();
  }
}
