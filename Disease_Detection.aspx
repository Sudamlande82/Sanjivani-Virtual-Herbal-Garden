<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Disease_Detection.aspx.cs" Inherits="Disease_Detection" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        :root {
            --bg: #ecf9f1;
            --card: #ffffff;
            --accent: #1f7a3a;
            --accent-light: #2aa06c;
            --muted: #6b7280;
            --shadow: 0 6px 20px rgba(0,0,0,0.10);
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg);
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
        }

        /* Title */
        h1 {
            text-align: center;
            font-size: 32px;
            color: var(--accent);
            margin-bottom: 6px;
        }

        .subtitle {
            text-align: center;
            color: var(--muted);
            margin-bottom: 24px;
        }

        /* Upload card */
        .upload-box {
            background: var(--card);
            padding: 24px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            text-align: center;
        }

            .upload-box p {
                margin: 0 0 10px;
            }

        input[type="file"] {
            margin-top: 10px;
            padding: 10px;
            border-radius: 10px;
            border: 1px solid #ccc;
            background: white;
            width: 100%;
            max-width: 320px;
        }

        button {
            margin-top: 16px;
            padding: 12px 20px;
            border: none;
            border-radius: 12px;
            background: var(--accent);
            color: white;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
        }

            button:hover {
                background: var(--accent-light);
            }

        /* Result card */
        .result {
            margin-top: 26px;
            background: var(--card);
            padding: 20px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            display: none;
        }

            .result img {
                width: 100%;
                max-height: 320px;
                object-fit: cover;
                border-radius: 12px;
                margin-bottom: 14px;
            }

            .result h2 {
                margin: 4px 0;
                color: var(--accent);
            }

        .tag {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            background: #e3f7ea;
            color: var(--accent);
            font-size: 13px;
            margin-bottom: 10px;
        }

        .result p {
            color: var(--muted);
            margin: 6px 0;
            line-height: 1.5;
        }

        /* helper text */
        .hint {
            margin-top: 10px;
            font-size: 13px;
            color: var(--muted);
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="container">

        <h1>Plant Disease Detection</h1>
        <p class="subtitle">Upload a leaf or plant image to check for possible diseases (demo AI)</p>

        <!-- Upload area -->
        <div class="upload-box">
            <p><strong>Select plant / leaf image:</strong></p>
            <input type="file" id="imageInput" accept="image/*">
            <button onclick="analyzeImage()">Analyze Disease</button>
            <p class="hint">Tip: rename file like <em>leaf_yellow_spot.jpg</em>, <em>powdery_white_leaf.png</em>, <em>black_rot_leaf.jpg</em> to see different demo results.</p>
        </div>

        <!-- Result -->
        <div class="result" id="resultBox">
            <img id="previewImage" alt="Leaf preview">
            <h2 id="diseaseName"></h2>
            <div class="tag" id="severityTag"></div>
            <p id="diseaseDesc"></p>
            <p id="treatment"></p>
        </div>

    </div>

    <script>
        // Simple mock "AI" database – rule-based using filename keywords
        const diseaseDB = [
            {
                keywords: ["yellow", "spot", "spots"],
                disease: "Leaf Spot Disease",
                severity: "Moderate",
                desc: "Characterized by yellow or brown circular spots on leaves caused by fungal or bacterial pathogens.",
                treatment: "Remove heavily infected leaves, avoid overhead watering, and spray with a suitable fungicide or neem oil."
            },
            {
                keywords: ["curl", "curled", "bent"],
                disease: "Leaf Curl Virus",
                severity: "High",
                desc: "Leaves become curled, twisted and distorted due to viral infection, often transmitted by insects.",
                treatment: "Remove and destroy infected leaves, control aphids/whiteflies with organic insecticides, and use resistant plant varieties."
            },
            {
                keywords: ["white", "powder", "powdery"],
                disease: "Powdery Mildew",
                severity: "Medium",
                desc: "White powder-like fungal growth appears on the leaf surface, reducing photosynthesis.",
                treatment: "Increase air circulation, avoid overcrowding, and spray a baking soda solution or sulfur-based fungicide."
            },
            {
                keywords: ["black", "rot"],
                disease: "Bacterial Leaf Rot",
                severity: "Severe",
                desc: "Dark, water-soaked lesions appear on leaves and may spread quickly in humid conditions.",
                treatment: "Remove infected plant parts, sterilize tools, avoid waterlogging, and apply copper-based bactericide if needed."
            },
            {
                keywords: ["rust"],
                disease: "Leaf Rust",
                severity: "Medium",
                desc: "Small orange, brown or rust-colored pustules appear on the underside of leaves.",
                treatment: "Remove affected leaves and spray with recommended fungicide. Use resistant varieties where available."
            }
        ];

        function analyzeImage() {
            const input = document.getElementById("imageInput");
            const resultBox = document.getElementById("resultBox");

            if (!input.files || input.files.length === 0) {
                alert("Please select an image first.");
                return;
            }

            const file = input.files[0];

            // Show preview
            const imgEl = document.getElementById("previewImage");
            imgEl.src = URL.createObjectURL(file);

            // Use file name as a fake "feature" source
            const fileName = file.name.toLowerCase();
            let detected = null;

            // Try to match any keyword
            diseaseDB.forEach(d => {
                d.keywords.forEach(k => {
                    if (fileName.includes(k)) {
                        detected = d;
                    }
                });
            });

            resultBox.style.display = "block";

            const diseaseNameEl = document.getElementById("diseaseName");
            const severityTagEl = document.getElementById("severityTag");
            const descEl = document.getElementById("diseaseDesc");
            const treatmentEl = document.getElementById("treatment");

            if (detected) {
                diseaseNameEl.textContent = detected.disease;
                severityTagEl.textContent = "Severity: " + detected.severity;
                descEl.textContent = detected.desc;
                treatmentEl.textContent = "Suggested Treatment: " + detected.treatment;
            } else {
                diseaseNameEl.textContent = "No Clear Disease Detected (Demo Result)";
                severityTagEl.textContent = "Severity: Low / Healthy";
                descEl.textContent = "The demo AI could not match any common disease pattern from the file name.";
                treatmentEl.textContent = "General care: remove damaged leaves, avoid over-watering, give proper sunlight, and monitor regularly for visible symptoms.";
            }
        }
    </script>

</asp:Content>

