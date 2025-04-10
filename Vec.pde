class Vec {
  float x;
  float y;
  float z;
  
  
  Vec(float x, float y) {
    this(x, y, 0);
  }
  Vec() {
    this(0, 0, 0);
  }
  Vec(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  Vec copy() {
    return new Vec(this.x, this.y, this.z);
  }

  Vec add(Vec other) {
    this.x += other.x;
    this.y += other.y;
    this.z += other.z;
    return this;
  }  

  Vec sub(Vec other) {
    this.x -= other.x;
    this.y -= other.y;
    this.z -= other.z;
    return this;
  }

  Vec mult(float n) {
    this.x *= n;
    this.y *= n;
    this.z *= n;
    return this;
  }

  Vec div(float n) {
    assert(n != 0);
    mult(1/n);
    return this;
  }

  Vec setPos(float x, float y) {
    this.x = x;
    this.y = y;
    return this;
  }
  Vec setPos(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
    return this;
  }
  
  float magSq() {
    return sq(x)+sq(y)+sq(z);
  }
  float mag() {
    return sqrt(magSq());
  }
  

  Vec setX(float x) {
    this.x = x;
    return this;
  }

  Vec setY(float y) {
    this.y = y;
    return this;
  }

  Vec setZ(float z) {
    this.z = z;
    return this;
  }

  Vec setMag(float mag) {
    float curMag = mag();
    assert(curMag != 0);
    float n = mag/curMag;
    mult(n);
    return this;
  }

  Vec lerp(Vec other, float alpha) {
    return new Vec(x*(1-alpha)+other.x*alpha, y*(1-alpha)+other.y*alpha, z*(1-alpha)+other.z*alpha);
  }
}   
