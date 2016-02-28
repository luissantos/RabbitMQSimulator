class Producer extends Node implements IConnectable {
    int type = PRODUCER;
    int intervalId = null;
    int intervalSeconds = 0;
    String name = null;
    Message msg = null;

    Producer(String label, float x, float y) {
        super(label, colors[PRODUCER], x, y);
    }

    int getType() {
        return type;
    }

    void updateName(String name) {
        this.name = name;
    }

    boolean accepts(Node n) {
        return false;
    }

    boolean canStartConnection() {
        return outgoing.size() < 1;
    }

    void removeConnections() {
      this.disconnectOutgoing();
    }

    void publishMessage(String payload, String routingKey) {
        if (outgoing.size() > 0) {
            Node n = (Node) outgoing.get(0);
            msg = new Message(payload, routingKey);
            stage.addTransfer(new Transfer(stage, this, n, msg));
        }
    }

    void setIntervalId(int interval, int seconds) {
        intervalId = interval;
        intervalSeconds = seconds;
    }

    void getIntervalId(){
      return intervalId;
    }

    void stopPublisher() {
        pausePublisher();
        intervalSeconds = 0;
    }

    void pausePublisher() {
        clearInterval(intervalId);
        intervalId = null;
    }

    void drawLabel() {
        fill (0);
        textAlign(CENTER, CENTER);
        String l = name == null ? label : name;
        text(l, x, y+labelPadding);
    }

    void remove() {
        disconnectNode(this);
        removeNode(this);
    }
}
