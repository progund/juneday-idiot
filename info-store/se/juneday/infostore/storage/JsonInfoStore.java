package se.juneday.infostore.storage;

import org.json.*;
import java.io.File;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.FileNotFoundException;

import se.juneday.infostore.domain.Message;

public class JsonInfoStore implements InfoStore {

  private PrintWriter out;
  private Message message;
  private boolean storeToFile;
  
  
  public void setMessage(Message message) {
    this.message = message;
  }
  
  public Message message() {
    return message;
  }

  private void storeToFile(JSONObject j) {
    String fileName = System.getProperty("info-file");
    if (fileName==null) {
      fileName = "juneday-info.json";
    }
    try {
      new File(fileName).delete();
      out = new PrintWriter(fileName);
    } catch (FileNotFoundException e) {
      System.err.println("File not found: " + fileName);
    }
    out.println(j.toString());
    out.flush();
    out.close();
  }
  
  public void store() {
    System.out.println("store: " + message);
    JSONObject j = JSONMessage(message);
    if (storeToFile) {
      storeToFile(j);
    }
    System.out.println("store: " + j);
  }

  public String formatted() {
    return JSONMessage(message).toString();
  }


  private static JSONObject JSONMessage(Message message) {
    JSONObject JSONMessage = new JSONObject();
    JSONMessage.put("message", message.message());
    return JSONMessage;
  }

}
