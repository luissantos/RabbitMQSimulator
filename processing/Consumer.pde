class Consumer extends Node implements IConnectable {
  int size = 5;
  int type = CONSUMER;
  float angle = 0;
  String name = null;

  Consumer(String label, float x, float y) {
    super(label, colors[CONSUMER], x, y);
  }

  int getType() {
    return type;
  }

  String getLabel() {
    return name == null ? label : name;
  }

  void updateName(String name) {
      this.name = name;
  }

  boolean accepts(Node n) {
    return false;
  }

  boolean canStartConnection() {
    return true;
  }

  void removeConnections() {
    this.disconnectOutgoing();
  }

  void trasnferArrived(Transfer transfer) {
    if (!isPlayer) {
        Message msg = transfer.getData();
        onMessage(msg);
    }

    rotateConsumer();
  }

  void rotateConsumer() {
      this.angle += 0.2;
  }

  void draw() {
      ConsumerFigure.draw(this.x, this.y, this.nodeColor, 0, nodeStroke, this.radii, this.sides, this.angle);
      drawLabel();
  }


  void remove() {
      disconnectNode(this);
      removeNode(this);
  }
}
