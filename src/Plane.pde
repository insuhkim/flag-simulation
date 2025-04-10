class Plane extends Particles {
  int row;
  int col;
  float rowLength;
  float colLength;
  boolean image = false;
  PImage img;
  
  Particle upperLeft;
  Particle upperRight;
  Particle bottomLeft;
  Particle bottomRight;

  Plane(int row, int col, float rowLength, float colLength) {
    super(row*col);
    this.row = row;
    this.col = col;
    this.rowLength = rowLength;
    this.colLength = colLength;
    Vec[] pos = new Vec[row*col];

    for (int i=0; i<col; i++) {
      for (int j=0; j<row; j++) {
        pos[i*row+j] = new Vec(lerp(0, rowLength, j/((float)row)), lerp(0, colLength, i/((float)col)));
        
        if (i != col-1) {
          addLink(P[i*row+j], P[i*row+row+j], colLength/col);
          if (j != row-1) {
            addLink(P[i*row+j], P[i*row+row+j+1], sqrt(sq(colLength/col)+sq(rowLength/row)));
            addLink(P[i*row+j+1], P[i*row+row+j], sqrt(sq(colLength/col)+sq(rowLength/row)));
          }
        }
        if (j != row-1) {
          addLink(P[i*row+j], P[i*row+j+1], rowLength/row);
        }
      }
    }

    setPos(pos);

    this.upperLeft = P[0];
    this.upperRight = P[row-1];
    this.bottomLeft = P[P.length-row];
    this.bottomRight = P[P.length-1];
  }



  void setImage(PImage img) {
    img.resize(int(rowLength), int(colLength));
    for (int i=0; i<row; i++) {
      for (int j=0; j<col; j++) {
        P[row*j+i].particleColor = img.get((int)rowLength*i/row, (int)colLength*j/col);
      }
    }
    image = true;
    this.img = img;
  }


  void display() {
    if (image == false) {
      super.display();
    } else {
      textureMode(NORMAL);
      strokeWeight(strokeWeight);
      for (int j=0; j<row-1; j++) {
        beginShape(TRIANGLE_STRIP);
        texture(img);
        for (int i=0; i<col; i++) {
          float x1 = P[i*row+j].curPos.x;
          float y1 = P[i*row+j].curPos.y;
          float z1 = P[i*row+j].curPos.z;
          float u = map(i, 0, col-1, 0, 1);
          float v1 = map(j, 0, row-1, 0, 1);
          vertex(x1, y1, z1, v1, u);
          float x2 = P[i*row+j+1].curPos.x;
          float y2 = P[i*row+j+1].curPos.y;
          float z2 = P[i*row+j+1].curPos.z;
          float v2 = map(j+1, 0, row-1, 0, 1);
          vertex(x2, y2, z2, v2, u);
        }
        endShape();
      }
    }
  }
  
  Particle getParticle(int r, int c) {
    assert((r>=0) && (r<row));
    assert((c>=0) && (c<col));
    return P[r*col + c];
  }
}
