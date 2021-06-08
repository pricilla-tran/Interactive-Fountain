class WaterSystem {
  ArrayList<WaterDrop> waterDrops;
  PVector origin;

  WaterSystem(int num, PVector position) {
    waterDrops = new ArrayList<WaterDrop>();
    origin = position.copy();
    for (int i = 0; i < num; i++) {
      waterDrops.add(new WaterDrop(origin));         // Add "num" amount of particles to the arraylist
    }
  }

  void addWaterDrops() {
    waterDrops.add(new WaterDrop(origin));
  }

  void run() {
    for (int i = waterDrops.size()-1; i >= 0; i--) {
      WaterDrop w = waterDrops.get(i);
      w.run();
      if (w.isDead()) {
        waterDrops.remove(i);
      }
    }
  }
  
  void applyForce(PVector dir) {
    // Enhanced loop!!!
    for (WaterDrop w : waterDrops) {
      w.applyForce(dir);
    }
  }  
}
