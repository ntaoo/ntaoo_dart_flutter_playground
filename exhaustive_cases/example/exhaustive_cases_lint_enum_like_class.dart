class EnumLike {
  final String name;
  const EnumLike._(this.name);

  static const red = EnumLike._('red');
  static const green = EnumLike._('green');
  static const blue = EnumLike._('blue');
}

void bad(EnumLike e) {
  switch (e) {
    // LINT
    case EnumLike.red:
      // red case
      print(e.name); // red;
      break;
    case EnumLike.green:
      // green case
      print(e.name); // green;
      break;
  }
}

void main() {
  bad(EnumLike.red);
}
