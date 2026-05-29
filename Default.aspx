<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login - Virtual Herbal Garden</title>

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
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            padding: 20px;
        }

        .container {
            width: 100%;
            max-width: 420px;
            background: var(--card);
            padding: 30px;
            border-radius: 14px;
            box-shadow: var(--shadow);
        }

        h2 {
            margin-top: 0;
            text-align: center;
            font-size: 26px;
        }

        p.subtitle {
            color: var(--muted);
            margin: -10px 0 20px 0;
            text-align: center;
        }

        .form-group {
            margin-bottom: 16px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
        }

            input:focus {
                border-color: var(--accent);
            }

        .password-field {
            position: relative;
        }

            .password-field .toggle {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                color: var(--muted);
                font-size: 14px;
            }

        .btn {
            width: 100%;
            padding: 12px;
            background: var(--accent);
            color: white;
            border: 0;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            box-shadow: 0 6px 12px rgba(31,122,58,0.25);
        }

            .btn:hover {
                background: var(--accent-light);
            }

        .error {
            background: #ffecec;
            color: #c0392b;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 8px;
            display: none;
            font-size: 14px;
        }

        .success {
            background: #e8ffe8;
            color: #1f7a3a;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 8px;
            display: none;
            font-size: 14px;
        }

        .footer-text {
            margin-top: 15px;
            text-align: center;
            font-size: 14px;
            color: var(--muted);
        }

            .footer-text a {
                color: var(--accent);
                text-decoration: none;
                font-weight: 600;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>


            <div class="container">
                <h2>Welcome Back</h2>
                <p class="subtitle">Login to your Virtual Herbal Garden account</p>

                <div class="error" id="errorBox"></div>
                <div class="success" id="successBox"></div>

                <div class="form-group">
                    <label for="email">Mobile No.</label>
                    <asp:TextBox ID="mobile_no" runat="server"></asp:TextBox>
                </div>

                <div class="form-group password-field">
                    <label for="password">Password</label>
                    <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
                    <span class="toggle" onclick="togglePassword('password')">Show</span>
                </div>

                <asp:Button ID="btnlogin" CssClass="btn" runat="server" Text="Login" OnClick="btnlogin_Click" />

                <p class="footer-text">
                    Don’t have an account? <a href="register.aspx">Sign Up</a>
                </p>
            </div>


            <script>
                function showError(msg) {
                    const box = document.getElementById('errorBox');
                    box.style.display = "block";
                    box.textContent = msg;
                    document.getElementById('successBox').style.display = "none";
                }

                function showSuccess(msg) {
                    const box = document.getElementById('successBox');
                    box.style.display = "block";
                    box.textContent = msg;
                    document.getElementById('errorBox').style.display = "none";
                }

                function togglePassword(id) {
                    let input = document.getElementById(id);
                    input.type = input.type === "password" ? "text" : "password";
                }

                function loginUser() {
                    let email = document.getElementById('email').value.trim();
                    let password = document.getElementById('password').value;

                    if (email === "" || password === "") {
                        showError("Please fill in all fields.");
                        return;
                    }

                    const emailPattern = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
                    if (!emailPattern.test(email)) {
                        showError("Enter a valid email address.");
                        return;
                    }

                    if (password.length < 6) {
                        showError("Password must be at least 6 characters.");
                        return;
                    }

                    // If validation passes
                    showSuccess("Login successful!");

                    // Here you can send the login request to backend
                    /*
                    fetch('/api/login', {
                      method:'POST',
                      headers:{"Content-Type":"application/json"},
                      body:JSON.stringify({email, password})
                    })
                    .then(res => res.json())
                    .then(data => {
                        if(data.success){
                            window.location.href = "dashboard.html";
                        } else {
                            showError(data.message);
                        }
                    });
                    */
                }
            </script>

        </div>
    </form>
</body>
</html>
