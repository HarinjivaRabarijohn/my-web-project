<%@ Page Title="" Language="C#" MasterPageFile="~/ClientDashboard.Master" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="RentalCar2025.Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .feedback-container {
            max-width: 600px;
            margin: 40px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        h2 {
            text-align: center;
            color: #8B0000;
            margin-bottom: 25px;
        }

        label {
            font-weight: 600;
            color: #444;
            margin-top: 15px;
            display: block;
        }

        select, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        .btn-submit {
            margin-top: 25px;
            background-color: #8B0000;
            color: white;
            border: none;
            padding: 12px 0;
            width: 100%;
            font-size: 18px;
            border-radius: 8px;
            font-weight: 700;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-submit:hover {
            background-color: #5c0000;
        }

        .message {
            text-align: center;
            margin-top: 20px;
            font-weight: 600;
        }

        .error {
            color: #d9534f;
        }

        .success {
            color: #28a745;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="feedback-container">
        <h2>Submit Your Feedback</h2>

        <asp:Label ID="lblMessage" runat="server" CssClass="message" />

        <label for="ddlRating">Rating (1 to 5): *</label>
        <asp:DropDownList ID="ddlRating" runat="server" CssClass="form-control">
            <asp:ListItem Text="Select rating" Value="" />
            <asp:ListItem Text="1" Value="1" />
            <asp:ListItem Text="2" Value="2" />
            <asp:ListItem Text="3" Value="3" />
            <asp:ListItem Text="4" Value="4" />
            <asp:ListItem Text="5" Value="5" />
        </asp:DropDownList>

        <label for="txtComment">Comment:</label>
        <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine" CssClass="form-control" MaxLength="500" />

        <asp:Button ID="btnSubmit" runat="server" Text="Submit Feedback" CssClass="btn-submit" OnClick="btnSubmit_Click" />
    </div>
</asp:Content>
