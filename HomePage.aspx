<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="RentalCar2025.HomePage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .section {
            padding: 40px 5%;
            background-color: #fff;
            margin-bottom: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .car-card {
            background-color: #fafafa;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }

        .car-card:hover {
            transform: scale(1.03);
        }

        .car-card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .car-body {
            padding: 15px;
        }

        .car-title {
            font-weight: bold;
            font-size: 1.1em;
            margin-bottom: 5px;
        }

        .car-description {
            font-size: 0.9em;
            color: #555;
            margin-bottom: 5px;
        }

        .car-price {
            font-weight: bold;
            color: #34495e;
        }

        .search-bar {
            max-width: 700px;
            margin: 40px auto 20px auto;
            display: flex;
        }

        .search-bar input[type="text"] {
            flex: 1;
            padding: 12px 20px;
            font-size: 16px;
            border: 2px solid #ccc;
            border-radius: 8px 0 0 8px;
            outline: none;
        }

        .search-bar button {
            padding: 12px 25px;
            background-color: #f2943e;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 0 8px 8px 0;
            cursor: pointer;
            transition: 0.3s;
        }

        .search-bar button:hover {
            background-color: #d67c2d;
        }

        .deal-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .deal-card {
            width: 100%;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
            border-radius: 10px;
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .deal-card:hover {
         transform: scale(1.03);
         box-shadow: 0 4px 12px rgba(0,0,0,0.2);
         }

        .deal-card img {
            width: 100%;
            height: 160px;
            object-fit: cover;
        }

        .deal-body {
            padding: 15px;
        }

        .deal-tag {
            font-size: 0.85em;
            color: #fff;
            background-color: #f2943e;
            display: inline-block;
            padding: 4px 8px;
            border-radius: 5px;
            margin-bottom: 8px;
        }

        .deal-title {
            font-size: 1.1em;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .deal-description {
            font-size: 0.95em;
            color: #555;
        }
        .deal-grid {
         display: grid;
         grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
         gap: 20px;
         }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="search-bar">
        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search cars, offers, models..."></asp:TextBox>
        <asp:Button ID="btnSearch" runat="server" Text="Search" OnClick="btnSearch_Click" />
    </div>

    <!-- Featured Cars Section -->
    <section class="section">
        <h2>Our best Featured cars</h2>
         <div class="car-grid">
       <asp:Repeater ID="rptCars" runat="server">
    <ItemTemplate>
        <div class="car-card">
            <img src='<%# Eval("image_path") %>' alt='<%# Eval("model") %>' />
            <div class="car-body">
                <div class="car-title"><%# Eval("brand") %> <%# Eval("model") %></div>
                <div class="car-description"><%# Eval("description") %></div>
                <div class="car-price">Rs <%# String.Format("{0:N0}", Eval("price_per_day")) %> / day</div>
            </div>
        </div>
    </ItemTemplate>
</asp:Repeater>
             </div>
    </section>

    <!-- Deals Section -->
    <section class="section">
        <h2>Latest Deals</h2>
        <div class="deal-grid">
        <asp:Repeater ID="rptDeals" runat="server">
            <ItemTemplate>
                <div class="deal-card">
                        <img src='<%# Eval("image_path") %>' alt='<%# Eval("title") %>' />
                        <div class="deal-body">
                            <div class="deal-tag">SAVE <%# Eval("discount_percent") %>%</div>
                            <div class="deal-title"><%# Eval("title") %></div>
                            <div class="deal-description"><%# Eval("description") %></div>
                        </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
            </div>
    </section>

    <!-- About Us Section -->
    <section class="section">
        <h2>About Us</h2>
        <p>
            InstantCar has been serving Mauritius for over 10 years now, offering reliable car rentals to locals and tourists alike.
            We provide only the best car for you.
        </p>
    </section>
</asp:Content>