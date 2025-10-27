<%@ Page Title="Register" Language="C#" MasterPageFile="~/RegisternLogin.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="RentalCar2025.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        input, select {
            padding: 8px;
            margin: 6px 0 12px 0;
            width: 100%;
            box-sizing: border-box;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        .btn-submit {
            background-color: #8B0000;
            color: white;
            border: none;
            padding: 10px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            width: 100%;
        }
        .btn-link {
            background: none;
            border: none;
            color: #8B0000;
            text-decoration: underline;
            cursor: pointer;
            margin-top: 10px;
            font-size: 14px;
        }
        .validation-error {
            color: red;
            font-size: 13px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Label ID="lblMessage" runat="server" CssClass="validation-error" />

    <asp:TextBox ID="txtFullName" runat="server" placeholder="Full Name" />
    <asp:RequiredFieldValidator ID="rfvFullName" ControlToValidate="txtFullName" ErrorMessage="Full Name is required." CssClass="validation-error" runat="server" />

    <asp:TextBox ID="txtUsername" runat="server" placeholder="Username" />
    <asp:RequiredFieldValidator ID="rfvUsername" ControlToValidate="txtUsername" ErrorMessage="Username is required." CssClass="validation-error" runat="server" />

    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Password" />
    <asp:RequiredFieldValidator ID="rfvPassword" ControlToValidate="txtPassword" ErrorMessage="Password is required." CssClass="validation-error" runat="server" />
    <asp:RegularExpressionValidator ID="revPassword" ControlToValidate="txtPassword" ErrorMessage="Password must be at least 8 characters." ValidationExpression=".{8,}" CssClass="validation-error" runat="server" />

    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Confirm Password" />
    <asp:RequiredFieldValidator ID="rfvConfirmPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Confirm Password is required." CssClass="validation-error" runat="server" />
    <asp:CompareValidator ID="cvPasswordMatch" ControlToCompare="txtPassword" ControlToValidate="txtConfirmPassword" ErrorMessage="Passwords do not match." CssClass="validation-error" runat="server" />

    <asp:DropDownList ID="ddlRole" runat="server">
        <asp:ListItem Text="Select Role" Value="0" />
        <asp:ListItem Text="Admin" Value="Admin" />
        <asp:ListItem Text="Client" Value="Client" />
    </asp:DropDownList>
    <asp:RequiredFieldValidator ID="rfvRole" ControlToValidate="ddlRole" InitialValue="0" ErrorMessage="Please select a role." CssClass="validation-error" runat="server" />

    <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-submit" OnClick="btnRegister_Click" />

   <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="Login.aspx" CssClass="btn-link">
    Already have an account? Login here.
</asp:HyperLink>


</asp:Content>
