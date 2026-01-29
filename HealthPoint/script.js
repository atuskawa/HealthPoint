// ====== STATE ======
let currentSymptom = null;

// ====== ENTRY POINT ======
function startConsult(symptom) {
    currentSymptom = symptom;

    const chat = document.getElementById("chat-window");
    const loader = document.getElementById("ai-loading");

    chat.innerHTML += `<p class="text-end"><em>You: ${symptom}</em></p>`;
    loader.classList.remove("d-none");

    setTimeout(() => {
        loader.classList.add("d-none");
        chat.innerHTML += `
            <p><strong>HealthPoint Bot:</strong><br>
            ${getRealisticResponse(symptom)}
            </p>
        `;
        chat.scrollTop = chat.scrollHeight;
        showFollowUpOptions(symptom);
    }, 700);
}

// ====== MEDICAL RESPONSES ======
function getRealisticResponse(symptom) {
    const responses = {
        Headache: `
Headaches are a common symptom and can result from stress, dehydration, inadequate sleep, or other underlying conditions.

To provide better guidance, please indicate the severity of your headache.
`,
        Fever: `
A fever, defined as a temperature above 38°C (100.4°F), may indicate an infection or inflammatory response.

Please specify how long you have had this fever.
`,
        Nausea: `
Nausea can arise from gastrointestinal irritation, infection, medication side effects, or other systemic causes.

Please indicate the severity of your nausea to guide next steps.
`
    };

    return responses[symptom] || "Additional information is required to provide guidance.";
}

// ====== FOLLOW-UP BUTTONS ======
function showFollowUpOptions(symptom) {
    const container = document.getElementById("option-buttons");

    if (symptom === "Headache" || symptom === "Nausea") {
        container.innerHTML = `
            <div class="col-md-4">
                <button class="option-card w-100 py-3" onclick="answerFollowUp('Mild')">Mild</button>
            </div>
            <div class="col-md-4">
                <button class="option-card w-100 py-3" onclick="answerFollowUp('Moderate')">Moderate</button>
            </div>
            <div class="col-md-4">
                <button class="option-card w-100 py-3" onclick="answerFollowUp('Severe')">Severe</button>
            </div>
        `;
    }

    if (symptom === "Fever") {
        container.innerHTML = `
            <div class="col-md-4">
                <button class="option-card w-100 py-3" onclick="answerFollowUp('Less than 3 days')">Less than 3 days</button>
            </div>
            <div class="col-md-4">
                <button class="option-card w-100 py-3" onclick="answerFollowUp('More than 3 days')">More than 3 days</button>
            </div>
        `;
    }
}

// ====== FOLLOW-UP HANDLER ======
function answerFollowUp(answer) {
    const chat = document.getElementById("chat-window");
    const container = document.getElementById("option-buttons");
    const loader = document.getElementById("ai-loading");

    // Show user's response
    chat.innerHTML += `<p class="text-end"><em>You: ${answer}</em></p>`;
    container.innerHTML = ""; // hide buttons while bot responds

    // Show loading spinner
    loader.classList.remove("d-none");

    // 1-second delay for bot response
    setTimeout(() => {
        loader.classList.add("d-none");
        chat.innerHTML += `
            <p><strong>HealthPoint Bot:</strong><br>
            Thank you for providing that information. Based on your response:
            <ul>
                <li>Continue monitoring your symptoms closely</li>
                <li>Seek in-person medical evaluation if symptoms worsen, persist, or new concerning symptoms appear</li>
                <li>Ensure adequate hydration, rest, and symptom-appropriate care</li>
            </ul>
            Please note: This is general guidance and does not replace a formal medical consultation.
            </p>
        `;
        chat.scrollTop = chat.scrollHeight;

        // Indicate step completion
        container.innerHTML = `
            <div class="col-12 text-muted text-center">
                Consultation step completed.
            </div>
        `;
    }, 1000);
}

