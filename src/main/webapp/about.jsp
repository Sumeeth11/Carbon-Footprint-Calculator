<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>About - Carbon Footprint Calculator</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Project Styles -->
    <link rel="stylesheet" href="style.css">
</head>
<body>

<!-- ================= NAVBAR ================= -->
<div class="navbar">
    <div class="nav-title">Carbon Footprint Calculator</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="index.jsp#calculator">Calculator</a>
        <a href="about.jsp">About</a>
        <a href="tips.jsp">Tips</a>

        <!-- Show login/register OR history/logout based on session -->
        <c:choose>
            <c:when test="${not empty sessionScope.username}">
                <a href="history.jsp">History</a>
                <a href="logout">Logout</a>
            </c:when>
            <c:otherwise>
                <a href="login.jsp">Login</a>
                <a href="register.jsp">Register</a>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- ================= ABOUT CONTENT ================= -->
<div class="page-container">
    <h2 class="page-title">About This Project</h2>

    <div class="about-section">

        <!-- Overview -->
        <div class="about-card">
            <h3>🌍 Overview</h3>
            <p>The Carbon Footprint Calculator is a web-based tool designed to help individuals
                understand and reduce their personal CO₂ emissions. It provides instant calculations,
                visual charts, and eco-friendly suggestions to encourage sustainable living.</p>
        </div>

        <!-- Purpose -->
        <div class="about-card">
            <h3>🎯 Purpose</h3>
            <p>This project was created to spread awareness about personal carbon footprints.
                It helps users measure their emissions, track them over time, and identify actionable
                areas for improvement.</p>
        </div>

        <!-- Technology -->
        <div class="about-card">
            <h3>💻 Technology Stack</h3>
            <ul>
                <li>Java Servlets & JSP (Backend)</li>
                <li>MySQL (Database)</li>
                <li>HTML, CSS, JavaScript (Frontend)</li>
                <li>Chart.js (Data Visualization)</li>
                <li>Apache Tomcat (Server)</li>
            </ul>
        </div>

        <!-- Developer -->
        <div class="about-card">
            <h3>👨‍💻 Developer</h3>
            <p>This project was created independently by <b>Sumeeth</b> as a self-initiated project,
                demonstrating full-stack development skills.</p>
            <ul>
                <li>Designed a user-friendly and responsive interface</li>
                <li>Developed structured workflow: input → calculation → visualization → insights</li>
                <li>Implemented login, history tracking, and profile dashboard</li>
            </ul>
        </div>

        <!-- Achievements -->
        <div class="about-card">
            <h3>🏆 Achievements</h3>
            <p>✔ Real-time carbon footprint calculations<br>
                ✔ Secure login, registration, and history tracking<br>
                ✔ Interactive charts for data insights<br>
                ✔ Clean UI and responsive design</p>
        </div>

        <!-- Future Enhancements -->
        <div class="about-card">
            <h3>🚀 Future Enhancements</h3>
            <ul>
                <li>Advanced dashboard with long-term trends</li>
                <li>Export results as downloadable PDF/CSV</li>
                <li>AI-powered personalized eco-tips</li>
                <li>Community leaderboard to compare footprints</li>
                <li>Mobile app for Android/iOS</li>
            </ul>
        </div>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<div class="footer">
    <p>© 2025 Carbon Footprint Calculator | Built by Sumeeth</p>
</div>

<!-- Fade-in Animation -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>
</body>
</html>
