package se.juneday.infostore.storage;

import se.juneday.infostore.domain.Message;

public interface InfoStore {
  public void setMessage(Message message);
  public Message message();
  public void store();
  public String formatted();
}
