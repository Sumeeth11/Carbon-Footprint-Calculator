<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Carbon Footprint Calculator</title>

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="images/favicon.ico">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Font Awesome (for icons) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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

<!-- Profile Button (top-right corner) -->
<div class="profile-link">
    <a href="profile.jsp" class="btn-profile"><i class="fa-solid fa-user"></i></a>
</div>

<!-- Welcome Banner (only visible when logged in) -->
<c:if test="${not empty sessionScope.username}">
    <div class="welcome-banner">
        Welcome back, ${sessionScope.username}
    </div>
</c:if>

<!-- ================= HERO SECTION ================= -->
<div class="hero">
    <h1>Track. Understand. Reduce 🌱</h1>
    <p>
        Enter your electricity, fuel, and travel usage to estimate your CO₂ emissions.<br>
        Take control of your impact and explore ways to live more sustainably.
    </p>
    <a href="#calculator" class="cta-btn">Start Calculating</a>
</div>

<!-- ================= FEATURES ================= -->
<div class="features">
    <h2>Why Use This Calculator?</h2>
    <div class="feature-grid">
        <div class="feature-card">✔ Estimate your monthly carbon footprint.</div>
        <div class="feature-card">✔ Identify major emission sources.</div>
        <div class="feature-card">✔ Get personalized eco-tips.</div>
        <div class="feature-card">✔ Visualize your data with charts.</div>
    </div>
</div>

<!-- ================= HOW IT WORKS ================= -->
<div class="how-it-works">
    <h2>How It Works</h2>
    <div class="steps">
        <div class="step">① Enter your usage data</div>
        <div class="step">② We calculate your CO₂ emissions</div>
        <div class="step">③ View results in tables & charts</div>
        <div class="step">④ Get tips to reduce your footprint</div>
    </div>
</div>

<!-- ================= DID YOU KNOW ================= -->
<div class="did-you-know">
    <h2>Did You Know? </h2>
    <ul>
        <li> 1 kWh of electricity emits about <b>0.85 kg CO₂</b>.</li>
        <li> 1 liter of petrol produces about <b>2.31 kg CO₂</b>.</li>
        <li> Driving 1 km in an average car emits about <b>0.12 kg CO₂</b>.</li>
        <li> Planting 1 tree absorbs roughly <b>21 kg CO₂ per year</b>.</li>
    </ul>
</div>

<!-- ================= MAIN SECTION: Calculator ================= -->
<div class="main-section" id="calculator">
    <!-- Image -->
    <div class="image-box">
        <img src="images/climate-change.png" alt="Eco Earth">
    </div>

    <!-- Calculator Form -->
    <div class="form-box container">
        <h2>Calculate Your Footprint</h2>
        <form action="calculate" method="post">
            <label>Electricity Usage (kWh per month):</label>
            <input type="number" name="electricity" min="0" step="0.01" required>

            <label>Fuel Consumption (liters per month):</label>
            <input type="number" name="fuel" min="0" step="0.01" required>

            <label>Travel Distance (km per month):</label>
            <input type="number" name="distance" min="0" step="0.01" required>

            <label>Waste Generated (kg per month):</label>
            <input type="number" name="waste" min="0" step="0.01" required>

            <label>Water Usage (litres per month):</label>
            <input type="number" name="water" min="0" step="0.01" required>

            <input type="submit" value="Calculate Footprint">
        </form>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<div class="footer">
    <p>© 2025 Carbon Footprint Calculator | Built by Sumeeth</p>
</div>

<!-- Fade-in Effect Script -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>

</body>
</html>
