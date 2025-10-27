<%@ Page Title="Book Vehicle" Language="C#" MasterPageFile="~/ClientDashboard.Master" AutoEventWireup="true" CodeBehind="Booking.aspx.cs" Inherits="RentalCar2025.Booking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-container {
            max-width: 650px;
            margin: 30px auto;
            background: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        h2 { text-align: center; color: #8B0000; margin-bottom: 25px; font-weight: 700; }
        label { display: block; margin: 12px 0 6px; font-weight: 600; color: #4a4a4a; }
        input[type="text"], input[type="email"], input[type="tel"], select, input[type="date"], input[type="time"], textarea {
            width: 100%; padding: 8px 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 15px; box-sizing: border-box; transition: border-color 0.3s;
        }
        input:focus, select:focus, textarea:focus { outline: none; border-color: #8B0000; }
        .deals { margin-top: 15px; padding: 10px 15px; background: #f9f9f9; border-radius: 8px; border: 1px solid #ddd; }
        .deals label { display: flex; align-items: center; margin-bottom: 10px; cursor: pointer; font-weight: 500; color: #444; }
        .deals label input[type="radio"] { margin-right: 10px; cursor: pointer; }
        .deals img { height: 40px; width: auto; margin-left: 8px; border-radius: 5px; box-shadow: 0 0 4px rgba(0,0,0,0.2); }
        .error-message { color: #b00020; font-weight: 600; margin: 10px 0 0; text-align: center; }
        .btn-submit { margin-top: 25px; background-color: #8B0000; color: white; border: none; padding: 14px 0; width: 100%; font-size: 18px; border-radius: 8px; font-weight: 700; cursor: pointer; transition: background-color 0.3s ease; }
        .btn-submit:hover { background-color: #5c0000; }
    </style>

    <script>
        window.onload = function () {
            calculateTotal();
            setupChangeEvents();
        };

        function calculateTotal() {
            var pricePerDay = parseFloat(document.getElementById('<%= hfPricePerDay.ClientID %>').value) || 0;

            var startDate = document.getElementById('<%= txtStartDate.ClientID %>').value;
            var endDate = document.getElementById('<%= txtEndDate.ClientID %>').value;

            if (!startDate || !endDate) {
                document.getElementById('<%= lblTotal.ClientID %>').innerText = 'Select valid start and end dates';
                return;
            }

            var start = new Date(startDate);
            var end = new Date(endDate);
            var diffDays = Math.ceil((end - start) / (1000 * 60 * 60 * 24)) + 1;

            if (diffDays <= 0) {
                document.getElementById('<%= lblTotal.ClientID %>').innerText = 'End date must be after start date';
                return;
            }
            if (diffDays > 90) {
                document.getElementById('<%= lblTotal.ClientID %>').innerText = 'Booking cannot exceed 90 days';
                return;
            }

            var discountPercent = 0;
            var dealRadios = document.getElementsByName('rdoDeal');
            for (var i = 0; i < dealRadios.length; i++) {
                if (dealRadios[i].checked) {
                    discountPercent = parseInt(dealRadios[i].getAttribute('data-discount')) || 0;
                    break;
                }
            }

            if (diffDays >= 61) discountPercent = Math.max(discountPercent, 20);
            else if (diffDays >= 31) discountPercent = Math.max(discountPercent, 15);
            else if (diffDays >= 11) discountPercent = Math.max(discountPercent, 12);
            else if (diffDays >= 4) discountPercent = Math.max(discountPercent, 8);

            var discountedPricePerDay = pricePerDay * ((100 - discountPercent) / 100);
            discountedPricePerDay = Math.round(discountedPricePerDay);

            var total = diffDays * discountedPricePerDay;

            document.getElementById('<%= lblDiscount.ClientID %>').innerText = 'Discount: ' + discountPercent + '%';
            document.getElementById('<%= lblPricePerDay.ClientID %>').innerText = 'Price/Day after discount: Rs. ' + discountedPricePerDay;
            document.getElementById('<%= lblDays.ClientID %>').innerText = 'Total Days: ' + diffDays;
            document.getElementById('<%= lblTotal.ClientID %>').innerText = 'Total Price: Rs. ' + total;
        }

        function setupChangeEvents() {
            var controls = [
                '<%= txtStartDate.ClientID %>',
                '<%= txtEndDate.ClientID %>'
            ];
            controls.forEach(function (id) {
                var el = document.getElementById(id);
                if (el) el.onchange = calculateTotal;
            });

            var dealRadios = document.querySelectorAll('input[name="rdoDeal"]');
            dealRadios.forEach(function (radio) {
                radio.onchange = calculateTotal;
            });
        }
    </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-container">
        <h2>Book Vehicle: <asp:Label ID="lblCarName" runat="server" Text=""></asp:Label></h2>

        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error-message" HeaderText="Please fix these errors:" />

        <asp:Label ID="lblError" runat="server" CssClass="error-message" />

        <asp:Panel ID="pnlBookingForm" runat="server">
            <asp:HiddenField ID="hfCarId" runat="server" />
            <asp:HiddenField ID="hfDealId" runat="server" />
            <asp:HiddenField ID="hfPricePerDay" runat="server" />

            <label for="txtEmail">Email Address *</label>
            <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="you@example.com" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email is required" ForeColor="red" Display="Dynamic" />
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Invalid email format" ForeColor="red" Display="Dynamic" ValidationExpression="^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}$" />

            <label for="txtPhone">Phone Number *</label>
            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" MaxLength="15" placeholder="+230 5xxxxxxx" />
            <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Phone is required" ForeColor="red" Display="Dynamic" />

            <label for="txtStartDate">Start Date *</label>
            <asp:TextBox ID="txtStartDate" runat="server" TextMode="Date" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvStartDate" runat="server" ControlToValidate="txtStartDate" ErrorMessage="Start Date required" ForeColor="red" Display="Dynamic" />

            <label for="txtEndDate">End Date *</label>
            <asp:TextBox ID="txtEndDate" runat="server" TextMode="Date" CssClass="form-control" />
            <asp:RequiredFieldValidator ID="rfvEndDate" runat="server" ControlToValidate="txtEndDate" ErrorMessage="End Date required" ForeColor="red" Display="Dynamic" />

            <label for="txtDropOffLocation">Drop-off Location *</label>
            <asp:TextBox ID="txtDropOffLocation" runat="server" CssClass="form-control" MaxLength="100" />
            <asp:RequiredFieldValidator ID="rfvDropOff" runat="server" ControlToValidate="txtDropOffLocation" ErrorMessage="Drop-off location required" ForeColor="red" Display="Dynamic" />

            <label for="ddlDeliveryTime">Delivery Time *</label>
            <asp:DropDownList ID="ddlDeliveryTime" runat="server" CssClass="form-control">
                <asp:ListItem Text="08:00" Value="08:00" />
                <asp:ListItem Text="09:00" Value="09:00" />
                <asp:ListItem Text="10:00" Value="10:00" />
                <asp:ListItem Text="11:00" Value="11:00" />
                <asp:ListItem Text="12:00" Value="12:00" />
                <asp:ListItem Text="13:00" Value="13:00" />
                <asp:ListItem Text="14:00" Value="14:00" />
                <asp:ListItem Text="15:00" Value="15:00" />
                <asp:ListItem Text="16:00" Value="16:00" />
                <asp:ListItem Text="17:00" Value="17:00" />
            </asp:DropDownList>

            <div class="deals">
                <strong>Available Deals:</strong>
                <asp:Repeater ID="rptDeals" runat="server">
                    <ItemTemplate>
                        <label>
                            <input type="radio" name="rdoDeal" value='<%# Eval("deal_id") %>' data-discount='<%# Eval("discount_percent") %>' />
                            <%# Eval("title") %> (<%# Eval("discount_percent") %>%)
                            <asp:Image runat="server" ImageUrl='<%# Eval("image_path") %>' AlternateText="Deal Image" CssClass="deal-img" />
                        </label>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <div style="margin-top:15px;">
                <label><asp:Label ID="lblDiscount" runat="server" Text=""></asp:Label></label><br />
                <label><asp:Label ID="lblPricePerDay" runat="server" Text=""></asp:Label></label><br />
                <label><asp:Label ID="lblDays" runat="server" Text=""></asp:Label></label><br />
                <label><asp:Label ID="lblTotal" runat="server" Text=""></asp:Label></label>
            </div>

            <asp:Button ID="btnBook" runat="server" Text="Book Now" CssClass="btn-submit" OnClick="btnBook_Click" />
        </asp:Panel>
    </div>
</asp:Content>
