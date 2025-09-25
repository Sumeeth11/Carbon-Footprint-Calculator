<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Error - Carbon Footprint Calculator</title>

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
    </div>
</div>

<!-- ================= ERROR MESSAGE ================= -->
<div class="page-container">
    <div class="error-box">
        <h2> Oops! Something went wrong.</h2>
        <p>${errorMessage}</p>
        <a href="index.jsp" class="back-link">← Back to Calculator</a>
    </div>
</div>

<!-- ================= FOOTER ================= -->
<div class="footer">
    <p>© 2025 Carbon Footprint Calculator | Built by Sumeeth</p>
</div>

<!-- ================= FADE-IN ANIMATION ================= -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>
</body>
</html>
