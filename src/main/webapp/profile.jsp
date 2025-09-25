<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ page import="java.sql.*, com.example.carboncalc.DBUtil" %>
<%
    // ================== Session Check ==================
    Integer userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    if (userId == null || username == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ================== Variables ==================
    String email = "";
    String registeredAt = "";
    int totalCalculations = 0;
    double avgFootprint = 0.0;
    double lastFootprint = 0.0;
    String lastDate = "";
    String trendData = ""; // JSON-like string for chart

    try (Connection conn = DBUtil.getConnection()) {
        // 1️⃣ Fetch User Info
        PreparedStatement ps1 = conn.prepareStatement("SELECT email, created_at FROM users WHERE id=?");
        ps1.setInt(1, userId);
        ResultSet rs1 = ps1.executeQuery();
        if (rs1.next()) {
            email = rs1.getString("email");
            registeredAt = rs1.getTimestamp("created_at").toString();
        }

        // 2️⃣ Total & Average
        PreparedStatement ps2 = conn.prepareStatement("SELECT COUNT(*), AVG(total) FROM history WHERE user_id=?");
        ps2.setInt(1, userId);
        ResultSet rs2 = ps2.executeQuery();
        if (rs2.next()) {
            totalCalculations = rs2.getInt(1);
            avgFootprint = rs2.getDouble(2);
        }

        // 3️⃣ Last Calculation
        PreparedStatement ps3 = conn.prepareStatement(
                "SELECT total, created_at FROM history WHERE user_id=? ORDER BY created_at DESC LIMIT 1");
        ps3.setInt(1, userId);
        ResultSet rs3 = ps3.executeQuery();
        if (rs3.next()) {
            lastFootprint = rs3.getDouble("total");
            lastDate = rs3.getTimestamp("created_at").toString();
        }

        // 4️⃣ Trend Data (last 5 entries)
        PreparedStatement ps4 = conn.prepareStatement(
                "SELECT total, created_at FROM history WHERE user_id=? ORDER BY created_at DESC LIMIT 5");
        ps4.setInt(1, userId);
        ResultSet rs4 = ps4.executeQuery();

        StringBuilder labels = new StringBuilder();
        StringBuilder values = new StringBuilder();
        while (rs4.next()) {
            labels.insert(0, "'" + rs4.getTimestamp("created_at").toString() + "', ");
            values.insert(0, rs4.getDouble("total") + ", ");
        }
        if (labels.length() > 0) {
            trendData = "{ labels: [" + labels.substring(0, labels.length() - 2) +
                    "], values: [" + values.substring(0, values.length() - 2) + "] }";
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // Decide avg color
    String avgColor = "#2ecc71";
    if (avgFootprint > 300) avgColor = "#e74c3c";
    else if (avgFootprint > 200) avgColor = "#f1c40f";
%>

<html>
<head>
    <title>My Profile & Dashboard - Carbon Footprint Calculator</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<!-- ================= NAVBAR ================= -->
<div class="navbar">
    <div class="nav-title">Carbon Footprint Calculator</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="history.jsp">History</a>
        <a href="logout">Logout</a>
    </div>
</div>

<!-- ================= PROFILE INFO ================= -->
<div class="profile-banner">
    <img src="images/display-pic.png" alt="Profile Picture"
         style="width:100px;height:100px;border-radius:50%;border:3px solid #fff;margin-bottom:10px;">

    <h2>👋 Welcome, <%= username %></h2>
    <p><b>Email:</b> <%= email %></p>
    <p><b>Registered On:</b> <%= registeredAt %></p>
</div>

<!-- ================= DASHBOARD ================= -->
<div class="dashboard">
    <!-- Stats -->
    <div class="stats-grid">
        <div class="stat-card">
            <h3><%= totalCalculations %></h3>
            <p>Total Calculations</p>
        </div>
        <div class="stat-card" style="border-top:5px solid <%= avgColor %>;">
            <h3><%= (avgFootprint > 0 ? Math.round(avgFootprint*100.0)/100.0 : 0) %> kg</h3>
            <p>Average Footprint</p>
        </div>
        <div class="stat-card">
            <h3><%= lastFootprint %> kg</h3>
            <p>Last Calculation<br><small><%= lastDate %></small></p>
        </div>
    </div>

    <!-- Trend Chart -->
    <div style="max-width:700px; margin:auto;">
        <canvas id="trendChart"></canvas>
    </div>

    <!-- Quick Links -->
    <div class="quick-links">
        <a href="index.jsp#calculator" class="cta-btn">➕ New Calculation</a>
        <a href="history.jsp" class="cta-btn">📜 View History</a>
        <a href="editprofile.jsp" class="cta-btn">✏️ Edit Profile</a>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<div class="footer">
    <p>© 2025 Carbon Footprint Calculator | Built by Sumeeth, Presidency University</p>
</div>

<!-- ================= CHART JS ================= -->
<script>
    const trendData = <%= (trendData.isEmpty() ? "{labels:[], values:[]}" : trendData) %>;

    new Chart(document.getElementById('trendChart'), {
        type: 'line',
        data: {
            labels: trendData.labels,
            datasets: [{
                label: 'Carbon Footprint (kg)',
                data: trendData.values,
                borderColor: '#27ae60',
                backgroundColor: 'rgba(39, 174, 96, 0.2)',
                fill: true,
                tension: 0.3
            }]
        },
        options: { responsive: true, plugins: { legend: { display: true } } }
    });
</script>
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>
</body>
</html>
