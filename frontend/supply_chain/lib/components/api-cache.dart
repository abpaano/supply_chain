// api_cache.dart

class ApiCache {
  static final _cache = <String, dynamic>{};

  static dynamic get(String key) {
    return _cache[key];
  }

  static void set(String key, dynamic value) {
    _cache[key] = value;
  }

  static bool contains(String key) {
    return _cache.containsKey(key);
  }
}
