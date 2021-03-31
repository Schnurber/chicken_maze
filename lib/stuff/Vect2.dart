class Vect2<T extends num> {
  num _x;
  num _y;
  Vect2(this._x, this._y);

  void add(T x, T y) {
    this._x += x;
    this._y += y;
  }

  Vect2<T> operator +(Vect2<T> v) => Vect2<T>(this.x + v.x, this.y + v.y);

  @override
  bool operator ==(v) => v is Vect2<T> && v.x == this.x && v.y == this.y;

  @override
  int get hashCode => this._x.hashCode ^ this._y.hashCode;

  T get x => this._x as T;
  T get y => this._y as T;
  set x(T val) => _x = val;
  set y(T val) => _y = val;
}