<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Register - Carbon Footprint Calculator</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Project Styles -->
    <link rel="stylesheet" href="style.css">
</head>
<body class="register-page">

<!-- ================= NAVBAR ================= -->
<div class="navbar">
    <div class="nav-title">Carbon Footprint Calculator</div>
    <div class="nav-links">
        <a href="index.jsp">Home</a>
        <a href="login.jsp">Login</a>
    </div>
</div>

<!-- ================= REGISTER FORM ================= -->
<div class="register-container">
    <h2 class="register-title">Register</h2>

    <!-- Success message -->
    <c:if test="${not empty message}">
        <p class="msg-success">${message}</p>
    </c:if>

    <!-- Error message -->
    <c:if test="${not empty errorMessage}">
        <p class="msg-error">${errorMessage}</p>
    </c:if>

    <!-- Register Box -->
    <div class="register-box">
        <form action="register" method="post">
            <label>Username:</label>
            <input type="text" name="username" required>

            <label>Email:</label>
            <input type="email" name="email" required>

            <label>Password:</label>
            <input type="password" name="password" required>

            <button type="submit" class="btn-register">Register</button>
        </form>
    </div>

    <!-- Login Link -->
    <p class="register-footer">
        Already have an account? <a href="login.jsp">Login here</a>.
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
