class Vect2<T extends num> {
  T x;
  T y;
  Vect2(this.x, this.y);

  void add(T x, T y) {
    this.x += x;
    this.y += y;
  }

  Vect2<T> operator  +(Vect2<T> v) => Vect2<T>(this.x + v.x, this.y + v.y);
 
  @override
  bool operator  ==(v) => v is Vect2<T> && v.x == this.x && v.y == this.y;
  
  @override
  int get hashCode => x.hashCode ^ y.hashCode;
}