import java.io.*;
import java.sql.*;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            PrintWriter out = response.getWriter();
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/21bcon121", "root", "7410");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            // Check if the user exists in the login table
            PreparedStatement psLogin = con.prepareStatement("SELECT uname FROM login WHERE uname=? AND password=? ");
            psLogin.setString(1, username);
            psLogin.setString(2, password);
            ResultSet rsLogin = psLogin.executeQuery();
            
            if (rsLogin.next()) {
                RequestDispatcher rd = request.getRequestDispatcher("admin_panel.jsp");
                rd.forward(request, response);
            } else {
                // Check if the user exists in the studentinfo table
                PreparedStatement psStudentInfo = con.prepareStatement("SELECT studentName, rollNumber FROM studentinfo WHERE studentName=? AND rollNumber=? ");
                psStudentInfo.setString(1, username);
                psStudentInfo.setString(2, password);
                ResultSet rsStudentInfo = psStudentInfo.executeQuery();
                
                if (rsStudentInfo.next()) {
                    RequestDispatcher rd = request.getRequestDispatcher("student_dashboard.jsp");
                    rd.forward(request, response);
                } else {
                    out.println("<font color=red size=18 > Login Failed!! <br>");
                    out.println("<a href=login.jsp>Try Again!!</a>");
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.out.print(e);
        }
    }
}
