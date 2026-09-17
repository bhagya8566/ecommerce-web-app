<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
    <title>Register</title>

    <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&display=swap" rel="stylesheet">

    <style>
        /* Wrap everything under a unique wrapper to prevent interfering with navbar */
        .register-page-wrapper {
            font-family: Arial, sans-serif;
            background-color: #000000;
            min-height: calc(100vh - 90px); /* leave space for navbar */
            display: flex;
            justify-content: center;
            align-items: center;
            padding-top: 20px;
        }

        .register-page-wrapper .register-container {
            background-color: #ffffff;
            padding: 40px 30px;
            border-radius: 12px;
            border: 2px solid #d4af37;
            box-shadow: 0 0 20px rgba(212, 175, 55, 0.4);
            width: 400px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .register-page-wrapper .register-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 30px rgba(212, 175, 55, 0.7);
        }

        .register-page-wrapper h2 {
            font-family: 'Cinzel', serif;
            font-weight: 700;
            font-size: 2rem;
            letter-spacing: 1.5px;
            color: #d4af37;
            text-align: center;
            text-shadow: 0 0 12px rgba(212,175,55,0.7);
            margin-bottom: 30px;
        }

        .register-page-wrapper form {
            text-align: left;
        }

        .register-page-wrapper label {
            display: block;
            margin-bottom: 6px;
            color: #333333;
            font-family: 'Cinzel', serif;
            font-weight: 700;
            font-size: 1rem;
        }

        .register-page-wrapper input[type="text"], 
        .register-page-wrapper input[type="email"], 
        .register-page-wrapper input[type="password"] {
            width: 100%;
            padding: 12px 10px;
            margin-bottom: 20px;
            border: 1px solid #d4af37;
            border-radius: 8px;
            background-color: #ffffff;
            color: #333333;
            font-weight: 500;
            box-sizing: border-box;
            transition: border-color 0.3s, box-shadow 0.3s;
        }

        .register-page-wrapper input::placeholder {
            color: rgba(212,175,55,0.6);
        }

        .register-page-wrapper input:focus {
            border-color: #d4af37;
            box-shadow: 0 0 8px rgba(212,175,55,0.5);
            outline: none;
        }

        .register-page-wrapper button {
            width: 100%;
            padding: 12px;
            background-color: #d4af37;
            color: #0d0d0d;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-family: 'Cinzel', serif;
            font-weight: 700;
            transition: background-color 0.3s, transform 0.2s;
        }

        .register-page-wrapper button:hover {
            background-color: #b5952c;
            transform: scale(1.05);
        }

        .register-page-wrapper p {
            font-size: 14px;
            margin: 10px 0;
        }

        .register-page-wrapper a {
            color: #d4af37;
            text-decoration: none;
            font-size: 14px;
        }

        .register-page-wrapper a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

    <!-- Include navbar (header.jsp) -->
    <jsp:include page="/WEB-INF/views/partials/header.jsp" />

    <!-- Register page content scoped inside wrapper -->
    <div class="register-page-wrapper">
        <div class="center-wrapper">
            <div class="register-container">
                <h2>Register</h2>

                <form action="register" method="post">
                    <label>Name</label>
                    <input type="text" name="name" placeholder="Enter your name" required>

                    <label>Email</label>
                    <input type="email" name="email" placeholder="Enter your email" required>

                    <label>Password</label>
                    <input type="password" name="password" placeholder="Enter your password" required>

                    <label>Address</label>
                    <input type="text" name="address" placeholder="Enter your address">

                    <label>Phone</label>
                    <input type="text" name="phone" placeholder="Enter your phone number">

                    <button type="submit">Register</button>
                </form>

                <p style="color:red">${error}</p>
                <p style="color:green">${msg}</p>

                <a href="login">Already registered? Login</a>
            </div>
        </div>
    </div>

</body>
</html>
