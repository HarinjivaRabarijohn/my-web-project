<%@ Page Title="Payment" Language="C#" MasterPageFile="~/ClientDashboard.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="RentalCar2025.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .payment-container {
            max-width: 700px;
            margin: 30px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        h2 {
            color: #8B0000;
            margin-bottom: 20px;
            text-align: center;
        }

        .success-message {
            color: green;
            font-weight: 700;
            text-align: center;
            margin: 15px 0;
        }

        label {
            display: block;
            margin: 10px 0 5px;
            font-weight: 600;
            color: #4a4a4a;
        }

        input[type="text"], select, input[type="date"] {
            width: 100%;
            padding: 8px 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        input[readonly], select[disabled] {
            background-color: #eee;
            color: #666;
        }

        .btn-submit, .btn-action {
            margin-top: 20px;
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

        .btn-submit:hover, .btn-action:hover {
            background-color: #5c0000;
        }

        .btn-action {
            width: 48%;
            margin: 10px 1% 0 1%;
            display: inline-block;
            padding: 10px 0;
            font-size: 16px;
        }

        .actions-container {
            text-align: center;
            margin-top: 25px;
        }

        .car-info {
            font-weight: 700;
            margin-bottom: 10px;
            text-align: center;
            font-size: 18px;
        }

        /* GridView styling */
        .gv-bookings {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }
        .gv-bookings th, .gv-bookings td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: center;
        }
        .gv-bookings th {
            background-color: #8B0000;
            color: white;
        }
        .btn-pay, .btn-delete {
            background-color: #8B0000;
            color: white;
            border: none;
            padding: 6px 12px;
            font-weight: 600;
            cursor: pointer;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .btn-pay:hover {
            background-color: #5c0000;
        }
        .btn-delete:hover {
            background-color: #b00020;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="payment-container">

        <h2>Your Bookings</h2>
        <asp:Label ID="lblError" runat="server" CssClass="error-message"></asp:Label>

        <asp:GridView ID="gvBookings" runat="server" AutoGenerateColumns="false" CssClass="gv-bookings"
            OnRowCommand="gvBookings_RowCommand" DataKeyNames="booking_id">
            <Columns>
                <asp:BoundField DataField="booking_id" HeaderText="Booking ID" />
                <asp:BoundField DataField="car_name" HeaderText="Car" />
                <asp:BoundField DataField="start_date" HeaderText="Start Date" DataFormatString="{0:dd MMM yyyy}" />
                <asp:BoundField DataField="end_date" HeaderText="End Date" DataFormatString="{0:dd MMM yyyy}" />
                <asp:BoundField DataField="status" HeaderText="Status" />
                <asp:TemplateField HeaderText="Actions">
                    <ItemTemplate>
                        <%# Eval("status").ToString() != "Paid" ? 
                            "<button type='button' class='btn-pay' onclick=\"location.href='Payment.aspx?booking_id=" + Eval("booking_id") + "'\">Pay Now</button>" : 
                            "<span style='color:green;font-weight:bold;'>Paid</span>" %>
                        <asp:Button ID="btnDeleteBooking" runat="server" CommandName="DeleteBooking" CommandArgument='<%# Eval("booking_id") %>'
                            Text="Delete" CssClass="btn-delete" OnClientClick="return confirm('Are you sure to delete this booking?');" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>

        <asp:Panel ID="pnlBookingDetails" runat="server" Visible="false" Style="margin-top:30px;">
            <h2>Booking Payment</h2>

            <asp:Label ID="lblCarInfo" runat="server" CssClass="car-info"></asp:Label>
            <asp:Label ID="lblBookingDates" runat="server" CssClass="car-info"></asp:Label>

            <!-- Booking Edit Toggle Button -->
            <asp:Button ID="btnEditToggle" runat="server" Text="Edit Booking" CssClass="btn-action" OnClick="btnEditToggle_Click" />

            <!-- Edit Booking Panel -->
            <asp:Panel ID="pnlEditBooking" runat="server" Visible="false" Style="margin-top:20px;">
                <label for="txtStartDateEdit">Start Date *</label>
                <asp:TextBox ID="txtStartDateEdit" runat="server" TextMode="Date" CssClass="form-control" />

                <label for="txtEndDateEdit">End Date *</label>
                <asp:TextBox ID="txtEndDateEdit" runat="server" TextMode="Date" CssClass="form-control" />

                <asp:Button ID="btnSaveBookingChanges" runat="server" Text="Save Changes" CssClass="btn-submit" OnClick="btnSaveBookingChanges_Click" />
                <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" CssClass="btn-action" OnClick="btnCancelEdit_Click" />
            </asp:Panel>

            <asp:Panel ID="pnlPaymentForm" runat="server" Visible="false" Style="margin-top:20px;">
                <label for="ddlPaymentMethod">Payment Method *</label>
                <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-control" >
                    <asp:ListItem Text="Credit Card" Value="Credit Card" />
                    <asp:ListItem Text="Debit Card" Value="Debit Card" />
                    <asp:ListItem Text="PayPal" Value="PayPal" />
                    <asp:ListItem Text="Cash on Delivery" Value="Cash on Delivery" />
                </asp:DropDownList>

                <label for="txtAmount">Amount (Rs.) *</label>
                <asp:TextBox ID="txtAmount" runat="server" ReadOnly="true" CssClass="form-control" />

                <asp:Button ID="btnPay" runat="server" Text="Pay Now" CssClass="btn-submit" OnClick="btnPay_Click" />
            </asp:Panel>

            <asp:Panel ID="pnlSuccess" runat="server" Visible="false" Style="margin-top:20px;">
                <div class="success-message">Payment Successful!</div>
            </asp:Panel>
        </asp:Panel>
    </div>
</asp:Content>
