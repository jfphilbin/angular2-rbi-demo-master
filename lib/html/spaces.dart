//TODO: copyright
library spaces;

const String _spaces = "                                                                        ";

class Spaces {
  int count;

  int operator +(int n) => count += n;

  int operator -(int n) => count -= n;

  Spaces([this.count = 0]);

  String call(int n) {
    count += n;
    return toString();
  }

  String toString() => _spaces.substring(0, count);
}
