package se.juneday.infostore.storage;

public class InfoStoreFactory  {

  private static InfoStore instance;

  private InfoStoreFactory() { }

  public static InfoStore getInstance() {
    if (instance==null){
      instance = new JsonInfoStore();
    }
    return instance;
  }

}
