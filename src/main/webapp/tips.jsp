<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    // Redirect if user not logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Eco Tips - Carbon Footprint Calculator</title>

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
        <a href="index.jsp#calculator">Calculator</a>
        <a href="about.jsp">About</a>
        <a href="tips.jsp">Tips</a>

        <!-- Show login/register OR welcome/logout based on session -->
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

<!-- ================= TIPS PAGE ================= -->
<div class="page-container">

    <!-- ===== Benchmark Section ===== -->
    <div class="tips-section">
        <h2>What’s a Good vs. High Usage?</h2>
        <p>Here are reference values for a typical household. Compare your monthly usage to see if it’s Good, Average, or High:</p>

        <div class="tips-grid">
            <div class="tip-card good-usage">
                <h3>⚡ Electricity (kWh / month)</h3>
                <ul>
                    <li>Good: Less than <b>100 kWh</b></li>
                    <li>Average: <b>100 – 300 kWh</b></li>
                    <li>High: More than <b>300 kWh</b></li>
                </ul>
            </div>

            <div class="tip-card good-usage">
                <h3>⛽ Fuel (liters / month)</h3>
                <ul>
                    <li>Good: Less than <b>20 L</b></li>
                    <li>Average: <b>20 – 50 L</b></li>
                    <li>High: More than <b>50 L</b></li>
                </ul>
            </div>

            <div class="tip-card good-usage">
                <h3>🚗 Travel (km / month)</h3>
                <ul>
                    <li>Good: Less than <b>100 km</b></li>
                    <li>Average: <b>100 – 300 km</b></li>
                    <li>High: More than <b>300 km</b></li>
                </ul>
            </div>

            <div class="tip-card good-usage">
                <h3>🗑 Waste (kg / month)</h3>
                <ul>
                    <li>Good: Less than <b>20 kg</b></li>
                    <li>Average: <b>20 – 50 kg</b></li>
                    <li>High: More than <b>50 kg</b></li>
                </ul>
            </div>

            <div class="tip-card good-usage">
                <h3>💧 Water (liters / month)</h3>
                <ul>
                    <li>Good: Less than <b>1,000 L</b></li>
                    <li>Average: <b>1,000 – 3,000 L</b></li>
                    <li>High: More than <b>3,000 L</b></li>
                </ul>
            </div>
        </div>
    </div>

    <hr class="divider">

    <!-- ===== Eco Tips Section ===== -->
    <h2 class="page-title">Eco-Friendly Tips 🌱</h2>
    <div class="tips-grid">
        <div class="tip-card">
            <h3>💡 Save Electricity</h3>
            <p>Switch to LED bulbs, unplug unused devices, and maximize natural light. Using solar energy can reduce CO₂ emissions by 30–40%.</p>
        </div>
        <div class="tip-card">
            <h3>⛽ Reduce Fuel Use</h3>
            <p>Carpool, use public transport, or cycle for short distances. Driving less saves money and reduces air pollution.</p>
        </div>
        <div class="tip-card">
            <h3>♻ Waste Management</h3>
            <p>Recycle plastics, compost organic waste, and avoid single-use products. Every recycled plastic bottle saves enough energy to power a 60W bulb for 3 hours.</p>
        </div>
        <div class="tip-card">
            <h3>🚰 Conserve Water</h3>
            <p>Fix leaks, take shorter showers, and install water-saving taps. Conserving water also reduces the energy needed for treatment and heating.</p>
        </div>
        <div class="tip-card">
            <h3>🌱 Lifestyle Choices</h3>
            <p>Plant trees, shift to more plant-based meals, and shop locally. A single tree absorbs around 21 kg of CO₂ per year.</p>
        </div>
        <div class="tip-card">
            <h3>🏠 Smart Home</h3>
            <p>Use energy-efficient appliances, insulate your home, and set thermostats wisely. Smart thermostats can cut heating/cooling bills by up to 15%.</p>
        </div>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<div class="footer">
    <p>© 2025 Carbon Footprint Calculator | Built by Sumeeth, Presidency University</p>
</div>

<!-- Fade-in Animation -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>
</body>
</html>
