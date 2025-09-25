<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.example.carboncalc.DBUtil" %>
<%@ page session="true" %>

<%
    // 🔐 Session check (redirect if not logged in)
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Integer userId = (Integer) session.getAttribute("userId");
%>

<html>
<head>
    <title>My History - Carbon Footprint Calculator</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- CSS -->
    <link rel="stylesheet" href="style.css">
</head>
<body>
<!-- ================= NAVBAR ================= -->
<div class="navbar">
    <div class="nav-title">Carbon Footprint Calculator</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="history.jsp" class="active">History</a>
        <a href="logout">Logout</a>
    </div>
</div>

<!-- ================= HISTORY CONTENT ================= -->
<div class="page-container">
    <h2 class="page-title">My Calculation History</h2>

    <table class="result-table">
        <thead>
        <tr>
            <th>Date</th>
            <th>Electricity (kg CO₂)</th>
            <th>Fuel (kg CO₂)</th>
            <th>Travel (kg CO₂)</th>
            <th>Waste (kg CO₂)</th>
            <th>Water (kg CO₂)</th>
            <th>Total (kg CO₂)</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (userId != null) {
                try (Connection conn = DBUtil.getConnection()) {
                    String sql = "SELECT electricity, fuel, distance, waste, water, total, created_at " +
                            "FROM history WHERE user_id=? ORDER BY created_at DESC";
                    PreparedStatement ps = conn.prepareStatement(sql);
                    ps.setInt(1, userId);
                    ResultSet rs = ps.executeQuery();

                    boolean hasRecords = false;
                    while (rs.next()) {
                        hasRecords = true;
        %>
        <tr>
            <td><%= rs.getTimestamp("created_at") %></td>
            <td><%= rs.getDouble("electricity") %></td>
            <td><%= rs.getDouble("fuel") %></td>
            <td><%= rs.getDouble("distance") %></td>
            <td><%= rs.getDouble("waste") %></td>
            <td><%= rs.getDouble("water") %></td>
            <td><%= rs.getDouble("total") %></td>
        </tr>
        <%
            }
            if (!hasRecords) {
        %>
        <tr>
            <td colspan="7" style="text-align:center; color:#888;">No history available yet.</td>
        </tr>
        <%
            }
        } catch (Exception e) {
        %>
        <tr>
            <td colspan="7" style="color:red; text-align:center;">
                ⚠ Error loading history: <%= e.getMessage() %>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

<!-- ================= ANIMATION ================= -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>
</body>
</html>
