<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/ClientDashboard.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="RentalCar2025.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .vehicle-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2 columns grid */
            gap: 15px;
            padding: 20px;
            max-width: 800px;
            margin: auto;
        }

        .vehicle-card {
            position: relative;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            background-color: #fff;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .vehicle-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .vehicle-card img {
            width: 100%;
            height: 120px;
            object-fit: cover;
            display: block;
        }

        .vehicle-info {
            padding: 12px 10px;
            flex-grow: 1;
        }

        .vehicle-info h4 {
            margin: 0 0 6px;
            font-size: 16px;
            font-weight: 700;
            color: #333;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .vehicle-info p {
            margin: 4px 0;
            font-size: 13px;
            color: #555;
            line-height: 1.3;
        }

        .price {
            font-size: 14px;
            font-weight: 700;
            color: #27ae60;
            margin-top: 6px;
        }

        /* Buttons container */
        .vehicle-actions {
            display: flex;
            justify-content: space-between;
            padding: 10px 12px;
            background: #f9f9f9;
            border-top: 1px solid #ddd;
            box-sizing: border-box;
        }

        /* Buttons style */
        .vehicle-actions button,
        .vehicle-actions .btn-remove,
        .vehicle-actions .btn-book {
            flex: 1;
            margin: 0 4px;
            padding: 8px 0;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            font-size: 13px;
            transition: all 0.25s ease;
            box-shadow: 0 2px 5px rgba(0,0,0,0.12);
            color: white;
        }

        .vehicle-actions .btn-remove {
            background-color: #dc3545; /* red */
        }

        .vehicle-actions .btn-remove:hover {
            background-color: #a71d2a;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .vehicle-actions .btn-book {
            background-color: #28a745; /* green */
        }

        .vehicle-actions .btn-book:hover {
            background-color: #1e7e34;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .empty-message {
            text-align: center;
            font-size: 18px;
            color: #666;
            margin: 40px 0;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 style="text-align:center; margin-top: 20px;">My Cart</h2>

    <asp:Label ID="lblEmptyCart" runat="server" CssClass="empty-message" Visible="false" Text="Your cart is empty." />

    <div class="vehicle-container">
        <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
            <ItemTemplate>
                <div class="vehicle-card">
                    <img src='<%# Eval("image_path") %>' alt='<%# Eval("brand") %>' />
                    <div class="vehicle-info">
                        <h4><%# Eval("brand") %> <%# Eval("model") %></h4>
                        <p><strong>Year:</strong> <%# Eval("year") %></p>
                        <p><strong>Description:</strong> <%# Eval("description") %></p>
                        <p class="price">Rs <%# Eval("price_per_day") %> / day</p>
                    </div>
                    <div class="vehicle-actions">
                        <asp:Button ID="btnRemove" runat="server" CssClass="btn-remove" Text="Remove" CommandName="Remove" CommandArgument='<%# Eval("car_id") %>' />
                        <asp:Button ID="btnBook" runat="server" CssClass="btn-book" Text="Book Now" CommandName="BookNow" CommandArgument='<%# Eval("car_id") %>' />
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
