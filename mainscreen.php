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
            
            <!-- CONSULT -->
            <div class="tab-pane fade show active" id="consult-content" role="tabpanel">
                <div class="container-fluid text-center">
                    <div class="placeholder-bubble shadow-sm p-4 mx-auto mb-4" style="max-width: 800px;">
                        <div class="alert alert-warning py-2 mb-3" style="border-radius: 20px; font-size: 0.8rem;">
                            ⚠️ <strong>GUESSTIMATE ONLY:</strong> For real exams, book an appointment.
                        </div>
                        <div id="chat-window" class="p-3 text-start" style="height: 250px; overflow-y: auto; background: rgba(255,255,255,0.4); border-radius: 20px;">
                            <p><strong>HealthPoint Bot:</strong> What symptoms are you feeling today? Click a pill below to begin.</p>
                        </div>
                        <div id="ai-loading" class="mt-2 ps-3 d-none text-start">
                            <span class="spinner-grow spinner-grow-sm text-success"></span>
                            <small class="text-muted ms-2">AI is diagnosing...</small>
                        </div>
                    </div>

                    <div class="row justify-content-center g-3" style="max-width: 900px; margin: 0 auto;">
                        <div class="col-md-4"><button class="option-card w-100 py-3" onclick="mockConsult('Headache')">Headache</button></div>
                        <div class="col-md-4"><button class="option-card w-100 py-3" onclick="mockConsult('Fever')">Fever</button></div>
                        <div class="col-md-4"><button class="option-card w-100 py-3" onclick="mockConsult('Nausea')">Nausea</button></div>
                        <div class="col-md-4"><button class="option-card w-100 py-3" onclick="mockConsult('Cough')">Cough</button></div>
                        <div class="col-md-4"><button class="option-card w-100 py-3" onclick="mockConsult('Fatigue')">Fatigue</button></div>
                        <div class="col-md-4"><button class="option-card w-100 py-3 bg-white text-dark" style="border-style: dashed !important;">Other...</button></div>
                    </div>
                </div>
            </div>

            <!-- CONTACT -->
            <div class="tab-pane fade" id="contact-content" role="tabpanel">
                <div class="placeholder-bubble d-inline-block p-5">Doctor Directory Placeholder</div>
            </div>

            <!-- RECORDS -->
            <div class="tab-pane fade" id="records-content" role="tabpanel">
                <div class="placeholder-bubble d-inline-block p-5">Your Medical Records</div>
            </div>

            <!-- SETTINGS -->
            <div class="tab-pane fade" id="settings-content" role="tabpanel">
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
    </main>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
function mockConsult(symptom) {
    const win = document.getElementById('chat-window');
    const load = document.getElementById('ai-loading');
    win.innerHTML += `<p class="text-end"><em>You: ${symptom}</em></p>`;
    load.classList.remove('d-none');
    setTimeout(() => {
        load.classList.add('d-none');
        win.innerHTML += `<p><strong>HealthPoint Bot:</strong> Interesting. A ${symptom} could be minor, but stay hydrated. 🩺 See a doctor for a real checkup.</p>`;
        win.scrollTop = win.scrollHeight;
    }, 1000);
}
</script>
</body>
</html>
