package se.juneday.infosystem.web;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import static java.nio.charset.StandardCharsets.UTF_8;

public class LcdDisplay  extends HttpServlet {

  private static String lcdText;

  public LcdDisplay(){
    lcdText = LcdDisplay.class.getName();
  }


  @Override
  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    request.setCharacterEncoding(UTF_8.name());
    response.setContentType("text/html;charset="+UTF_8.name());
    PrintWriter out =
      new PrintWriter(new OutputStreamWriter(response.getOutputStream(),
                                             UTF_8), true);
    out.println("<!DOCTYPE html>");
    out.println("<html lang=\"en\">");
    out.println("<head><title>Juneday's Information System, well it's a bogus</title></head>");
    out.println("<body>");
    out.println("<h1>Text on LCD: " + lcdText + "</h1>");
    out.println("</body>");
    out.println("</html>");
    lcdText += " ll";
  }
}
