package se.juneday.infosystem.web;

import se.juneday.infostore.storage.*;
import se.juneday.infostore.domain.*;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.*;
import javax.servlet.http.*;
import static java.nio.charset.StandardCharsets.UTF_8;


public class LcdDisplay  extends HttpServlet {

  private String lcdText;
  private InfoStore infoStore;
  
  public LcdDisplay(){
    lcdText = LcdDisplay.class.getSimpleName();
    infoStore = InfoStoreFactory.getInstance();
    infoStore.setMessage(new Message(lcdText));
  }


  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    request.setCharacterEncoding(UTF_8.name());
    response.setContentType("text/html;charset="+UTF_8.name());

    String format = request.getParameter("format");
    String write = request.getParameter("write");

    PrintWriter out =
      new PrintWriter(new OutputStreamWriter(response.getOutputStream(),
                                             UTF_8), true);
    String when = "" + new Date();

    if ( write != null ) {
      infoStore.setMessage(new Message(write));
    } else if((format == null) || format.equals("html") ){
      out.println("<!DOCTYPE html>");
      out.println("<html lang=\"en\">");
      out.println("<head><title>Juneday's Information System, well it's a bogus</title></head>");
      out.println("<body>");
      out.println("<h1>Text on LCD: " + lcdText + "</h1>");
      out.println("</body>");
      out.println("</html>");
      lcdText += " ll";
      infoStore.setMessage(new Message(lcdText));
    }else if(format.equals("json")){
      System.out.println(" store: " + infoStore);
      System.out.println(" message: " + infoStore.message());
      System.out.println(" formatted: " + infoStore.formatted());
      out.println(infoStore.formatted());
    }else{
      System.out.println(when + " " + format + " not supported");
    }
    
    

  }

}
