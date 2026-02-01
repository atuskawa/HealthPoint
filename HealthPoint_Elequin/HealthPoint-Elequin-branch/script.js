// ====== STATE ======
let currentSymptom = null;
let followUpStep = 0;

// ====== ENTRY POINT ======
function startConsult(symptom) {
    currentSymptom = symptom;
    followUpStep = 0;

    const chat = document.getElementById("chat-window");
    const loader = document.getElementById("ai-loading");

    chat.innerHTML += `<div class="text-end mb-2">
        <span class="badge rounded-pill bg-light text-dark p-2 border">Patient: ${symptom}</span>
    </div>`;
    loader.classList.remove("d-none");

    setTimeout(() => {
        loader.classList.add("d-none");
        showNextFollowUp();
    }, 1200);
}

// ====== FOLLOW-UP QUESTIONS DATA ======
const followUps = {
    Headache: [
        {
            question: "On a scale from Mild to Severe, how would you rate the intensity of your headache?",
            options: ["Mild", "Moderate", "Severe"]
        },
        {
            question: "Do you experience nausea, vision changes, or sensitivity to light?",
            options: ["Yes", "No"]
        },
        {
            question: "How long have you been experiencing headaches?",
            options: ["Less than a day", "1-3 days", "More than 3 days"]
        }
    ],
    Fever: [
        {
            question: "How many days have you been experiencing this fever?",
            options: ["Less than 3 days", "More than 3 days"]
        },
        {
            question: "Do you have chills, body aches, or sweating?",
            options: ["Yes", "No"]
        }
    ],
    Nausea: [
        {
            question: "On a scale from Mild to Severe, how would you describe the intensity of your nausea?",
            options: ["Mild", "Moderate", "Severe"]
        },
        {
            question: "Have you vomited in the past 24 hours?",
            options: ["Yes", "No"]
        }
    ]
};

// ====== SHOW FOLLOW-UP QUESTIONS ======
function showNextFollowUp() {
    const chat = document.getElementById("chat-window");
    const container = document.getElementById("option-buttons");

    const currentFollowUps = followUps[currentSymptom];
    if (!currentFollowUps || followUpStep >= currentFollowUps.length) {
        showFinalReport();
        return;
    }

    const followUp = currentFollowUps[followUpStep];

    chat.innerHTML += `
        <div class="bot-response p-3 mb-3 border-start border-4 border-success bg-light">
            <strong>HealthPoint Bot:</strong><br>${followUp.question}
        </div>
    `;

    container.innerHTML = followUp.options.map(option => 
        `<div class="col-md-${Math.ceil(12/followUp.options.length)}">
            <button class="option-card w-100 py-3" onclick="answerFollowUp('${option}')">${option}</button>
        </div>`).join("");

    chat.scrollTop = chat.scrollHeight;
}

// ====== HANDLE FOLLOW-UP ANSWERS ======
const answers = []; // store all answers

function answerFollowUp(answer) {
    const chat = document.getElementById("chat-window");
    const container = document.getElementById("option-buttons");
    const loader = document.getElementById("ai-loading");

    chat.innerHTML += `<div class="text-end mb-2">
        <span class="badge rounded-pill bg-success text-white p-2">${answer}</span>
    </div>`;
    container.innerHTML = "";
    loader.classList.remove("d-none");

    answers.push(answer);
    followUpStep++;

    setTimeout(() => {
        loader.classList.add("d-none");
        showNextFollowUp();
    }, 800);
}

// ====== FINAL CLINIC REPORT ======
function showFinalReport() {
    const chat = document.getElementById("chat-window");
    const loader = document.getElementById("ai-loading");

    loader.classList.remove("d-none");

    setTimeout(() => {
        loader.classList.add("d-none");

        let report = "";

        if (currentSymptom === "Headache") {
            if (answers.includes("Severe") || answers.includes("Yes")) {
                report = "<strong>Notice:</strong> Your headache may require urgent evaluation. Watch for vision changes, weakness, numbness, or confusion.";
            } else {
                report = "<strong>Plan:</strong> Rest, stay hydrated, and consider over-the-counter pain relief if needed.";
            }
        } else if (currentSymptom === "Fever") {
            if (answers.includes("More than 3 days") || answers.includes("Yes")) {
                report = "<strong>Notice:</strong> Persistent fever or associated symptoms warrant contacting your healthcare provider.";
            } else {
                report = "<strong>Plan:</strong> Rest, hydrate, and monitor your temperature. Use antipyretics if necessary.";
            }
        } else if (currentSymptom === "Nausea") {
            if (answers.includes("Severe") || answers.includes("Yes")) {
                report = "<strong>Notice:</strong> Severe nausea or repeated vomiting may cause dehydration. Seek medical attention.";
            } else {
                report = "<strong>Plan:</strong> Sip fluids, eat light meals, and monitor symptoms.";
            }
        }

        chat.innerHTML += `
            <div class="bot-response p-3 mb-2 border-start border-4 border-primary bg-white shadow-sm">
                <strong>HealthPoint Report:</strong><br>${report}
                <hr>
                <div class="text-center">
                    <button class="btn-reset-triage" onclick="location.reload()">Reset Triage</button>
                </div>
            </div>
        `;

        chat.scrollTop = chat.scrollHeight;
    }, 1200);
}

// ====== SIDEBAR TOGGLE ======
document.addEventListener('DOMContentLoaded', function () {
    const toggle = document.getElementById('sidebarToggle');
    const sidebar = document.querySelector('.hp-sidebar');

    console.log('[HP] sidebar init:', { togglePresent: !!toggle, sidebarPresent: !!sidebar });

    if (!toggle || !sidebar) return;

    // restore state from localStorage
    const collapsed = localStorage.getItem('hp_sidebar_collapsed') === '1';
    if (collapsed) sidebar.classList.add('collapsed');

    toggle.addEventListener('click', function (ev) {
        console.log('[HP] sidebar toggle clicked');
        sidebar.classList.toggle('collapsed');
        const isCollapsed = sidebar.classList.contains('collapsed');
        localStorage.setItem('hp_sidebar_collapsed', isCollapsed ? '1' : '0');
    });

    // keyboard accessibility: Space or Enter toggles when focused
    toggle.addEventListener('keydown', function (ev) {
        if (ev.key === ' ' || ev.key === 'Enter') {
            ev.preventDefault();
            toggle.click();
        }
    });
});
