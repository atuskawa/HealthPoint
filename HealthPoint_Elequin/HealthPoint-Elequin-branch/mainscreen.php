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
    <div class="d-flex align-items-center gap-2">
        <button id="sidebarToggle" class="menu-btn btn btn-light" aria-label="Toggle sidebar">☰</button>
        <img src="src/hp_logo.png" alt="HealthPoint Logo" class="header-logo">
    </div>

    <div class="d-flex align-items-center gap-3">
        <h3 class="m-0 welcome-text">
            Hi, <?php echo htmlspecialchars($_SESSION["first_name"]); ?>
        </h3>

        <div class="circle-icon">
            <?php 
            // User initials
            echo htmlspecialchars(
                strtoupper($_SESSION["first_name"][0] . $_SESSION["last_name"][0])
            ); 
            ?>
        </div>
    </div>
</header>

<div class="main-wrapper">
    
    <nav class="hp-sidebar nav flex-column nav-pills" id="v-pills-tab" role="tablist">
        <button class="nav-link active d-flex align-items-center" id="consult-tab" data-bs-toggle="pill" data-bs-target="#consult-content" type="button" role="tab" title="Consult">
            <span class="nav-icon">💬</span>
            <span class="nav-label ms-2">Consult</span>
        </button>
        <button class="nav-link d-flex align-items-center" id="contact-tab" data-bs-toggle="pill" data-bs-target="#contact-content" type="button" role="tab" title="Contact Doctor">
            <span class="nav-icon">🩺</span>
            <span class="nav-label ms-2">Contact Doctor</span>
        </button>
        <button class="nav-link d-flex align-items-center" id="records-tab" data-bs-toggle="pill" data-bs-target="#records-content" type="button" role="tab" title="Records">
            <span class="nav-icon">🗂️</span>
            <span class="nav-label ms-2">Records</span>
        </button>
        <button class="nav-link d-flex align-items-center" id="settings-tab" data-bs-toggle="pill" data-bs-target="#settings-content" type="button" role="tab" title="Settings">
            <span class="nav-icon">⚙️</span>
            <span class="nav-label ms-2">Settings</span>
        </button>
    </nav>

    <main class="hp-content">
        <div class="tab-content w-100" id="v-pills-tabContent">
            
            <div class="tab-pane fade show active" id="consult-content" role="tabpanel">
                <div class="container-fluid d-flex flex-column align-items-center">
                    
                    <div class="placeholder-bubble shadow-sm">
                        <div class="alert alert-warning py-2 mb-3" style="border-radius: 20px; font-size: 0.8rem;">
                            ⚠️ <strong>GUESSTIMATE ONLY:</strong> This is not a Dignosis, Please book a Doctor for a proper consultation.
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
                <div class="scrollable-content">
                    <div class="container-fluid" style="max-width: 900px;">
                        <h3 class="mb-4" style="color: var(--hp-dark-green);">Available Doctors</h3>
                        <div class="row g-4">
                        <?php
                            $query = "SELECT * FROM doctors ORDER BY Rating DESC";
                            $result = mysqli_query($conn, $query);
                            
                            while ($doctor = mysqli_fetch_assoc($result)) {
                                $initials = strtoupper($doctor['DoctorFirstName'][0] . $doctor['DoctorLastName'][0]);
                                $fullName = $doctor['DoctorFirstName'] . ' ' . $doctor['DoctorLastName'];
                                $isAvailable = strpos(strtolower($doctor['AvailabilityStatus']), 'available now') !== false ? 'online' : '';
                        ?>
                        <div class="col-md-6">
                            <div class="doctor-card">
                                <div class="doctor-header">
                                    <div class="doctor-avatar"><?php echo $initials; ?></div>
                                    <div class="doctor-status <?php echo $isAvailable; ?>"></div>
                                </div>
                                <h5 class="doctor-name">Dr. <?php echo htmlspecialchars($fullName); ?></h5>
                                <p class="doctor-specialty"><?php echo htmlspecialchars($doctor['Specialization']); ?></p>
                                <div class="doctor-rating mb-2">⭐ <?php echo $doctor['Rating']; ?> (<?php echo $doctor['ReviewCount']; ?> reviews)</div>
                                <p class="doctor-availability"><?php echo htmlspecialchars($doctor['AvailabilityStatus']); ?></p>
                                <button class="btn option-card w-100 py-2">Book Appointment</button>
                            </div>
                        </div>
                        <?php
                            }
                        ?>
                        </div>
                    </div>
                </div>
            </div>

            <div class="tab-pane fade" id="records-content" role="tabpanel">
                <div class="scrollable-content">
                    <div class="container-fluid" style="max-width: 900px;">
                        <h3 class="mb-4" style="color: var(--hp-dark-green);">Consultation History</h3>
                        <div class="records-timeline">
                        <div class="record-item">
                            <div class="record-date">Jan 28, 2026</div>
                            <div class="record-card">
                                <h6 class="record-title">Headache Consultation</h6>
                                <p class="record-doctor"><strong>Dr. Amanda Silva</strong> - General Practitioner</p>
                                <p class="record-symptoms"><strong>Symptoms:</strong> Headache, Fatigue</p>
                                <p class="record-diagnosis"><strong>Assessment:</strong> Tension headache, advised rest and hydration</p>
                                <a href="#" class="record-link">Download PDF</a>
                            </div>
                        </div>
                        <div class="record-item">
                            <div class="record-date">Jan 15, 2026</div>
                            <div class="record-card">
                                <h6 class="record-title">General Checkup</h6>
                                <p class="record-doctor"><strong>Dr. Amanda Silva</strong> - General Practitioner</p>
                                <p class="record-symptoms"><strong>Symptoms:</strong> Routine checkup</p>
                                <p class="record-diagnosis"><strong>Assessment:</strong> All vitals normal, healthy overall</p>
                                <a href="#" class="record-link">Download PDF</a>
                            </div>
                        </div>
                        <div class="record-item">
                            <div class="record-date">Dec 20, 2025</div>
                            <div class="record-card">
                                <h6 class="record-title">Allergy Assessment</h6>
                                <p class="record-doctor"><strong>Dr. James Kumar</strong> - Allergist</p>
                                <p class="record-symptoms"><strong>Symptoms:</strong> Sneezing, Itchy eyes</p>
                                <p class="record-diagnosis"><strong>Assessment:</strong> Seasonal allergies, prescribed antihistamines</p>
                                <a href="#" class="record-link">Download PDF</a>
                            </div>
                        </div>
                    </div>
                </div>
                </div>
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