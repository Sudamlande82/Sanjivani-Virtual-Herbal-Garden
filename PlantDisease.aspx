<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PlantDisease.aspx.cs" Inherits="PlantDisease" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <title>Plant Disease Detection</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #ecf9f1;
        }

        .container {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #1f7a3a;
        }

        .subtitle {
            text-align: center;
            color: #6b7280;
            margin-bottom: 20px;
        }

        .upload-box {
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        button {
            margin-top: 15px;
            padding: 10px 20px;
            background: #1f7a3a;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .result {
            display: none;
            margin-top: 25px;
            background: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

            .result img {
                width: 100%;
                max-height: 300px;
                object-fit: cover;
                border-radius: 10px;
            }

        .tag {
            margin-top: 10px;
            padding: 6px 12px;
            background: #e3f7ea;
            color: #1f7a3a;
            display: inline-block;
            border-radius: 20px;
        }

        .remedy {
            margin-top: 15px;
            background: #f4fff8;
            padding: 12px;
            border-left: 4px solid #1f7a3a;
            border-radius: 6px;
        }

        .status {
            margin-top: 10px;
            color: #1f7a3a;
            font-weight: bold;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">

        <h1>🌿 Plant Disease Detection</h1>
        <p class="subtitle">Upload leaf image to detect disease + remedies</p>

        <div class="upload-box">
            <input type="file" id="imageInput" accept="image/*" />
            <br />
            <button type="button" onclick="uploadImage()">Analyze Disease</button>
            <p id="statusMsg" class="status"></p>
        </div>

        <div id="resultBox" class="result">
            <img id="previewImage" />

            <h2 id="plantName"></h2>
            <div class="tag" id="confidence"></div>

            <p id="family"></p>
            <%--<p id="disease"></p>

            <div class="remedy">
                <strong>Remedy:</strong>
                <p id="remedyText"></p>
            </div>--%>
        </div>

    </div>

    </form>


    <script>
        async function uploadImage() {

            const input = document.getElementById("imageInput");
            const status = document.getElementById("statusMsg");

            if (input.files.length === 0) {
                status.innerText = "Please select image";
                return;
            }

            const file = input.files[0];

            document.getElementById("previewImage").src =
                URL.createObjectURL(file);

            status.innerText = "Analyzing image...";

            const formData = new FormData();
            formData.append("file", file);

            try {
                const res = await fetch("PlantDiseaseAPI.aspx", {
                    method: "POST",
                    body: formData
                });

                const text = await res.text();
                console.log("RAW:", text);

                const data = JSON.parse(text);

                if (!data.results || data.results.length === 0) {
                    status.innerText = "No plant detected";
                    return;
                }

                const best = data.results[0];

                document.getElementById("resultBox").style.display = "block";

                document.getElementById("plantName").innerText =
                    best.species.scientificName;

                document.getElementById("confidence").innerText =
                    "Confidence: " + (best.score * 100).toFixed(2) + "%";

                document.getElementById("family").innerText =
                    "Family: " + best.species.family.scientificNameWithoutAuthor;

                document.getElementById("disease").innerText =
                    "Disease: " + best.disease;

                document.getElementById("remedyText").innerText =
                    best.remedy;

                status.innerText = "Analysis completed ✅";

            } catch (err) {
                console.log(err);
                status.innerText = "Error connecting to server";
            }
        }
</script>


</asp:Content>

