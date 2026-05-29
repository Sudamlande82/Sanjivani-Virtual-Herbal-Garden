<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Registration - Virtual Herbal Garden</title>

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
            color: #1b2a1d;
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
            color: #1b2a1d;
        }

        input {
            width: 100%;
            padding: 12px;
            border: 1px solid #d1d5db;
            border-radius: 10px;
            font-size: 15px;
            outline: none;
            background: white;
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
            font-size: 14px;
            display: none;
        }

        .success {
            background: #e8ffe8;
            color: #1f7a3a;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 8px;
            font-size: 14px;
            display: none;
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
                <h2>Create Account</h2>
                <p class="subtitle">Join the Virtual Herbal Garden community</p>

                <div class="error" id="errorBox"></div>
                <div class="success" id="successBox"></div>

                <div class="form-group">
                    <label for="name">Full Name</label>
                    <asp:TextBox ID="txtfull_name" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="email">Email Address</label>
                    <asp:TextBox ID="txtemail" runat="server"></asp:TextBox>
                </div>

                <div class="form-group">
                    <label for="name">Mobile No.</label>
                    <asp:TextBox ID="txtmobile" runat="server"></asp:TextBox>
                </div>

                <div class="form-group password-field">
                    <label for="password">Password</label>
                    <asp:TextBox ID="password" runat="server" TextMode="Password"></asp:TextBox>
                    <span class="toggle" onclick="togglePassword('password')">Show</span>
                </div>

                <div class="form-group password-field">
                    <label for="confirmPassword">Confirm Password</label>
                    <asp:TextBox ID="confirmPassword" runat="server" TextMode="Password"></asp:TextBox>
                    <span class="toggle" onclick="togglePassword('confirmPassword')">Show</span>
                </div>

                <asp:Button ID="btnregister" CssClass="btn" runat="server" Text="Sign Up" OnClick="btnregister_Click" />

                <p class="footer-text">Already have an account? <a href="Default.aspx">Login</a></p>
            </div>

            <script>
                function showError(message) {
                    const box = document.getElementById('errorBox');
                    box.style.display = 'block';
                    box.textContent = message;
                    document.getElementById('successBox').style.display = 'none';
                }

                function showSuccess(message) {
                    const box = document.getElementById('successBox');
                    box.style.display = 'block';
                    box.textContent = message;
                    document.getElementById('errorBox').style.display = 'none';
                }

                function togglePassword(id) {
                    const input = document.getElementById(id);
                    input.type = input.type === "password" ? "text" : "password";
                }

                function registerUser() {
                    let name = document.getElementById("name").value.trim();
                    let email = document.getElementById("email").value.trim();
                    let password = document.getElementById("password").value;
                    let confirmPassword = document.getElementById("confirmPassword").value;

                    if (name === "" || email === "" || password === "" || confirmPassword === "") {
                        showError("Please fill in all fields.");
                        return;
                    }

                    const emailPattern = /^[^@\s]+@[^@\s]+\.[^@\s]+$/;
                    if (!emailPattern.test(email)) {
                        showError("Please enter a valid email address.");
                        return;
                    }

                    if (password.length < 6) {
                        showError("Password must be at least 6 characters long.");
                        return;
                    }

                    if (password !== confirmPassword) {
                        showError("Passwords do not match.");
                        return;
                    }

                    // If all validations pass
                    showSuccess("Account created successfully!");

                    // Here you can send data to backend API
                    // Example:
                    // fetch('/api/register', {
                    //   method:'POST',
                    //   headers:{"Content-Type":"application/json"},
                    //   body:JSON.stringify({name,email,password})
                    // }).then(...)
                }
            </script>

        </div>
    </form>
</body>
</html>
