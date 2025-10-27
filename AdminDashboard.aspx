<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/AdminDashboard.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="RentalCar2025.AdminDashboard" %>

<asp:Content ID="C1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <style>
        .counts {
            font-weight: bold;
            margin-right: 20px;
            font-size: 16px;
            color: #333;
        }
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        .action-btn {
            min-width: 90px;
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            font-weight: 600;
            transition: background-color 0.3s ease;
        }
        .btn-upgrade {
            background-color: #28a745;
        }
        .btn-upgrade:hover {
            background-color: #218838;
        }
        .btn-toggle-status {
            background-color: #ffc107;
            color: black;
        }
        .btn-toggle-status:hover {
            background-color: #e0a800;
            color: black;
        }
        .btn-delete {
            background-color: #dc3545;
        }
        .btn-delete:hover {
            background-color: #c82333;
        }
        .gridview {
            border-collapse: collapse;
            width: 100%;
            max-width: 900px;
        }
        .gridview th {
            background-color: #4CAF50;
            color: white;
            padding: 10px;
            text-align: left;
        }
        .gridview td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .gridview tr:hover {
            background-color: #f1f1f1;
        }

        /* Search UI styles */
        .search-container {
            margin: 20px 0;
            max-width: 900px;
            display: flex;
            gap: 10px;
        }
        .search-input {
            flex-grow: 1;
            padding: 8px 12px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 6px;
            transition: border-color 0.3s ease;
        }
        .search-input:focus {
            border-color: #4CAF50;
            outline: none;
        }
        .btn-search, .btn-clear {
            padding: 8px 18px;
            font-weight: 600;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            color: white;
            transition: background-color 0.3s ease;
        }
        .btn-search {
            background-color: #4CAF50;
        }
        .btn-search:hover {
            background-color: #3e8e41;
        }
        .btn-clear {
            background-color: #f44336;
        }
        .btn-clear:hover {
            background-color: #d32f2f;
        }
    </style>

    <h2>User Management</h2>

    <div>
        <label class="counts">Clients Registered: <asp:Label ID="lblClients" runat="server" /></label>
        <label class="counts">Admins Registered: <asp:Label ID="lblAdmins" runat="server" /></label>
    </div>

    <!-- Search Section -->
    <div class="search-container">
        <asp:TextBox ID="txtSearchUsers" runat="server" CssClass="search-input" Placeholder="Search by Username, Full Name or Email..." />
        <asp:Button ID="btnSearchUsers" runat="server" Text="Search" CssClass="btn-search" OnClick="btnSearchUsers_Click" />
        <asp:Button ID="btnClearSearch" runat="server" Text="Clear" CssClass="btn-clear" OnClick="btnClearSearch_Click" />
    </div>

    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="gridview" OnRowCommand="gvUsers_RowCommand" DataKeyNames="UserID">
        <Columns>
            <asp:BoundField DataField="UserID" HeaderText="User ID" />
            <asp:BoundField DataField="Username" HeaderText="Username" />
            <asp:BoundField DataField="FullName" HeaderText="Full Name" />
            <asp:BoundField DataField="email" HeaderText="Email" />
            <asp:BoundField DataField="Role" HeaderText="Role" />
            <asp:BoundField DataField="status" HeaderText="Status" />

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <div class="action-buttons">
                        <%-- Only show actions if Role = 2 (client) --%>
                        <asp:Button ID="btnUpgrade" runat="server" Text="Upgrade" CommandName="UpgradeUser" 
                            CommandArgument='<%# Eval("UserID") %>' 
                            Visible='<%# Convert.ToInt32(Eval("Role")) == 2 %>' CssClass="action-btn btn-upgrade" />

                        <asp:Button ID="btnToggleStatus" runat="server" 
                            Text='<%# Eval("status").ToString() == "Active" ? "Block" : "Activate" %>' 
                            CommandName="ToggleStatus" 
                            CommandArgument='<%# Eval("UserID") %>' 
                            Visible='<%# Convert.ToInt32(Eval("Role")) == 2 %>' CssClass="action-btn btn-toggle-status" />

                        <asp:Button ID="btnDelete" runat="server" Text="Delete" CommandName="DeleteUser" 
                            CommandArgument='<%# Eval("UserID") %>' CssClass="action-btn btn-delete"
                            OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                    </div>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>

</asp:Content>
