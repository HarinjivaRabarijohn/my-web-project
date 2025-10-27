<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/ClientDashboard.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="RentalCar2025.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            background: #f7f9fc;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .edit-profile-container {
            max-width: 600px;
            margin: 50px auto;
            background: #ffffff;
            padding: 40px 35px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            transition: box-shadow 0.3s ease;
        }

        .edit-profile-container:hover {
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }

        h2 {
            text-align: center;
            color: #8B0000;
            font-weight: 800;
            font-size: 2.2em;
            margin-bottom: 35px;
            letter-spacing: 1.2px;
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: 700;
            color: #444;
            font-size: 1rem;
            letter-spacing: 0.03em;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px 15px;
            margin-top: 8px;
            font-size: 1rem;
            border: 1.8px solid #ddd;
            border-radius: 8px;
            box-sizing: border-box;
            transition: border-color 0.25s ease;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #8B0000;
            outline: none;
            box-shadow: 0 0 8px rgba(139, 0, 0, 0.3);
        }

        input[readonly] {
            background-color: #f2f2f2;
            color: #888;
            cursor: not-allowed;
        }

        .btn-save {
            margin-top: 35px;
            background-color: #8B0000;
            color: white;
            padding: 15px 0;
            width: 100%;
            font-weight: 900;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 1.3rem;
            letter-spacing: 1px;
            box-shadow: 0 6px 15px rgba(139, 0, 0, 0.5);
            transition: background-color 0.3s ease, box-shadow 0.3s ease;
        }

        .btn-save:hover {
            background-color: #5c0000;
            box-shadow: 0 8px 20px rgba(92, 0, 0, 0.8);
        }

        .message {
            margin-top: 25px;
            text-align: center;
            font-weight: 700;
            font-size: 1.1rem;
            letter-spacing: 0.03em;
            padding: 12px 10px;
            border-radius: 10px;
            user-select: none;
        }

        .error-message {
            color: #a94442;
            background-color: #f2dede;
            border: 1px solid #ebccd1;
        }

        .success-message {
            color: #3c763d;
            background-color: #dff0d8;
            border: 1px solid #d6e9c6;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="edit-profile-container">
        <h2>Edit Profile</h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="message" Visible="false"></asp:Label>

        <asp:Label AssociatedControlID="txtUsername" Text="Username:" runat="server" />
        <asp:TextBox ID="txtUsername" runat="server" ReadOnly="true" />

        <asp:Label AssociatedControlID="txtFullName" Text="Full Name:" runat="server" />
        <asp:TextBox ID="txtFullName" runat="server" />

        <asp:Label AssociatedControlID="txtEmail" Text="Email:" runat="server" />
        <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" />

        <asp:Label AssociatedControlID="txtPhone" Text="Phone:" runat="server" />
        <asp:TextBox ID="txtPhone" runat="server" />

        <asp:Label AssociatedControlID="txtPassword" Text="New Password (leave blank to keep current):" runat="server" />
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" />

        <asp:Label AssociatedControlID="txtConfirmPassword" Text="Confirm New Password:" runat="server" />
        <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" />

        <asp:Button ID="btnSave" runat="server" Text="Save Changes" CssClass="btn-save" OnClick="btnSave_Click" />
    </div>
</asp:Content>
