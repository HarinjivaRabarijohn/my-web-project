<%@ Page Title="Bookings & Feedback" Language="C#" MasterPageFile="~/AdminDashboard.Master" AutoEventWireup="true" CodeBehind="BookingsFeedback.aspx.cs" Inherits="RentalCar2025.BookingsFeedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="Head" runat="server">
    <style>
        /* Table styling */
        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 40px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px 15px;
            text-align: left;
        }
        th {
            background-color: #007bff;
            color: white;
            font-weight: 600;
            letter-spacing: 0.05em;
            text-transform: uppercase;
        }
        tbody tr:hover {
            background-color: #f1faff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        /* Buttons */
        .btn-approve, .btn-cancel {
            padding: 6px 14px;
            border: none;
            border-radius: 4px;
            color: white;
            font-weight: 600;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 8px;
            font-size: 0.9rem;
        }
        .btn-approve {
            background-color: #28a745;
        }
        .btn-approve:hover {
            background-color: #218838;
        }
        .btn-cancel {
            background-color: #dc3545;
        }
        .btn-cancel:hover {
            background-color: #c82333;
        }

        h2 {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
            margin-top: 30px;
            margin-bottom: 20px;
            font-weight: 700;
            letter-spacing: 0.05em;
        }

        .message-label {
            font-weight: 600;
            margin-bottom: 20px;
            display: block;
            color: #dc3545;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h2>All Bookings</h2>
    <asp:Label ID="lblBookingMessage" runat="server" CssClass="message-label"></asp:Label>

    <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="false" OnRowCommand="gvBookings_RowCommand" CssClass="table">
        <Columns>
            <asp:BoundField DataField="booking_id" HeaderText="Booking ID" />
            <asp:BoundField DataField="Username" HeaderText="User" />
            <asp:BoundField DataField="car" HeaderText="Car" />
            <asp:BoundField DataField="start_date" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="end_date" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
            <asp:BoundField DataField="status" HeaderText="Status" />
            <asp:BoundField DataField="payment_amount" HeaderText="Payment (Rs.)" DataFormatString="{0:N2}" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="phone" HeaderText="Phone" />
            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnApprove" runat="server" CommandName="Approve" CommandArgument='<%# Eval("booking_id") %>' Text="Approve" CssClass="btn-approve" Enabled='<%# Eval("status").ToString().ToLower() == "pending" %>' />
                    <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" CommandArgument='<%# Eval("booking_id") %>' Text="Cancel" CssClass="btn-cancel" Enabled='<%# Eval("status").ToString().ToLower() == "pending" %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

    <h2>User Feedback</h2>
    <asp:GridView ID="gvFeedback" runat="server" AutoGenerateColumns="false" CssClass="table">
        <Columns>
            <asp:BoundField DataField="feedback_id" HeaderText="Feedback ID" />
            <asp:BoundField DataField="Username" HeaderText="User" />
            <asp:BoundField DataField="rating" HeaderText="Rating" />
            <asp:BoundField DataField="comment" HeaderText="Comment" />
            <asp:BoundField DataField="submitted_on" HeaderText="Submitted On" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
        </Columns>
    </asp:GridView>

</asp:Content>
