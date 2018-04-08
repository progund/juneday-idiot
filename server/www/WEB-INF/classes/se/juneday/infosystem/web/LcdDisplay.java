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

  private InfoStore infoStore;
  
  public LcdDisplay(){
    infoStore = InfoStoreFactory.getInstance();
    infoStore.setMessage(new Message(LcdDisplay.class.getSimpleName()));
  }

  private void htmlBegin(PrintWriter out) {
    out.println("<!DOCTYPE html>");
    out.println("<html lang=\"en\">");
    out.println("<head><title>Juneday's Information System, well it's a bogus</title></head>");
    out.println("<body>");
  }
    
  private void htmlEnd(PrintWriter out) {
    out.println("</body>");
    out.println("</html>");
  }
    
  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    request.setCharacterEncoding(UTF_8.name());
    response.setContentType("text/html;charset=" + UTF_8.name());
    response.setCharacterEncoding(UTF_8.name());
    
    String format = request.getParameter("format");
    String write = request.getParameter("write");
    int nrParameters = request.getParameterMap().entrySet().size();

    PrintWriter out = response.getWriter();

    String when = "" + new Date();

    // System.out.println(" let's parse");
    if ( write != null ) {
      htmlBegin(out);
      if (write.length()<32) {
        Message m = new Message(write);
        infoStore.setMessage(m);
        out.println("<br><h1>Text has been updated .... </h1>");
      }
      out.println("<h1>Text on LCD is now: " +  infoStore.message() + "</h1>");
      htmlEnd(out);
      return;
    }
    if (nrParameters == 0) {
      htmlBegin(out);
      out.println("<h1>Text on LCD: " +  infoStore.message() + "</h1>");
      htmlEnd(out);
    } else if ( format != null) {
      if (format.equals("html")) {
        htmlBegin(out);
        out.println("<h1>Text on LCD: " +  infoStore.message() + "</h1>");
        htmlEnd(out);
      } else if(format.equals("json")){
        out.println(infoStore.formatted());
      } else {
        htmlBegin(out);
        out.println("<h1>Text on LCD: " +  infoStore.message() + "</h1>");
        out.println("<h1>Format uknown: " + format + "</h1>");
        htmlEnd(out);
      }
    } else {
      htmlBegin(out);
      out.println("<br><h1>Text has NOT been updated, bad parameter </h1>");
      htmlEnd(out);
    }

  }
    
}
