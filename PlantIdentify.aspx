<%@ Page Title="" Language="C#" Async="true" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="PlantIdentify.aspx.cs" Inherits="PlantIdentify" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <title>AI Plant Identifier</title>

    <style>
        body {
            font-family: Arial;
            background: #ecf9f1;
        }

        .container {
            width: 700px;
            margin: 40px auto;
            text-align: center;
        }

        .box {
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        button {
            padding: 10px 20px;
            background: green;
            color: #fff;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        #resultCard {
            display: none;
            margin-top: 20px;
            background: #fff;
            padding: 15px;
            border-radius: 10px;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">
        <h2>🌿 AI Plant Identifier</h2>

        <div class="box">
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <br />
            <br />
            <asp:Button ID="btnIdentify" runat="server" Text="Identify Plant" OnClick="btnIdentify_Click" />
        </div>

        <div id="resultCard" runat="server">
            <h3 id="plantTitle" runat="server"></h3>
            <p id="plantTag" runat="server"></p>
            <p id="plantFamily" runat="server"></p>

            <%--<h4>Top Matches:</h4>--%>
            <asp:Literal ID="topResults" runat="server"></asp:Literal>
        </div>

    </div>


</asp:Content>

