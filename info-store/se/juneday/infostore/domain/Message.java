package se.juneday.infostore.domain;

public class Message {
  private String msg;

  public Message(String msg) {
    this.msg = msg;
  }

  public String toString() {
    return msg;
  }
    
  public String message() {
    return msg;
  }
    
}
