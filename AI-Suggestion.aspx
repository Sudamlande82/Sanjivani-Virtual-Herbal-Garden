<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="~/AI-Suggestion.aspx.cs" Inherits="AI_Suggestion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        :root {
            --bg: #f4faf4;
            --card: #ffffff;
            --accent: #1f7a3a;
            --accent-light: #2aa06c;
            --muted: #6b7280;
            --shadow: 0 4px 14px rgba(0,0,0,0.10);
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg);
        }

        .container {
            max-width: 900px;
            margin: 20px auto;
            padding: 20px;
        }

        h1 {
            text-align: center;
            font-size: 32px;
            color: var(--accent);
            margin-bottom: 4px;
        }

        .subtitle {
            text-align: center;
            color: var(--muted);
            margin-bottom: 20px;
        }

        /* Search box */
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

            .search-box input {
                flex: 1;
                padding: 12px;
                border-radius: 12px;
                border: 1px solid #ccc;
                font-size: 16px;
            }

            .search-box button {
                padding: 12px 18px;
                border-radius: 12px;
                border: none;
                background: var(--accent);
                color: #fff;
                font-weight: bold;
                cursor: pointer;
                font-size: 15px;
            }

                .search-box button:hover {
                    background: var(--accent-light);
                }

        /* Result card */
        .result-card {
            background: var(--card);
            border-radius: 16px;
            box-shadow: var(--shadow);
            padding: 18px;
            display: none;
        }

        .result-header {
            display: flex;
            gap: 16px;
            align-items: flex-start;
        }

            .result-header img {
                width: 140px;
                height: 140px;
                object-fit: cover;
                border-radius: 12px;
                border: 1px solid #eee;
            }

        .result-title {
            font-size: 22px;
            margin: 0 0 6px 0;
            color: #1b2a1d;
        }

        .result-tagline {
            font-size: 14px;
            color: var(--muted);
            margin-bottom: 8px;
        }

        .result-description {
            margin-top: 10px;
            font-size: 15px;
            line-height: 1.6;
            color: #374151;
        }

        a.read-more {
            display: inline-block;
            margin-top: 12px;
            font-size: 14px;
            text-decoration: none;
            color: var(--accent);
            font-weight: bold;
        }

            a.read-more:hover {
                text-decoration: underline;
            }

        /* Status messages */
        .status {
            margin-top: 10px;
            font-size: 14px;
            color: var(--muted);
        }

            .status.error {
                color: #b91c1c;
            }

            .status.loading {
                color: #1f2937;
            }

        /* Helper notes */
        .helper {
            margin-top: 8px;
            font-size: 13px;
            color: var(--muted);
        }
    </style>
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <div class="container">
        <h1>AI Herb Suggestions</h1>
        <p class="subtitle">Type any herb or plant name (e.g., Tulsi, Neem, Aloe vera, Peppermint) and I’ll fetch info from the internet.</p>

        <!-- Search -->
        <div class="search-box">
            <input id="queryInput" type="text" placeholder="Enter herb / plant name, e.g. 'Tulsi' or 'Rosemary'">
            <button onclick="searchHerb()">Search</button>
        </div>
        <p class="helper">This demo uses the public Wikipedia API in the browser. Requires internet connection.</p>

        <!-- Status message -->
        <div id="status" class="status"></div>

        <!-- Result -->
        <div id="resultCard" class="result-card">
            <div class="result-header">
                <img id="plantImage" src="" alt="Plant image">
                <div>
                    <h2 id="plantTitle" class="result-title"></h2>
                    <div id="plantTagline" class="result-tagline"></div>
                </div>
            </div>

            <p id="plantDescription" class="result-description"></p>
            <a id="readMoreLink" class="read-more" href="#" target="_blank">Read full article</a>
        </div>
    </div>

    <script>
        async function searchHerb() {
            const input = document.getElementById("queryInput");
            const query = input.value.trim();
            const statusEl = document.getElementById("status");
            const card = document.getElementById("resultCard");

            if (!query) {
                statusEl.textContent = "⚠️ Please enter a herb or plant name.";
                statusEl.className = "status error";
                card.style.display = "none";
                return;
            }

            // Show loading
            statusEl.textContent = "🔍 Searching online for: " + query + " ...";
            statusEl.className = "status loading";
            card.style.display = "none";

            try {
                // Wikipedia summary API
                const url = "https://en.wikipedia.org/api/rest_v1/page/summary/" + encodeURIComponent(query);
                const res = await fetch(url);

                if (!res.ok) {
                    throw new Error("No information found for this herb.");
                }

                const data = await res.json();

                // Basic sanity check
                if (data.type === "https://mediawiki.org/wiki/HyperSwitch/errors/not_found" || data.title === "Not found.") {
                    statusEl.textContent = "❌ No herb information found. Try a different or more specific name.";
                    statusEl.className = "status error";
                    card.style.display = "none";
                    return;
                }

                // Fill UI
                document.getElementById("plantTitle").textContent = data.title || query;
                document.getElementById("plantTagline").textContent = data.description || "Herbal / plant information from Wikipedia";
                document.getElementById("plantDescription").textContent = data.extract || "No detailed description available.";

                // Image (if available)
                const imgEl = document.getElementById("plantImage");
                if (data.thumbnail && data.thumbnail.source) {
                    imgEl.src = data.thumbnail.source;
                    imgEl.style.display = "block";
                } else {
                    imgEl.style.display = "none";
                }

                // Read more link
                const readMore = document.getElementById("readMoreLink");
                readMore.href = data.content_urls && data.content_urls.desktop
                    ? data.content_urls.desktop.page
                    : "https://en.wikipedia.org/wiki/" + encodeURIComponent(query);

                // Show card, update status
                card.style.display = "block";
                statusEl.textContent = "✅ Result found for: " + query;
                statusEl.className = "status";

            } catch (err) {
                console.error(err);
                statusEl.textContent = "❌ Unable to fetch herb information. Try another name or check your internet connection.";
                statusEl.className = "status error";
                card.style.display = "none";
            }
        }
    </script>

</asp:Content>




