<%@ Page Title="Client Dashboard" Language="C#" MasterPageFile="~/ClientDashboard.master" AutoEventWireup="true" CodeBehind="ClientDashboard.aspx.cs" Inherits="RentalCar2025.ClientDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .dashboard-container {
            padding: 30px;
            max-width: 1200px;
            margin: auto;
            background-color: #f4f4f4;
            border-radius: 20px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.12);
        }
        .welcome-message {
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 35px;
            text-align: center;
            color: #8B0000;
        }
        .card-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 30px;
        }
        .dashboard-card {
            background-color: #fff;
            width: 240px;
            padding: 25px 20px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }
        .dashboard-card:hover {
            transform: scale(1.05);
        }
        .dashboard-card img {
            width: 100px;
            height: 100px;
            object-fit: contain;
            margin-bottom: 15px;
        }
        .dashboard-card h4 {
            margin-bottom: 15px;
            color: #8B0000;
            font-size: 18px;
            font-weight: 600;
        }
        .dashboard-button {
            padding: 10px 16px;
            background-color: #8B0000;
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }
        .dashboard-button:hover {
            background-color: #a52a2a;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="dashboard-container">
        <div class="welcome-message">
            Welcome, <asp:Label ID="txtUsername" runat="server" Text="Client" />
        </div>
        <div class="card-grid">
            <div class="dashboard-card">
                <img src="images/search.png" alt="Search Vehicles" />
                <h4>Search Vehicles</h4>
                <asp:Button ID="btnSearch" runat="server" Text="Search Now" CssClass="dashboard-button" OnClick="btnSearch_Click" />
            </div>
            <div class="dashboard-card">
                <img src="images/cart.png" alt="View Cart" />
                <h4>My Cart</h4>
                <asp:Button ID="btnCart" runat="server" Text="View Cart" CssClass="dashboard-button" OnClick="btnCart_Click" />
            </div>
            <div class="dashboard-card">
                <img src="images/history.jpeg" alt="Booking History" />
                <h4>Booking History</h4>
                <asp:Button ID="btnBookingHistory" runat="server" Text="History" CssClass="dashboard-button" OnClick="btnBookingHistory_Click" />
            </div>
            <div class="dashboard-card">
                <img src="images/edit.png" alt="Edit Profile" />
                <h4>Edit Profile</h4>
                <asp:Button ID="btnEditProfile" runat="server" Text="Update Info" CssClass="dashboard-button" OnClick="btnEditProfile_Click" />
            </div>
            <div class="dashboard-card">
                <img src="images/logout.png" alt="Logout" />
                <h4>Logout</h4>
                <asp:Button ID="btnLogout" runat="server" Text="Log Out" CssClass="dashboard-button" OnClick="btnLogout_Click" />
            </div>
        </div>
    </div>
</asp:Content>