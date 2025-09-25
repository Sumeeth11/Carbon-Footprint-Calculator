<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%
    // Redirect if user not logged in
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Carbon Footprint Result</title>

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

<!-- ================= RESULT PAGE ================= -->
<div class="page-container">
    <h2 class="page-title">Your Carbon Footprint Results</h2>

    <!-- Dashboard Layout -->
    <div class="result-dashboard">

        <!-- ===== Detailed Breakdown Card ===== -->
        <div class="result-card">
            <h3 class="section-title">Detailed Breakdown</h3>
            <table class="result-table">
                <tr>
                    <th>Source</th>
                    <th>Emissions (kg CO₂)</th>
                    <th>Share (%)</th>
                </tr>
                <tr>
                    <td>⚡ Electricity</td>
                    <td>${electricityEmissions}</td>
                    <td><%= (Double)request.getAttribute("electricityEmissions") * 100 / (Double)request.getAttribute("totalFootprint") %></td>
                </tr>
                <tr>
                    <td>⛽ Fuel</td>
                    <td>${fuelEmissions}</td>
                    <td><%= (Double)request.getAttribute("fuelEmissions") * 100 / (Double)request.getAttribute("totalFootprint") %></td>
                </tr>
                <tr>
                    <td>🚗 Travel</td>
                    <td>${distanceEmissions}</td>
                    <td><%= (Double)request.getAttribute("distanceEmissions") * 100 / (Double)request.getAttribute("totalFootprint") %></td>
                </tr>
                <tr>
                    <td>🗑 Waste</td>
                    <td>${wasteEmissions}</td>
                    <td><%= (Double)request.getAttribute("wasteEmissions") * 100 / (Double)request.getAttribute("totalFootprint") %></td>
                </tr>
                <tr>
                    <td>💧 Water</td>
                    <td>${waterEmissions}</td>
                    <td><%= (Double)request.getAttribute("waterEmissions") * 100 / (Double)request.getAttribute("totalFootprint") %></td>
                </tr>
                <tr>
                    <th>Total</th>
                    <th>${totalFootprint}</th>
                    <th>100%</th>
                </tr>
            </table>

            <!-- Key Highlights -->
            <div class="result-highlights">
                <h4>Key Highlights</h4>
                <ul>
                    <li>🌍 <b>Largest Contributor:</b>
                        <c:choose>
                            <c:when test="${electricityEmissions >= fuelEmissions && electricityEmissions >= distanceEmissions && electricityEmissions >= wasteEmissions && electricityEmissions >= waterEmissions}">
                                Electricity
                            </c:when>
                            <c:when test="${fuelEmissions >= electricityEmissions && fuelEmissions >= distanceEmissions && fuelEmissions >= wasteEmissions && fuelEmissions >= waterEmissions}">
                                Fuel
                            </c:when>
                            <c:when test="${wasteEmissions >= electricityEmissions && wasteEmissions >= fuelEmissions && wasteEmissions >= distanceEmissions && wasteEmissions >= waterEmissions}">
                                Waste
                            </c:when>
                            <c:when test="${waterEmissions >= electricityEmissions && waterEmissions >= fuelEmissions && waterEmissions >= distanceEmissions && waterEmissions >= wasteEmissions}">
                                Water
                            </c:when>
                            <c:otherwise>Travel</c:otherwise>
                        </c:choose>
                    </li>
                    <li>📉 <b>Smallest Contributor:</b>
                        <c:choose>
                            <c:when test="${electricityEmissions <= fuelEmissions && electricityEmissions <= distanceEmissions && electricityEmissions <= wasteEmissions && electricityEmissions <= waterEmissions}">
                                Electricity
                            </c:when>
                            <c:when test="${fuelEmissions <= electricityEmissions && fuelEmissions <= distanceEmissions && fuelEmissions <= wasteEmissions && fuelEmissions <= waterEmissions}">
                                Fuel
                            </c:when>
                            <c:when test="${wasteEmissions <= electricityEmissions && wasteEmissions <= fuelEmissions && wasteEmissions <= distanceEmissions && wasteEmissions <= waterEmissions}">
                                Waste
                            </c:when>
                            <c:when test="${waterEmissions <= electricityEmissions && waterEmissions <= fuelEmissions && waterEmissions <= distanceEmissions && waterEmissions <= wasteEmissions}">
                                Water
                            </c:when>
                            <c:otherwise>Travel</c:otherwise>
                        </c:choose>
                    </li>
                    <li>⚖️ <b>Average per Category:</b>
                        <%= (Double)request.getAttribute("totalFootprint") / 5 %> kg CO₂
                    </li>
                </ul>
            </div>

            <!-- Personal Insights -->
            <div class="result-insights">
                <h4>Personal Insights</h4>
                <p>
                    <b>Efficiency Score:</b>
                    <%
                        double total = (Double)request.getAttribute("totalFootprint");
                        int score = 100;
                        String scoreColor = "#2ecc71"; // green
                        if (total > 500) { score = 40; scoreColor = "#e74c3c"; }
                        else if (total > 200) { score = 70; scoreColor = "#f1c40f"; }
                        else { score = 90; scoreColor = "#2ecc71"; }
                    %>
                    <span style="background:<%=scoreColor%>;color:white;padding:4px 10px;border-radius:20px;font-weight:bold;">
                        <%= score %>/100
                    </span>
                </p>

                <p>
                    <b>Equivalent Impact:</b><br>
                    🚗 Driving about <%= Math.round(total / 0.12) %> km OR <br>
                    🌳 Planting <%= Math.round(total / 21) %> trees for a year
                </p>
            </div>
        </div>

        <!-- ===== Charts Card ===== -->
        <div class="result-card chart-box">
            <h3 class="section-title">Visual Insights</h3>
            <canvas id="emissionPie" width="350" height="350"></canvas>
            <canvas id="emissionBar" width="350" height="350" style="margin-top:20px;"></canvas>
        </div>
    </div>

    <!-- ===== Summary ===== -->
    <div class="result-summary">
        <b>Summary:</b>
        <c:choose>
            <c:when test="${totalFootprint < 200}">
                Your footprint is <b>low</b>. Great job! Keep up the eco-friendly habits.
            </c:when>
            <c:when test="${totalFootprint < 500}">
                Your footprint is <b>moderate</b>. Consider reducing car travel and saving energy.
            </c:when>
            <c:otherwise>
                Your footprint is <b>high</b>. Try using public transport, renewables, and reducing fuel usage.
            </c:otherwise>
        </c:choose>
    </div>

    <!-- ===== Comparison ===== -->
    <div class="result-comparison">
        <b>Comparison:</b>
        <p>${comparisonMessage}</p>
    </div>

    <!-- ===== Progress Bar ===== -->
    <div class="result-progress">
        <h3 class="section-title">Your Footprint Level</h3>
        <div class="progress-wrapper">
            <div class="progress-label">${totalFootprint} kg CO₂</div>
            <div class="progress-container">
                <div class="progress-bar" style="width:${totalFootprint/5}%; max-width:100%; background:${progressColor};"></div>
            </div>
        </div>
    </div>

    <!-- ===== Suggestions ===== -->
    <div class="result-summary">
        <h3 class="section-title">Top Suggestions</h3>
        <c:choose>
            <c:when test="${electricityEmissions > fuelEmissions && electricityEmissions > distanceEmissions && electricityEmissions > wasteEmissions && electricityEmissions > waterEmissions}">
                <p>⚡ Electricity is your biggest contributor. Switch to LED bulbs, unplug devices, and try solar energy.</p>
            </c:when>
            <c:when test="${fuelEmissions > electricityEmissions && fuelEmissions > distanceEmissions && fuelEmissions > wasteEmissions && fuelEmissions > waterEmissions}">
                <p>⛽ Fuel is your biggest contributor. Consider carpooling, using public transport, or switching to EVs.</p>
            </c:when>
            <c:when test="${wasteEmissions > electricityEmissions && wasteEmissions > fuelEmissions && wasteEmissions > distanceEmissions && wasteEmissions > waterEmissions}">
                <p>🗑 Waste is your biggest contributor. Reduce, reuse, recycle and compost organic waste.</p>
            </c:when>
            <c:when test="${waterEmissions > electricityEmissions && waterEmissions > fuelEmissions && waterEmissions > distanceEmissions && waterEmissions > wasteEmissions}">
                <p>💧 Water usage is your biggest contributor. Conserve water with low-flow taps and mindful usage.</p>
            </c:when>
            <c:otherwise>
                <p>🚗 Travel is your biggest contributor. Try cycling, walking short distances, or reducing car trips.</p>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Back Link -->
    <a href="index.jsp" class="back-link">← Back to Calculator</a>
</div>

<!-- ================= CHARTS ================= -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    // Pie Chart
    new Chart(document.getElementById('emissionPie'), {
        type: 'pie',
        data: {
            labels: ['Electricity', 'Fuel', 'Travel', 'Waste', 'Water'],
            datasets: [{
                data: [${electricityEmissions}, ${fuelEmissions}, ${distanceEmissions}, ${wasteEmissions}, ${waterEmissions}],
                backgroundColor: ['#3498db', '#e74c3c', '#2ecc71', '#9b59b6', '#f1c40f']
            }]
        },
        options: { plugins: { legend: { position: 'bottom' } } }
    });

    // Bar Chart
    new Chart(document.getElementById('emissionBar'), {
        type: 'bar',
        data: {
            labels: ['Electricity', 'Fuel', 'Travel', 'Waste', 'Water'],
            datasets: [{
                label: 'Emissions (kg CO₂)',
                data: [${electricityEmissions}, ${fuelEmissions}, ${distanceEmissions}, ${wasteEmissions}, ${waterEmissions}],
                backgroundColor: ['#3498db', '#e74c3c', '#2ecc71', '#9b59b6', '#f1c40f']
            }]
        },
        options: {
            responsive: true,
            plugins: { legend: { display: false } },
            scales: { y: { beginAtZero: true } }
        }
    });
</script>

<!-- Fade-in Animation -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>
</body>
</html>
