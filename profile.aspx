<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="profile.aspx.cs" Inherits="profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <title>User Profile - Virtual Herbal Garden</title>

    <style>
        :root {
            --bg: #f4faf4;
            --card: #ffffff;
            --accent: #1f7a3a;
            --muted: #6b7280;
            --shadow: 0 4px 15px rgba(0,0,0,0.10);
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg);
        }

        .container {
            max-width: 1100px;
            margin: auto;
            padding: 25px;
        }

        /* Profile Card */
        .profile-card {
            background: var(--card);
            padding: 25px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            display: flex;
            gap: 30px;
            align-items: center;
        }

            .profile-card img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid var(--accent);
            }

        .profile-info h2 {
            margin: 0;
            font-size: 28px;
        }

        .profile-info p {
            margin: 5px 0;
            color: var(--muted);
        }

        /* Statistics */
        .stats {
            display: flex;
            gap: 20px;
            margin-top: 20px;
            flex-wrap: wrap;
        }

        .stat-box {
            background: var(--card);
            padding: 20px;
            border-radius: 12px;
            flex: 1;
            text-align: center;
            min-width: 200px;
            box-shadow: var(--shadow);
        }

            .stat-box h3 {
                margin: 0;
                font-size: 26px;
                color: var(--accent);
            }

            .stat-box p {
                margin-top: 6px;
                color: var(--muted);
            }

        /* Edit Profile Form */
        .form-card {
            background: var(--card);
            padding: 25px;
            border-radius: 16px;
            box-shadow: var(--shadow);
            margin-top: 30px;
        }

            .form-card h3 {
                margin-top: 0;
                font-size: 24px;
            }

        form {
            margin-top: 15px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        input {
            width: 100%;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #ccc;
            margin-bottom: 15px;
            font-size: 15px;
        }

        button {
            padding: 14px 20px;
            background: var(--accent);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

            button:hover {
                background: #2aa06c;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:Label ID="lblmobile_no" runat="server" Visible="false"></asp:Label>
    <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>

    <div class="container">

        <!-- User Profile Card -->
        <div class="profile-card">
            <img src="https://picsum.photos/seed/user/200" alt="User Photo">

            <div class="profile-info">
                <h2><asp:Label ID="lblusername" runat="server"></asp:Label></h2>
                <p>Email: <asp:Label ID="lblemail" runat="server"></asp:Label></p>
                <p>Phone: <asp:Label ID="lblphone" runat="server"></asp:Label></p>
            </div>
        </div>

        <!-- Stats -->
        <%--<div class="stats">
            <div class="stat-box">
                <h3>12</h3>
                <p>Saved Favorites</p>
            </div>

            <div class="stat-box">
                <h3>8</h3>
                <p>Recently Viewed</p>
            </div>

            <div class="stat-box">
                <h3>25</h3>
                <p>Herbs Explored</p>
            </div>
        </div>--%>

        <!-- Edit Profile Form -->
        <div class="form-card">
            <h3>Edit Profile</h3>


            <label>Full Name</label>
            <asp:TextBox ID="txtname" runat="server" placeholder="your name"></asp:TextBox>

            <label>Email</label>
            <asp:TextBox ID="txtemail" runat="server" placeholder="your email"></asp:TextBox>

            <label>Phone Number</label>
            <asp:TextBox ID="txtmobile" runat="server" placeholder="your phone number"></asp:TextBox>

            <label>Your Password</label>
            <asp:TextBox ID="txtpassword" runat="server" placeholder="your password"></asp:TextBox>

            <asp:Button ID="btnupdate" runat="server" Text="Update Data" OnClick="btnupdate_Click" />

        </div>

    </div>

</asp:Content>

