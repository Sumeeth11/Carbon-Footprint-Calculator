package com.example.carboncalc;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;

@WebServlet("/testdb")
public class TestDBServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try (Connection conn = DBUtil.getConnection()) {
            if (conn != null && !conn.isClosed()) {
                out.println("<h2> Database Connected Successfully!</h2>");
            } else {
                out.println("<h2> Database Connection Failed.</h2>");
            }
        } catch (Exception e) {
            out.println("<h2> Error: " + e.getMessage() + "</h2>");
            e.printStackTrace();
        }
    }
}
