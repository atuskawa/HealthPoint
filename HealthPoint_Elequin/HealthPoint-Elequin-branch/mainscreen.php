<?php
session_start();
include("database.php");

// Redirect if user is not logged in
if (!isset($_SESSION["user_id"])) {
    header("Location: login.php");
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HealthPoint | Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="hp-header d-flex justify-content-between align-items-center px-3">
    <div class="circle-icon">Logo</div>

    <h3 class="m-0 fw-bold">
        Welcome, <?php echo htmlspecialchars($_SESSION["first_name"]); ?>
    </h3>

    <div class="circle-icon">
        <?php 
        // User initials
        echo htmlspecialchars(
            strtoupper($_SESSION["first_name"][0] . $_SESSION["last_name"][0])
        ); 
        ?>
    </div>
</header>

<div class="main-wrapper">
    
    <nav class="hp-sidebar nav flex-column nav-pills" id="v-pills-tab" role="tablist">
        <button class="nav-link active" id="consult-tab" data-bs-toggle="pill" data-bs-target="#consult-content" type="button" role="tab">Consult</button>
        <button class="nav-link" id="contact-tab" data-bs-toggle="pill" data-bs-target="#contact-content" type="button" role="tab">Contact Doctor</button>
        <button class="nav-link" id="records-tab" data-bs-toggle="pill" data-bs-target="#records-content" type="button" role="tab">Records</button>
        <button class="nav-link" id="settings-tab" data-bs-toggle="pill" data-bs-target="#settings-content" type="button" role="tab">Settings</button>
    </nav>

    <main class="hp-content">
        <div class="tab-content w-100" id="v-pills-tabContent">
            
            <div class="tab-pane fade show active" id="consult-content" role="tabpanel">
                <div class="container-fluid d-flex flex-column align-items-center">
                    
                    <div class="placeholder-bubble shadow-sm">
                        <div class="alert alert-warning py-2 mb-3" style="border-radius: 20px; font-size: 0.8rem;">
                            ⚠️ <strong>GUESSTIMATE ONLY:</strong> Not a diagnosis. See a doctor.
                        </div>

                        <div id="chat-window">
                            <p><strong>HealthPoint Bot:</strong> What symptom are you experiencing?</p>
                        </div>

                        <div id="ai-loading" class="mt-2 ps-3 d-none text-start">
                            <span class="spinner-grow spinner-grow-sm text-success"></span>
                            <small class="text-muted ms-2">Analyzing symptoms…</small>
                        </div>
                    </div>

                    <div id="option-buttons" class="row justify-content-center g-3 mt-4 w-100" style="max-width: 800px;">
                        <div class="col-md-4">
                            <button class="option-card w-100 py-3" onclick="startConsult('Headache')">Headache</button>
                        </div>
                        <div class="col-md-4">
                            <button class="option-card w-100 py-3" onclick="startConsult('Fever')">Fever</button>
                        </div>
                        <div class="col-md-4">
                            <button class="option-card w-100 py-3" onclick="startConsult('Nausea')">Nausea</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="contact-content" role="tabpanel">
                <div class="placeholder-bubble d-inline-block p-5">Doctor Directory Placeholder</div>
            </div>

            <div class="tab-pane fade" id="records-content" role="tabpanel">
                <div class="placeholder-bubble d-inline-block p-5">Your Medical Records</div>
            </div>

            <div class="tab-pane fade" id="settings-content" role="tabpanel">
                <div class="container-fluid" style="max-width: 600px;">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" value="<?php echo htmlspecialchars($_SESSION['email']); ?>" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Notifications</label>
                        <select class="form-select">
                            <option>All</option>
                            <option>Important only</option>
                            <option>None</option>
                        </select>
                    </div>

                    <a href="login.php" class="btn btn-danger">Logout</a>
                </div>
            </div>

        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="script.js"></script>
</body>
</html>