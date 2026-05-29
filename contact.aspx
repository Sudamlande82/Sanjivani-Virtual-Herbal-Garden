<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        :root {
            --bg: #f4faf4;
            --card: #ffffff;
            --accent: #1f7a3a;
            --accent-light: #2aa06c;
            --muted: #6b7280;
            --shadow: 0 6px 16px rgba(0,0,0,0.08);
            font-family: Inter,Segoe UI,Roboto,sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg);
        }

        /* NAVBAR */
        .navbar {
            background: var(--card);
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
            padding: 14px 22px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }

            .navbar .logo {
                font-size: 20px;
                font-weight: 700;
                color: var(--accent);
            }

        .nav-links {
            display: flex;
            gap: 20px;
        }

            .nav-links a {
                text-decoration: none;
                color: #1b2a1d;
                font-weight: 600;
                padding: 8px;
                border-radius: 6px;
            }

                .nav-links a:hover {
                    background: #e9f7ee;
                    color: var(--accent);
                }

        .burger {
            display: none;
            font-size: 26px;
            cursor: pointer;
        }

        @media(max-width:768px) {
            .nav-links {
                position: absolute;
                top: 60px;
                right: 0;
                background: white;
                flex-direction: column;
                width: 200px;
                display: none;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
                padding: 20px;
            }

                .nav-links.show {
                    display: flex;
                }

            .burger {
                display: block;
            }
        }

        /* PAGE CONTENT */
        .container {
            max-width: 900px;
            margin: auto;
            padding: 25px;
        }

        h2 {
            font-size: 30px;
            margin-bottom: 5px;
        }

        p.subtext {
            color: var(--muted);
            margin-top: -5px;
        }

        .card {
            background: var(--card);
            padding: 20px;
            border-radius: 14px;
            box-shadow: var(--shadow);
            margin-top: 25px;
        }

        label {
            font-weight: 600;
            margin-bottom: 6px;
            display: block;
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            font-size: 15px;
            outline: none;
            margin-bottom: 15px;
            background: white;
        }

            input:focus, textarea:focus {
                border-color: var(--accent);
            }

        textarea {
            min-height: 120px;
        }

        .btn {
            background: var(--accent);
            color: white;
            padding: 12px 18px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
        }

            .btn:hover {
                background: var(--accent-light);
            }

        .success {
            background: #e8ffe8;
            color: #1f7a3a;
            padding: 14px;
            border-radius: 10px;
            margin-top: 10px;
            display: none;
        }

        /* Contact Admin */
        .contact-box {
            background: var(--card);
            padding: 20px;
            border-radius: 14px;
            box-shadow: var(--shadow);
            margin-top: 25px;
            font-size: 16px;
        }

            .contact-box p {
                margin: 6px 0;
            }

            .contact-box strong {
                color: var(--accent);
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">

        <h2>Contact & Feedback</h2>
        <p class="subtext">We’d love to hear from you! Share your feedback or suggest new features.</p>

        <!-- Feedback Form -->
        <div class="card">
            <h3>Send Us Your Feedback</h3>

            <label>Your Name</label>
            <asp:TextBox ID="txtname" runat="server" placeholder="enter your name"></asp:TextBox>

            <label>Your Email</label>
            <asp:TextBox ID="txtemail" runat="server" placeholder="enter your email"></asp:TextBox>

            <label>Your Message</label>
            <asp:TextBox ID="txtmsg" runat="server" TextMode="MultiLine" placeholder="enter your message here.."></asp:TextBox>

            <asp:Button ID="btn" runat="server" CssClass="btn" Text="Submit Feedback" OnClick="btn_Click" />

            <div id="successMsg" class="success">Thank you! Your feedback has been submitted.</div>
        </div>

        <!-- Suggestions -->
        <div class="card">
            <h3>Suggest a New Feature</h3>
            <asp:TextBox ID="txtsuggestions" runat="server" TextMode="MultiLine" placeholder="Tell us what feature you'd like to see..."></asp:TextBox>
            <asp:Button ID="btnsubmit_suggestion" runat="server" CssClass="btn" Text="Submit Suggestion" OnClick="btnsubmit_suggestion_Click" />
        </div>

        <!-- Contact Admin -->
        <div class="contact-box">
            <h3>Contact Admin</h3>
            <p>📧 <strong>Email:</strong> admin@herbalgarden.com</p>
            <p>📞 <strong>Phone:</strong> +91 98765 43210</p>
            <p>🏢 <strong>Office:</strong> Virtual Herbal Garden Support Team</p>
        </div>

    </div>

    <script>
        function toggleNav() {
            document.getElementById('navLinks').classList.toggle('show');
        }

        function submitFeedback() {
            let name = document.getElementById("name").value.trim();
            let email = document.getElementById("email").value.trim();
            let msg = document.getElementById("message").value.trim();

            if (name === "" || email === "" || msg === "") {
                alert("Please fill all fields before submitting.");
                return;
            }

            document.getElementById("successMsg").style.display = "block";

            // Here you can send data to backend API
            // fetch('/api/feedback', {...})
        }

        function submitFeature() {
            let suggestion = document.getElementById("featureText").value.trim();

            if (suggestion === "") {
                alert("Please write a suggestion before submitting.");
                return;
            }

            alert("Thank you! Your feature suggestion has been received.");

            // Here you can send feature suggestions to backend
        }
    </script>


</asp:Content>

