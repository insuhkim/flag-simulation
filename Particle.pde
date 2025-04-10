class Particle {
  Vec curPos;
  Vec oldPos;
  Vec vel;
  float r = 10;
  color particleColor = #000000;
  boolean pinned = false;

  Particle() {
    curPos = new Vec();
    oldPos = new Vec();
    vel = new Vec();
  }  
  Particle(float x, float y) {
    curPos = new Vec(x, y);
    oldPos = new Vec(x, y);
    vel = new Vec();
  } 
  Particle(float x, float y, float z) {
    curPos = new Vec(x, y, z);
    oldPos = new Vec(x, y, z);
    vel = new Vec();
  }


  void update() {
    if (!pinned) {
      vel.x = curPos.x - oldPos.x;
      vel.y = curPos.y - oldPos.y;
      vel.z = curPos.z - oldPos.z;

      oldPos = curPos.copy();
      curPos.add(vel);
    }
  }

  void update(Vec netForce) {
    if (!pinned) {
      update();
      curPos.add(netForce);
    }
  }

  void update(Vec netForce, float friction) {
    if (!pinned) {
      vel.x = curPos.x - oldPos.x;
      vel.y = curPos.y - oldPos.y;
      vel.z = curPos.z - oldPos.z;
      vel.mult(friction);
      oldPos = curPos.copy();
      curPos.add(vel);
      curPos.add(netForce);
    }
  }


  void display() {
    fill(particleColor);
    circle(curPos.x, curPos.y, 2*r);
  }

  void setPos(float x, float y) {
    curPos.setPos(x, y);
    oldPos.setPos(x, y);
  }
  
  void setPos(float x, float y, float z) {
    curPos.setPos(x, y, z);
    oldPos.setPos(x, y, z);
  }

  void setX(float x) {
    curPos.x = x;
    oldPos.x = x;
  }

  void setY(float y) {
    curPos.y = y;
    oldPos.y = y;
  }

  void setZ(float z) {
    curPos.z = z;
    oldPos.z = z;
  }


  void reflect(float minX, float maxX, float minY, float maxY, float bounce) {
    if (curPos.x > maxX) {
      curPos.x = maxX;
      oldPos.x = curPos.x + vel.x*bounce;
    } else if (curPos.x < minX) {
      curPos.x = minX;
      oldPos.x = curPos.x + vel.x*bounce;
    }

    if (curPos.y > maxY) {
      curPos.y = maxY;
      oldPos.y = curPos.y + vel.y*bounce;
    } else if (curPos.y < minY) {
      curPos.y = minY;
      oldPos.y = curPos.y + vel.y*bounce;
    }
  }
}
