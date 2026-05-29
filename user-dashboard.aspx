<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="user-dashboard.aspx.cs" Inherits="user_dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style>
        :root {
            --bg: #f4faff;
            --card: #ffffff;
            --accent: #1f7a3a;
            --muted: #6b7280;
            --shadow: 0 4px 12px rgba(0,0,0,0.08);
            font-family: Arial, Helvetica, sans-serif;
        }

        body {
            margin: 0;
            background: var(--bg);
            padding: 20px;
        }

        /* Container */
        .container {
            max-width: 1100px;
            margin: auto;
        }

        /* Welcome section */
        h2 {
            margin: 0;
            font-size: 28px;
            color: #1b2a1d;
        }

        .subtitle {
            color: var(--muted);
            margin-top: 4px;
        }

        /* Search bar */
        .search-bar {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }

            .search-bar input {
                width: 100%;
                padding: 12px;
                border-radius: 12px;
                border: 1px solid #ccc;
            }

        .btn {
            padding: 12px 16px;
            background: var(--accent);
            color: white;
            border: none;
            border-radius: 12px;
            cursor: pointer;
        }

        /* Categories */
        .section-title {
            margin: 25px 0 10px 0;
            font-size: 20px;
            color: #1b2a1d;
        }

        .categories {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .category {
            padding: 10px 16px;
            background: var(--card);
            border: 1px solid #ddd;
            border-radius: 25px;
            font-size: 14px;
            cursor: pointer;
            font-weight: 600;
        }

        /* Cards Grid */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px,1fr));
            gap: 20px;
        }

        .card {
            background: var(--card);
            border-radius: 12px;
            box-shadow: var(--shadow);
            overflow: hidden;
        }

            .card img {
                width: 100%;
                height: 150px;
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
                margin-top: 6px;
                font-size: 14px;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <asp:Label ID="lblmobile_no" runat="server" Visible="false"></asp:Label>

    <div class="container">

        
        <h2>Welcome,
            <asp:Label ID="lblusername" runat="server"></asp:Label></h2>
        <p class="subtitle">Explore plants & your saved favorites</p>

        
        <%--<div class="search-bar">
            <asp:TextBox ID="txtsearch" runat="server" placeholder="Search herbs... (e.g., Tulsi, Neem)"></asp:TextBox>
            <asp:Button ID="btnsearch" runat="server" Text="Search" OnClick="btnsearch_Click" />
            
        </div>--%>

        <!-- Categories Section -->
        <%--<h3 class="section-title">Herb Categories</h3>--%>
        <div class="categories">
            <%--<asp:ListView ID="ListView1" runat="server" OnItemCommand="ListView1_ItemCommand">
                <ItemTemplate>

                    

                    <asp:LinkButton ID="lnkCategory" runat="server"
                        Text='<%# Eval("category_name") %>'
                        CommandName="ViewCategory"
                        CommandArgument='<%# Eval("id") %>'
                        CssClass="category">
                    </asp:LinkButton>

                </ItemTemplate>
            </asp:ListView>--%>
            <asp:SqlDataSource runat="server" ID="SqlDataSource1" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [category_name], id FROM [herb_category]"></asp:SqlDataSource>
        </div>

        <!-- Recently Viewed -->
        <h3 class="section-title">Recently Viewed Plants</h3>
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
            <asp:SqlDataSource runat="server" ID="plant_list_datasource" ConnectionString='<%$ ConnectionStrings:connection %>' SelectCommand="SELECT DISTINCT [id], [plant_name], [category], [description], [use_of_plant], [plant_image] FROM [plant]"></asp:SqlDataSource>



            <%--<div class="card">
                <img src="https://picsum.photos/seed/neem/600/400" alt="">
                <div class="card-body">
                    <h4>Neem</h4>
                    <p>Powerful antibacterial</p>
                </div>
            </div>--%>
        </div>

        <!-- Saved Favorites -->
        <%--<h3 class="section-title">Saved Favorites</h3>
        <div class="grid">

            <div class="card">
                <img src="https://picsum.photos/seed/aloe/600/400" alt="">
                <div class="card-body">
                    <h4>Aloe Vera</h4>
                    <p>Skin healing & digestion</p>
                </div>
            </div>

            <div class="card">
                <img src="https://picsum.photos/seed/ashwa/600/400" alt="">
                <div class="card-body">
                    <h4>Ashwagandha</h4>
                    <p>Reduces stress</p>
                </div>
            </div>

        </div>--%>
    </div>

</asp:Content>

