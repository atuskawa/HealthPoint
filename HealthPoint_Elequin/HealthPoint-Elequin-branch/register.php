<?php
    include("database.php");

    $message = "";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {

        $firstName = mysqli_real_escape_string($conn, $_POST["first_name"]);
        $midName   = mysqli_real_escape_string($conn, $_POST["middle_name"]);
        $lastName  = mysqli_real_escape_string($conn, $_POST["last_name"]);
        $username  = mysqli_real_escape_string($conn, $_POST["username"]);
        $email = mysqli_real_escape_string($conn, $_POST["email"]);
        $password  = $_POST["password"];
        $confirm   = $_POST["confirm_password"];

        if (empty($firstName) || empty($lastName) || empty($username) || empty($email) || empty($password)) {
            $message = "Please fill in all required fields.";
        } elseif ($password !== $confirm) {
            $message = "Passwords do not match.";
        } else {

            $hashedPassword = password_hash($password, PASSWORD_DEFAULT);

            // Check if username already exists
            $check = "SELECT UserID FROM users WHERE username = '$username' OR UserEmail = '$email'";
            $result = mysqli_query($conn, $check);

            if (mysqli_num_rows($result) > 0) {
                $message = "Username already exists.";
            } else {

                $insert = "INSERT INTO users 
                    (UserFirstName, UserMidName, UserLastName, UserEmail, username, password)
                    VALUES 
                    ('$firstName', '$midName', '$lastName', '$email', '$username', '$hashedPassword')";
                if (mysqli_query($conn, $insert)) {
                    header("Location: login.php");
                    exit;
                } else {
                    $message = "Error creating account." . mysqli_error($conn);
                }
            }
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>HealthPoint | Create Account</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="style.css">
    </head>
    <body class="d-flex align-items-center justify-content-center bg-light py-4">

        <div class="login-container shadow-lg p-5 text-center">
            <h2 class="fw-bold mb-3" style="color: var(--hp-dark-green)">Create Account</h2>

            <form method="POST">
                <div class="mb-3 text-start">
                    <label class="form-label">
                        First Name <span class="required">*</span>
                    </label>
                    <input type="text" name="first_name" class="form-control rounded-pill" required>
                </div>

                <div class="mb-3 text-start">
                    <label class="form-label">Middle Name</label>
                    <input type="text" name="middle_name" class="form-control rounded-pill">
                </div>

                <div class="mb-3 text-start">
                    <label class="form-label">
                        Last Name <span class="required">*</span>
                    </label>
                    <input type="text" name="last_name" class="form-control rounded-pill" required>
                </div>

                <div class="mb-3 text-start">
                    <label class="form-label">
                        Email <span class="required">*</span>
                    </label>
                    <input type="email" name="email" class="form-control rounded-pill" required>
                </div>

                <div class="mb-3 text-start">
                    <label class="form-label">
                        Username <span class="required">*</span>
                    </label>
                    <input type="text" name="username" class="form-control rounded-pill" required>
                </div>

                <div class="mb-3 text-start">
                    <label class="form-label">
                        Password <span class="required">*</span>
                    </label>
                    <input type="password" name="password" class="form-control rounded-pill" required>
                </div>

                <div class="mb-4 text-start">
                    <label class="form-label">
                        Confirm Password <span class="required">*</span>
                    </label>
                    <input type="password" name="confirm_password" class="form-control rounded-pill" required>
                </div>

                <?php if ($message): ?>
                    <div class="alert alert-danger small"><?php echo $message; ?></div>
                <?php endif; ?>

                <button type="submit" class="btn option-card w-100 py-2">
                    Create Account
                </button>
            </form>
        </div>
            <p class="small mt-4 text-center">
                Already have an account?
                <a href="login.php" class="hp-link">
                    Login instead
                </a>
            </p>

    </body>
</html>
