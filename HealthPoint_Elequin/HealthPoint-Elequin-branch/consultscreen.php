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
    <title>HealthPoint | Consult</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <header class="hp-header">
        <div class="circle-icon">LOGO</div>
        <h3 class="m-0 fw-bold">HealthPoint</h3>
        <div class="circle-icon">USER</div>
    </header>

    <div class="main-wrapper">
        <nav class="hp-sidebar nav flex-column nav-pills" id="v-pills-tab">
            <button class="nav-link active" id="consult-tab" data-bs-toggle="pill" data-bs-target="#consult-content">Consult</button>
            <button class="nav-link" id="contact-tab" data-bs-toggle="pill" data-bs-target="#contact-content">Contact Doctor</button>
            <button class="nav-link" id="records-tab" data-bs-toggle="pill" data-bs-target="#records-content">Records</button>
        </nav>

        <main class="hp-content">
            <div class="tab-content w-100" id="v-pills-tabContent">
                
                <div class="tab-pane fade show active" id="consult-content">
                    <div class="container-fluid">
                        <div class="placeholder-bubble shadow-sm p-4 mx-auto mb-4" style="max-width: 800px;">
                            <div class="alert alert-warning py-2 mb-3 text-center" style="border-radius: 20px; font-size: 0.8rem;">
                                ⚠️ <strong>GUESTIMATION ONLY:</strong> For real exams, book an appointment.
                            </div>

                            <div id="chat-window" class="p-3" style="height: 250px; overflow-y: auto; background: rgba(255,255,255,0.4); border-radius: 20px;">
                                <p><strong>HealthPoint Bot:</strong> What symptoms are you feeling today? Click a pill below to begin.</p>
                            </div>
                            
                            <div id="ai-loading" class="mt-2 ps-3 d-none">
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