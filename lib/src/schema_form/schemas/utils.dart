T? getValue<T>(Map<String, dynamic> map, String key, [T Function(dynamic)? transform]) {
  if (map.containsKey(key)) {
    var value = map[key];
    return transform != null ? transform(value) : value as T;
  }
  return null;
}