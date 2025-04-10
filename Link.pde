class Link {

  private Particle a, b;
  public float length;
  public boolean hidden;
  public color strokeColor = 0;
  public float strokeWeight = 1;

  Link(Particle a, Particle b, float length) {
    this.a = a;
    this.b = b;
    this.length = length;
  }

  public void constraint() {
    Vec dist = new Vec(a.curPos.x-b.curPos.x, a.curPos.y-b.curPos.y, a.curPos.z-b.curPos.z);
    float offset = (length - dist.mag())/2;
    dist.setMag(offset);
    if (!a.pinned && !b.pinned) {
      a.curPos.add(dist);
      b.curPos.sub(dist);
    } else if (!a.pinned) {
      a.curPos.add(dist.mult(2));
    } else if (!b.pinned) {
      b.curPos.sub(dist.mult(2));
    }
  }
  
  public void display() {
    stroke(strokeColor);
    strokeWeight(strokeWeight);
    line(a.curPos.x, a.curPos.y, b.curPos.x, b.curPos.y);
  }
}
