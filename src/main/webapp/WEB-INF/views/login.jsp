<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- keep header include as before (no backend changes) -->
<jsp:include page="/WEB-INF/views/partials/header.jsp"/>

<html>
<head>
    <title>Login</title>

    <!-- Luxury Font -->
    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&display=swap" rel="stylesheet">

    <style>
        html, body {
            margin: 0 !important;
            padding: 0 !important;
            height: 100%;
            background-color: #0d0d0d;
            box-sizing: border-box;
        }
        *, *::before, *::after { box-sizing: inherit; }

        :root {
            --nav-height: 72px;
        }
        nav.navbar, .navbar {
            position: fixed !important;
            top: 0 !important;
            left: 0 !important;
            right: 0 !important;
            z-index: 99999 !important;
            height: var(--nav-height) !important;
            min-height: var(--nav-height) !important;
            margin: 0 !important;
            padding-top: 0 !important;
            padding-bottom: 0 !important;
            background-color: inherit;
        }

        .navbar .container,
        .navbar .container-fluid,
        header .container,
        header .container-fluid {
            background: transparent !important;
        }

        body > *:not(nav):first-child {
            margin-top: 0 !important;
            padding-top: 0 !important;
        }

        body {
            padding-top: var(--nav-height);
            font-family: Arial, sans-serif;
        }

        .popup-overlay {
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,0.85);
            backdrop-filter: blur(4px);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 99998;
        }
        .popup-box {
            background: #ffffff;
            padding: 30px;
            width: 350px;
            text-align: center;
            border-radius: 12px;
            border: 2px solid #d4af37;
            box-shadow: 0 0 25px rgba(212,175,55,0.7);
        }
        .popup-box img { width: 120px; margin-bottom: 15px; }
        .popup-box h3 { font-family: 'Cinzel', serif; color: #000000; font-size: 1.3rem; margin: 8px 0; }
        .close-popup {
            background-color: #d4af37;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-family: 'Cinzel', serif;
            font-weight: 700;
            cursor: pointer;
        }

        .center-wrapper {
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: calc(100vh - var(--nav-height));
            background-color: #0d0d0d;
            padding: 120px 0 40px 0; /* increased top padding for more gap */
        }

        .login-container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 12px;
            border: 2px solid #d4af37;
            box-shadow: 0 0 20px rgba(212,175,55,0.4);
            width: 400px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .login-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 30px rgba(212,175,55,0.7);
        }

        h2 { font-family: 'Cinzel', serif; font-size: 2rem; color:#000000; margin-bottom: 30px; text-shadow: 0 0 12px rgba(212,175,55,0.7); }

        label { display:block; margin-bottom:6px; color:#333; font-family:'Cinzel', serif; font-weight:700; text-align:left; }
        input[type="email"], input[type="password"] {
            width:100%; padding:12px 10px; margin-bottom:20px; border:1px solid #d4af37; border-radius:8px; background:#fff; color:#333;
        }
        button { width:100%; padding:12px; background:#d4af37; color:#000; border:none; border-radius:8px; font-family:'Cinzel', serif; font-weight:700; cursor:pointer; }
        button:hover { background:#b5952c; transform:scale(1.02); }

        p { color:#ff4d4d; margin-top:8px; }
        a { color:#d4af37; display:inline-block; margin-top:12px; }

        @media (max-width: 480px) {
            :root { --nav-height: 64px; }
            .login-container { width: 92%; padding: 28px; }
            .popup-box { width: 90%; }
        }
    </style>
</head>
<body>

    <div class="popup-overlay" id="popup">
        <div class="popup-box">
            <img src="/assets/images/logo.png" alt="Logo">
            <h3>Sign in to continue shopping</h3>
            <button class="close-popup" onclick="document.getElementById('popup').style.display='none'">Continue</button>
        </div>
    </div>

    <div class="center-wrapper">
        <div class="login-container">
            <h2>Login</h2>

            <form action="login" method="post">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="Enter your email" required>

                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>

                <button type="submit">LOGIN</button>
            </form>

            <p>${error}</p>
            <a href="register">New user? Register</a>
        </div>
    </div>

    <script>
        window.addEventListener('load', function(){});
        document.addEventListener('keydown', function(e){
            if (e.key === 'Escape') {
                var pop = document.getElementById('popup');
                if(pop) pop.style.display = 'none';
            }
        });
    </script>
</body>
</html>