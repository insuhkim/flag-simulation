class Particles {
  int numberOfParticles;
  int iterateNum = 105;
  float strokeWeight = 0.4;
  float bounce = 0.9;
  float friction = 0.97;
  color stroke = #000000; 
  boolean reflect = false;
  boolean showParticle = false;
  boolean showLink = true;
  Link[] links;
  Particle[] P;

  Particles(int numberOfParticles) {
    this.numberOfParticles = numberOfParticles;
    P = new Particle[numberOfParticles];
    links = new Link[0];
    for (int i=numberOfParticles-1; i>=0; i--) {
      //
      P[i] = new Particle(lerp(0, width, (float)i/numberOfParticles), 
        lerp(0, height, (float)i/numberOfParticles), 0);
      //
    }
  }

  void interact(int iterateNum) {
    for (int it=iterateNum-1; it>=0; it--) 
      for (Link link : links) 
        link.constraint();
  }


  void update() {
    for (int i=numberOfParticles-1; i>=0; i--) {
      P[i].update();
      if (reflect) {
        P[i].reflect(0, width, 0, height-40, bounce);
      }
    }
    interact(iterateNum);
  }

  void update(Vec force) {
    for (int i=numberOfParticles-1; i>=0; i--) {
      P[i].update(force, friction);
      if (reflect) {
        P[i].reflect(0, width, 0, height-40, bounce);
      }
    }
    interact(iterateNum);
  }


  void display() {
    for (Link link : links) {
      link.display();
    }
    if (showParticle) {
      for (int i=numberOfParticles-1; i>=0; i--) {
        P[i].display();
      }
    }
  }


  void run() {
    update();
    display();
  }

  void run(Vec force) {
    update(force);
    display();
  }

  void setPos(Vec[] posList) {
    assert(numberOfParticles == posList.length);
    for (int i=numberOfParticles-1; i>=0; i--) {
      P[i].setPos(posList[i].x, posList[i].y);
    }
  }

  void setReflection(boolean reflection) {
    this.reflect = reflection;
  }

  color meanCol(color a, color b) {
    return color(int(red(a)+red(b))/2, int(green(a)+green(b))/2, ((blue(a)+blue(b))/2));
  }
  void addLink(Particle a, Particle b, float dist) {
    addLink(a, b, dist, false);
  }
  void addLink(Particle a, Particle b, float dist, boolean hidden) {
    Link newLink = new Link(a, b, dist);
    newLink.strokeColor = meanCol(a.particleColor, b.particleColor);
    newLink.strokeWeight = strokeWeight;
    newLink.hidden = hidden;
    links = (Link[]) append(links, newLink);
  }
}
