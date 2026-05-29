<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <title>Virtual Herbal Garden - Home</title>

    <style>
        :root {
            --bg: #f0f8f4;
            --card: #ffffff;
            --accent: #1f7a3a;
            --accent-light: #2aa06c;
            --muted: #6b7280;
            --shadow: 0 4px 15px rgba(0,0,0,0.10);
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg);
        }

        /* HERO / BANNER */
        .hero {
            background: url('https://images.unsplash.com/photo-1501004318641-b39e6451bec6?auto=format&fit=crop&w=1500&q=80') center/cover no-repeat;
            height: 420px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px;
            color: white;
        }

            .hero h1 {
                font-size: 44px;
                margin: 0;
                text-shadow: 0 3px 10px rgba(0,0,0,0.5);
            }

            .hero p {
                margin-top: 12px;
                font-size: 18px;
                max-width: 700px;
                text-shadow: 0 2px 6px rgba(0,0,0,0.5);
            }

        /* SEARCH BAR */
        .search-area {
            margin-top: -30px;
            display: flex;
            gap: 10px;
            width: 90%;
            max-width: 800px;
        }

            .search-area input {
                flex: 1;
                padding: 14px;
                border-radius: 12px;
                border: 1px solid #ccc;
                font-size: 16px;
            }

            .search-area select {
                padding: 14px;
                border-radius: 12px;
                border: 1px solid #ccc;
                background: white;
                font-size: 16px;
            }

            .search-area button {
                padding: 14px 20px;
                background: var(--accent);
                border: none;
                color: white;
                font-size: 16px;
                font-weight: bold;
                border-radius: 12px;
                cursor: pointer;
            }

                .search-area button:hover {
                    background: var(--accent-light);
                }

        /* PAGE CONTAINER */
        .container {
            max-width: 1100px;
            margin: auto;
            padding: 25px;
        }

        /* SECTION TITLE */
        .section-title {
            margin: 25px 0 12px 0;
            font-size: 26px;
            font-weight: bold;
            color: #1b2a1d;
        }

        /* CATEGORIES */
        .categories {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .category {
            padding: 10px 18px;
            border: 1px solid #d0d5d2;
            background: white;
            border-radius: 25px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }

            .category:hover {
                background: var(--accent);
                color: white;
                border-color: var(--accent);
            }

        /* GRID OF PLANTS */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(260px,1fr));
            gap: 20px;
            margin-top: 15px;
        }

        .card {
            background: white;
            border-radius: 12px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

            .card img {
                height: 160px;
                width: 100%;
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
                color: var(--muted);
                font-size: 14px;
                margin-top: 6px;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <!-- HERO BANNER -->
    <div class="hero">
        <h1>Virtual Herbal Garden</h1>
        <p>Explore medicinal plants, natural remedies, and the healing power of Ayurveda.</p>
        <br />
        <!-- SEARCH AREA -->
        <div class="search-area">
            <asp:TextBox ID="txtsearch" runat="server" placeholder="Search by plant name (e.g., Tulsi)"></asp:TextBox>
            <%--<asp:DropDownList ID="cmbuse" runat="server" DataSourceID="SqlDataSource2" DataTextField="use_of_plant" DataValueField="use_of_plant"></asp:DropDownList>
            <asp:SqlDataSource runat="server" ID="SqlDataSource2" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [use_of_plant] FROM [plant]"></asp:SqlDataSource>--%>
            <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" />
        </div>
    </div>


    <div class="container">

        <!-- CATEGORIES -->
        <h2 class="section-title">Browse Categories</h2>

        <div class="categories">
            <asp:ListView ID="ListView1" runat="server" DataSourceID="SqlDataSource1">
                <ItemTemplate>
                    <asp:LinkButton
                        ID="lnkCategory"
                        runat="server"
                        CssClass="category"
                        CommandArgument='<%# Eval("category_name") %>'
                        OnCommand="lnkCategory_Command">
        
        <%# Eval("category_name") %>
    
                    </asp:LinkButton>
                </ItemTemplate>
            </asp:ListView>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [category_name] FROM [herb_category]"></asp:SqlDataSource>
        </div>

        <!-- FEATURED PLANTS -->
        <h2 class="section-title">Featured Medicinal Plants</h2>

        <div class="grid">

            <asp:ListView ID="list_plant" runat="server">
                <%--DataSourceID="plant_list_datasource"--%>
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
            <asp:SqlDataSource runat="server" ID="plant_list_datasource" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [id], [plant_name], [category], [description], [use_of_plant], [plant_image] FROM [plant]"></asp:SqlDataSource>




        </div>

    </div>

</asp:Content>

