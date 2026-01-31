<?php
    session_start();
    include("database.php");

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

<header class="hp-header">
    <div class="circle-icon">Logo</div>
    <h3 class="m-0 fw-bold">HealthPoint</h3>
    <div class="circle-icon">User</div>
</header>

<div class="main-wrapper">
    <nav class="hp-sidebar nav nav-pills flex-column" role="tablist">
    <button class="nav-link active" id="consult-tab" data-bs-toggle="pill" data-bs-target="#consult" type="button" role="tab">Consult</button>
    <button class="nav-link" id="contact-tab" data-bs-toggle="pill" data-bs-target="#contact" type="button" role="tab">Contact Doctor</button>
    <button class="nav-link" id="records-tab" data-bs-toggle="pill" data-bs-target="#records" type="button" role="tab">Records</button>
    <button class="nav-link" id="settings-tab" data-bs-toggle="pill" data-bs-target="#settings" type="button" role="tab">Settings</button>
</nav>


    <main class="hp-content">
        <div class="tab-content w-100">

            <!-- CONSULT -->
            <div class="tab-pane fade show active" id="consult" role="tabpanel">
                <div class="container-fluid text-center">
                    <div class="placeholder-bubble shadow-sm p-4 mx-auto mb-4" style="max-width: 800px;">
                        <div class="alert alert-warning py-2 mb-3" style="border-radius: 20px; font-size: 0.8rem;">
                            ⚠️ <strong>GUESSTIMATE ONLY:</strong> Not a diagnosis. See a doctor.
                        </div>

                        <div id="chat-window" class="p-3 text-start">
                            <p><strong>HealthPoint Bot:</strong> What symptom are you experiencing?</p>
                        </div>

                        <div id="ai-loading" class="mt-2 ps-3 d-none text-start">
                            <span class="spinner-grow spinner-grow-sm text-success"></span>
                            <small class="text-muted ms-2">Analyzing symptoms…</small>
                        </div>
                    </div>

                    <div id="option-buttons" class="row justify-content-center g-3">
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

            <!-- CONTACT -->
            <div class="tab-pane fade" id="contact" role="tabpanel">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <div class="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center me-3"
                             style="width:60px;height:60px;">MD</div>
                        <div>
                            <h5>Dr. Nerissa Ravencroft</h5>
                            <small>General Medicine • ⭐ 4.8</small>
                            <p class="m-0">Mon–Fri, 9am–5pm</p>
                        </div>
                        <button class="btn btn-primary ms-auto">Book Appointment</button>
                    </div>
                </div>
            </div>

            <!-- RECORDS -->
            <div class="tab-pane fade" id="records" role="tabpanel">
                <div class="card p-3">
                    <h6>Jan 20, 2026 • Dr. Ravencroft</h6>
                    <p>Symptoms: Fever, Headache</p>
                    <button class="btn btn-sm btn-outline-secondary">Download Record</button>
                </div>
            </div>

            <!-- SETTINGS -->
            <div class="tab-pane fade" id="settings" role="tabpanel">
                <div class="mb-3">
                    <label class="form-label">Email</label>
                    <input type="email" class="form-control" value="user@example.com">
                </div>

                <div class="mb-3">
                    <label class="form-label">Notifications</label>
                    <select class="form-select">
                        <option>All</option>
                        <option>Important only</option>
                        <option>None</option>
                    </select>
                </div>

                <button class="btn btn-danger">Delete Account</button>
            </div>

        </div>
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="script.js"></script>
</body>
</html>
