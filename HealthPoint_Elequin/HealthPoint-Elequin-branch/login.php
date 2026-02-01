<?php
    session_start();
    include("database.php");

    $message = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Get inputs
        $loginInput = mysqli_real_escape_string($conn, $_POST["login"]);
        $password   = $_POST["password"];

        // Query to find user by username OR email
        $query = "SELECT * FROM users 
                WHERE username = '$loginInput' OR UserEmail = '$loginInput'";

        $result = mysqli_query($conn, $query);

        if (mysqli_num_rows($result) == 1) {
            $row = mysqli_fetch_assoc($result);

            // Verify password
            if (password_verify($password, $row["password"])) {

                // Set session variables
                $_SESSION["user_id"] = $row["UserID"];
                $_SESSION["username"] = $row["username"];
                $_SESSION["email"] = $row["UserEmail"];
                $_SESSION["first_name"] = $row["UserFirstName"];
                $_SESSION["last_name"] = $row["UserLastName"];

                // Redirect to dashboard
                header("Location: mainscreen.php");
                exit;

            } else {
                $message = "Invalid password.";
            }
        } else {
            $message = "User not found.";
        }
    }
?>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthPoint | Welcome Back</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body class="d-flex align-items-center justify-content-center bg-light py-4">

    <div class="login-container shadow-lg p-5 text-center">
    <div class="logo-wrapper mx-auto mb-4">
        <img src="src/hp_logo.png" alt="HealthPoint Logo" class="login-logo">
    </div>
    
    <h2 class="fw-bold mb-2" style="color: var(--hp-dark-green)">HealthPoint</h2>
    <p class="text-muted mb-4">Your AI Health Companion</p>

        <form method="POST">
            <div class="mb-3 text-start">
                <label class="form-label ms-2">Username or Email</label>
                <input type="text" name="login" class="form-control rounded-pill border-2 px-3 py-2" 
                placeholder="e.g. HealthKing2026" required>
            </div>

            <div class="mb-4 text-start">
                <label class="form-label ms-2">Password</label>
                <input type="password" name="password" class="form-control rounded-pill border-2 px-3 py-2" 
                placeholder="••••••••" required>
            </div>

            <?php if ($message): ?>
                <div class="alert alert-danger small"><?php echo $message; ?></div>
            <?php endif; ?>

            <button type="submit" class="btn option-card w-100 py-2 mb-3">
                Login
            </button>

            <a href="#" class="text-decoration-none small text-success">Forgot Password?</a>
            <hr class="my-4">
            <p class="small">
                New here?
                <a href="register.php" class="text-success fw-bold text-decoration-none">
                    Create Account
                </a>
            </p>
        </form>
    </div>

</body>
</html>