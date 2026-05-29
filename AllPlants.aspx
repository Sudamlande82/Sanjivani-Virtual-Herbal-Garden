<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AllPlants.aspx.cs" Inherits="AllPlants" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>All Plants - Virtual Herbal Garden</title>

    <style>
        :root {
            --bg: #f5faf5;
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
            padding: 20px;
        }

        /* PAGE TITLE */
        h2 {
            margin: 10px 0 5px 0;
            font-size: 32px;
            color: #1b2a1d;
        }

        .subtitle {
            color: var(--muted);
            margin-bottom: 20px;
        }

        /* Search bar */
        .search-bar {
            display: flex;
            gap: 12px;
            margin-bottom: 20px;
        }

            .search-bar input {
                flex: 1;
                padding: 14px;
                border-radius: 12px;
                border: 1px solid #ccc;
                font-size: 16px;
            }

        .btn {
            padding: 14px 20px;
            background: var(--accent);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        /* Filters */
        .filters {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

            .filters select {
                padding: 12px;
                border-radius: 10px;
                border: 1px solid #ccc;
                background: white;
                font-size: 14px;
            }

        /* Plants Grid */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px,1fr));
            gap: 20px;
        }

        .card {
            background: var(--card);
            border-radius: 12px;
            overflow: hidden;
            box-shadow: var(--shadow);
        }

            .card img {
                width: 100%;
                height: 160px;
                object-fit: cover;
            }

        .card-body {
            padding: 12px;
        }

            .card-body h4 {
                margin: 0;
                font-size: 18px;
            }

            .card-body p {
                margin-top: 6px;
                color: var(--muted);
                font-size: 14px;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container">

        <!-- Title -->
        <h2>All Medicinal Plants / <a href="ai_herbs_suggestion.html">Get AI Suggestions </a> | <a href="illness-ai-suggestion.html"> AI Suggestions With Parameters You Entered </a> </h2>
        <p class="subtitle">Browse through the collection of medicinal plants</p>

        <!-- Search Bar -->
        <%--<div class="search-bar">
            <input type="text" placeholder="Search plants...">
            <button class="btn">Search</button>
        </div>--%>

        <!-- Filters -->
        <div class="filters">
            <asp:DropDownList ID="cmbcategory" runat="server" DataSourceID="SqlDataSource1" DataTextField="category_name" DataValueField="category_name" AutoPostBack="true"></asp:DropDownList>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [category_name] FROM [herb_category]"></asp:SqlDataSource>

            <%--<asp:DropDownList ID="cmbailment" runat="server" DataSourceID="SqlDataSource2" DataTextField="ailment" DataValueField="ailment"></asp:DropDownList>
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [ailment] FROM [plant]"></asp:SqlDataSource>


            <asp:DropDownList ID="cmbplant_type" runat="server" DataSourceID="SqlDataSource3" DataTextField="plant_type" DataValueField="plant_type"></asp:DropDownList>
            <asp:SqlDataSource runat="server" ID="SqlDataSource3" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [plant_type] FROM [plant]"></asp:SqlDataSource>--%>

            <%-- <select>
                <option>Sort By</option>
                <option>A–Z</option>
                <option>Most Viewed</option>
                <option>Recently Added</option>
            </select>--%>
        </div>

        <!-- Plant Grid -->
        <div class="grid">

            <asp:ListView ID="list_plant" runat="server" DataSourceID="plant_list_datasource">
                <ItemTemplate>
                    <div class="card">
                        <img src='<%# Eval("plant_image") %>' alt="">
                        <div class="card-body">
                            <h4><%# Eval("plant_name") %></h4>
                            <p><%# Eval("use_of_plant") %></p>
                            <p><%# Eval("description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="plant_list_datasource" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [plant_name], [description], [use_of_plant], [plant_image] FROM [plant] WHERE ([category] = @category)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="cmbcategory" PropertyName="SelectedValue" Name="category" Type="String"></asp:ControlParameter>
                </SelectParameters>
            </asp:SqlDataSource>


        </div>

    </div>

</asp:Content>

