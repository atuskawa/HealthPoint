// ====== STATE ======
let currentSymptom = null;

// ====== ENTRY POINT ======
function startConsult(symptom) {
    currentSymptom = symptom; 

    const chat = document.getElementById("chat-window");
    const loader = document.getElementById("ai-loading");

    chat.innerHTML += `<div class="text-end mb-2"><span class="badge rounded-pill bg-light text-dark p-2 border">Patient: ${symptom}</span></div>`;
    loader.classList.remove("d-none");

    setTimeout(() => {
        loader.classList.add("d-none");
        chat.innerHTML += `
            <div class="bot-response p-3 mb-3 border-start border-4 border-success bg-light">
                <strong>HealthPoint Clinician:</strong><br>
                ${getRealisticResponse(symptom)}
            </div>
        `;
        chat.scrollTop = chat.scrollHeight;
        showFollowUpOptions(symptom);
    }, 800);
}

// ====== DOCTOR-STYLE QUESTIONS ======
function getRealisticResponse(symptom) {
    const responses = {
        Headache: `<strong>Assessment:</strong> It seems like you’re experiencing a headache. We’ll want to understand whether it’s more likely tension-related or something vascular.<br><br><strong>Question:</strong> On a scale of 1 to 10, how intense is the pain?`,
        Fever: `<strong>Assessment:</strong> Your body temperature is elevated, which usually means your immune system is fighting something off.<br><br><strong>Question:</strong> How many days have you had this fever?`,
        Nausea: `<strong>Assessment:</strong> You’re feeling nauseous, which can sometimes lead to dehydration if it continues.<br><br><strong>Question:</strong> How severe is your nausea, and have you been able to keep fluids down?`,

    };
    return responses[symptom] || "Data insufficient.";
}

// ====== FOLLOW-UP BUTTONS ======
function showFollowUpOptions(symptom) {
    const container = document.getElementById("option-buttons");
    if (symptom === "Headache" || symptom === "Nausea") {
        container.innerHTML = `
            <div class="col-md-4"><button class="option-card w-100 py-3" onclick="answerFollowUp('Mild')">Mild</button></div>
            <div class="col-md-4"><button class="option-card w-100 py-3" onclick="answerFollowUp('Moderate')">Moderate</button></div>
            <div class="col-md-4"><button class="option-card w-100 py-3" onclick="answerFollowUp('Severe')">Severe</button></div>
        `;
    } else if (symptom === "Fever") {
        container.innerHTML = `
            <div class="col-md-6"><button class="option-card w-100 py-3" onclick="answerFollowUp('Less than 3 days')">Less than 3 days</button></div>
            <div class="col-md-6"><button class="option-card w-100 py-3" onclick="answerFollowUp('More than 3 days')">More than 3 days</button></div>
        `;
    }
}

// ====== THE TRIAGE LOGIC (NO FILLER) ======
function answerFollowUp(answer) {
    const chat = document.getElementById("chat-window");
    const container = document.getElementById("option-buttons");
    const loader = document.getElementById("ai-loading");

    chat.innerHTML += `<div class="text-end mb-2"><span class="badge rounded-pill bg-success text-white p-2">${answer}</span></div>`;
    container.innerHTML = ""; 
    loader.classList.remove("d-none");

    setTimeout(() => {
        loader.classList.add("d-none");
        let clinicalReport = "";

        // HARD LOGIC - NO GENERIC TEXT ALLOWED
        if (currentSymptom === "Headache") {
            clinicalReport = (answer === "Severe") ?
                "<strong>Notice:</strong> Your headache is quite intense. If you experience vision changes, dizziness, or sudden weakness, please seek immediate medical attention." :
                "<strong>Plan:</strong> Stay hydrated, consider over-the-counter pain relief, and rest in a low-light environment for a few hours.";
        } else if (currentSymptom === "Fever") {
            clinicalReport = (answer === "More than 3 days") ?
                "<strong>Notice:</strong> A fever lasting more than 3 days warrants further evaluation. Please contact your healthcare provider for blood tests or additional assessment." :
                "<strong>Plan:</strong> Keep monitoring your temperature every few hours, rest, and take antipyretics like Paracetamol if needed. Stay hydrated.";
        } else if (currentSymptom === "Nausea") {
            clinicalReport = (answer === "Severe") ?
                "<strong>Notice:</strong> Severe nausea can lead to dehydration. If you cannot keep fluids down, consider contacting a healthcare professional." :
                "<strong>Plan:</strong> Drink small sips of water or clear fluids, avoid heavy meals, and monitor for any abdominal pain or worsening symptoms.";
        }

        chat.innerHTML += `
            <div class="bot-response p-3 mb-2 border-start border-4 border-primary bg-white shadow-sm">
                <strong>Clinician Report:</strong><br>${clinicalReport}
                <hr>
                <div class="text-center">
                    <button class="btn-reset-triage" onclick="location.reload()">Reset Triage</button>
                </div>
            </div>
        `;
        chat.scrollTop = chat.scrollHeight;
    }, 1200);
}