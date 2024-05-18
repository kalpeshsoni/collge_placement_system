<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="admin_panel.css"> <!-- Updated CSS reference -->
</head>
<body>
    <div class="container">
        <div class="sidebar">
            <h2>Dashboard Menu</h2>
            <ul>
                <li><a href="#">Dashboard</a></li>
                <li><a href="#">Students</a></li>
                <li><a href="#">HODs</a></li>
                <li><a href="#">Companies</a></li>
                <li><a href="#">Openings</a></li>
                <li><a href="#">Selected Students</a></li>
                <li><a href="#">College Info</a></li>
                <li><a href="#" id="changePasswordBtn">Change Password</a></li>
                <li><a href="#">Logout</a></li>
            </ul>
        </div>
        <div class="main-content">
            <h1>Placement Portal - Admin Dashboard</h1>
            <div class="dashboard-info">
                <%  
                    String url = "jdbc:mysql://localhost:3306/21bcon121";
                    String username = "root";
                    String password = "7410";

                    try (Connection con = DriverManager.getConnection(url, username, password)) {
                        String query1 = "SELECT COUNT(id) AS row_count FROM students";
                        String query2 = "SELECT COUNT(id) AS row_count FROM placed_students";
                        String query3 = "SELECT COUNT(id) AS row_count FROM companies";
                        String query4 = "SELECT COUNT(username) AS row_count FROM student";
                        Statement stmt = con.createStatement();
                        
                        // Query for Students count
                        ResultSet rs = stmt.executeQuery(query1);
                        if (rs.next()) {
                            int rowCount1 = rs.getInt("row_count");
                %>
                        <div class="info-item">
                            <a href="students_details.jsp"><button>Students (<%= rowCount1 %>)</button></a>
                        </div>
                <%
                        }
                        
                        // Query for Placed Students count
                        ResultSet rs2 = stmt.executeQuery(query2);
                        if (rs2.next()) {
                            int rowCount2 = rs2.getInt("row_count");
                %>
                        <div class="info-item">
                            <a href="placed_students.jsp"><button>Placed (<%= rowCount2 %>)</button></a>
                        </div>
                 <%
                        }
                        
                        // Query for Companies count
                        ResultSet rs3 = stmt.executeQuery(query3);
                        if (rs3.next()) {
                            int rowCount3 = rs3.getInt("row_count");
                %>
                    
                    <div class="info-item">
                        <a href="company_details.jsp"><button>Companies (<%= rowCount3 %>)</button></a>
                    </div>
                <%
                        }

                        // Query for fourth count (let's assume it's for something else)
                        ResultSet rs4 = stmt.executeQuery(query4);
                        if (rs4.next()) {
                            int rowCount4 = rs4.getInt("row_count");
                %>
                        <div class="info-item">
                            <a href="student_dashboard.jsp"><button>Students (<%= rowCount4 %>)</button></a>
                            <button>HODs</button>
                        </div>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();    
                    }
                %>
                <!-- You can add more info-items here -->
            </div>
            <p>Welcome! Administrator</p>
        </div>
    </div>
</body>
</html>

<!-- Include the modal HTML code -->
<!-- Add this modal HTML at the end of your admin_panel.jsp file -->
<div id="changePasswordModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <h2>Change Password</h2>
    <form id="changePasswordForm">
      <input type="text" id="username" placeholder="Username" required>
      <input type="password" id="oldPassword" placeholder="Old Password" required>
      <input type="password" id="newPassword" placeholder="New Password" required>
      <button type="submit">Change Password</button>
    </form>
  </div>
</div>
