<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/AdminDashboard.Master" AutoEventWireup="true" CodeBehind="EditProfilAdmin.aspx.cs" Inherits="RentalCar2025.EditProfileAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        :root {
            --bg: #ffffff;
            --text: #333333;
            --primary: #007bff;
            --border: #cccccc;
            --btn-hover: #0056b3;
        }

        body.dark-mode {
            --bg: #1c1e21;
            --text: #f1f1f1;
            --primary: #3498db;
            --border: #444;
            --btn-hover: #2980b9;
        }

        .form-container {
            max-width: 600px;
            margin: 50px auto;
            background-color: var(--bg);
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
        }

        .form-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: var(--text);
            font-size: 26px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text);
        }

        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid var(--border);
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
            transition: border-color 0.3s;
            background-color: var(--bg);
            color: var(--text);
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
        }

        .btn {
            padding: 10px 16px;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            background-color: var(--primary);
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
        }

        .btn:hover {
            background-color: var(--btn-hover);
        }

        #lblMessage {
            display: block;
            text-align: center;
            font-weight: 600;
            margin-bottom: 20px;
            font-size: 14px;
        }

        #lblMessage.success {
            color: green;
        }

        #lblMessage.error {
            color: red;
        }

        .toggle-mode {
            text-align: right;
            margin-bottom: 20px;
        }

        .toggle-mode button {
            background: transparent;
            border: 1px solid var(--border);
            padding: 6px 12px;
            border-radius: 6px;
            color: var(--text);
            cursor: pointer;
            font-size: 14px;
        }

        .toggle-mode button:hover {
            background-color: var(--primary);
            color: white;
        }

        @media (max-width: 600px) {
            .form-container {
                margin: 20px;
                padding: 25px;
            }

            .form-container h2 {
                font-size: 22px;
            }
        }
    </style>

    <script type="text/javascript">
        function toggleMode() {
            document.body.classList.toggle("dark-mode");
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <div class="toggle-mode">
            <button type="button" onclick="toggleMode()">🌗 </button>
        </div>

        <h2>Edit Admin Profile</h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="success" Visible="false"></asp:Label>

        <div class="form-group">
            <label for="txtUsername">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtEmail">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="txtPassword">Password</label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="form-group">
            <label for="ddlStatus">Status</label>
            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control">
                <asp:ListItem Text="Active" Value="Active" />
                <asp:ListItem Text="Blocked" Value="Blocked" />
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn" OnClick="btnUpdate_Click" />
    </div>
</asp:Content>
