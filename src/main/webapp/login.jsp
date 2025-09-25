<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Login - Carbon Footprint Calculator</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Project Styles -->
    <link rel="stylesheet" href="style.css">
</head>
<body class="login-page">

<!-- ================= NAVBAR ================= -->
<div class="navbar">
    <div class="nav-title">Carbon Footprint Calculator</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="register.jsp">Register</a>
    </div>
</div>

<!-- ================= LOGIN FORM ================= -->
<div class="login-container">
    <h2 class="login-title">Login</h2>

    <!-- Success message -->
    <c:if test="${not empty message}">
        <p class="msg-success">${message}</p>
    </c:if>

    <!-- Error message -->
    <c:if test="${not empty errorMessage}">
        <p class="msg-error">${errorMessage}</p>
    </c:if>

    <!-- Login Box -->
    <div class="login-box">
        <form action="login" method="post">
            <label>Email:</label>
            <input type="email" name="email" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <button type="submit" class="btn-login">Login</button>
        </form>
    </div>

    <!-- Register Link -->
    <p class="login-footer">
        Don’t have an account? <a href="register.jsp">Register here</a>.
    </p>
</div>

<!-- ================= FADE-IN EFFECT ================= -->
<script>
    window.addEventListener("load", () => {
        document.body.classList.add("fade-in");
    });
</script>

</body>
</html>
