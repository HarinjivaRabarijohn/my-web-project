 <%@ Page Title="Login" Language="C#" MasterPageFile="~/RegisternLogin.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="RentalCar2025.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
       .form-title {
            text-align: center;
            color: #8B0000;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
        }

        .btn-link {
            background: none;
            border: none;
            color: #8B0000;
            text-decoration: underline;
            cursor: pointer;
            font-size: 14px;
            margin-top: 10px;
            width: 100%;
            display: block;
            text-align: center;
        }

        .validation-error {
            color: red;
            font-size: 13px;
            margin-top: -10px;
            margin-bottom: 10px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2 class="form-title">welcome Back!!!! <br /> 
        Login to </h2>

   <div class="form-group">
        <label for="txtUsername">Username:</label>
        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" required="true" />
    </div>

    <div class="form-group">
        <label for="txtPassword">Password:</label>
        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" required="true" />
    </div>

    <asp:Label ID="lblMessage" runat="server" CssClass="validation-error" />

    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-submit" OnClick="btnLogin_Click" /><br/><br /> 

    <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="Register.aspx" CssClass="btn-link">
    Don't have an account? Register here.
</asp:HyperLink>

</asp:Content>
