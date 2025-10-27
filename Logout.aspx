<%@ Page Title="Logout" Language="C#" MasterPageFile="~/RegisternLogin.Master" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="RentalCar2025.Logout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        .goodbye-message {
            max-width: 400px;
            margin: 150px auto;
            padding: 30px;
            background: #f8f9fa;
            border-radius: 10px;
            text-align: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 24px;
            color: #333;
            animation: fadeOut 3s forwards;
        }

        @keyframes fadeOut {
            0% { opacity: 1; }
            80% { opacity: 1; }
            100% { opacity: 0; }
        }
    </style>

    <script type="text/javascript">
        // Redirect after 3 seconds
        setTimeout(function () {
            window.location.href = "HomePage.aspx";
        }, 3000);
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="goodbye-message">
        Goodbye! Thank you for visiting our page...
    </div>
</asp:Content>
