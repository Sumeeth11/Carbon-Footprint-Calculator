<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, com.example.carboncalc.DBUtil" %>

<%
    // 🔐 Session validation
    Integer userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    if (userId == null || username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 📩 Fetch user email
    String email = "";
    try (Connection conn = DBUtil.getConnection()) {
        PreparedStatement ps = conn.prepareStatement("SELECT email FROM users WHERE id=?");
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            email = rs.getString("email");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<html>
<head>
    <title>Edit Profile - Carbon Footprint Calculator</title>

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
        <a href="profile.jsp">Profile</a>
        <a href="logout">Logout</a>
    </div>
</div>

<!-- ================= EDIT PROFILE ================= -->
<div class="page-container">
    <h2 class="page-title">Edit Profile</h2>

    <div class="editprofile-box">
        <form action="editProfile" method="post">
            <!-- Username -->
            <label>Username:</label>
            <input type="text" name="username" value="<%= username %>" required>

            <!-- Email -->
            <label>Email:</label>
            <input type="email" name="email" value="<%= email %>" required>

            <!-- Password -->
            <label>New Password:</label>
            <input type="password" name="password" placeholder="Enter new password">

            <!-- Submit -->
            <button type="submit" class="btn-update">Update Profile</button>
        </form>
    </div>
</div>

<!-- ================= FADE-IN ANIMATION ================= -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>
</body>
</html>
