class MySingleton {
  factory MySingleton() {
    return _singleton;
  }

  MySingleton._internal() {}

  static final MySingleton _singleton = MySingleton._internal();
}
