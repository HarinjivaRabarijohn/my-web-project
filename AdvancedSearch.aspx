<%@ Page Title="Advanced Search" Language="C#" MasterPageFile="~/ClientDashboard.Master" AutoEventWireup="true" CodeBehind="AdvancedSearch.aspx.cs" Inherits="RentalCar2025.AdvancedSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .search-container {
            max-width: 700px;
            margin: 20px auto;
            text-align: center;
        }
        .form-control {
            padding: 8px 10px;
            font-size: 15px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }
        .btn-submit {
            background-color: #8B0000;
            color: white;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .btn-submit:hover {
            background-color: #5c0000;
        }
        .sort-container {
            max-width: 700px;
            margin: 10px auto 30px;
            text-align: center;
        }
        .grid-container {
            max-width: 900px;
            margin: 0 auto 50px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        h2 {
            color: #8B0000;
            margin-bottom: 15px;
            text-align: center;
        }
        .gvCars, .gvDeals {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .gvCars th, .gvCars td, .gvDeals th, .gvDeals td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .gvCars th, .gvDeals th {
            background-color: #8B0000;
            color: white;
        }
        .gvCars tr:nth-child(even), .gvDeals tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .image-cell img {
            max-width: 100px;
            height: auto;
            border-radius: 5px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Search Bar -->
    <div class="search-container">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" 
                     Placeholder="Search by Brand, Model or Deal Title..." 
                     AutoPostBack="true" OnTextChanged="txtSearch_TextChanged"
                     style="width:60%; display:inline-block; margin-right:10px;" />
        <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn-submit" OnClick="btnSearch_Click" style="display:inline-block;" />
    </div>

    <!-- Sort Dropdown -->
    <div class="sort-container">
        <label for="ddlSort">Sort by: </label>
        <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlSort_SelectedIndexChanged" style="width: 200px; display:inline-block; margin-left:10px;">
            <asp:ListItem Text="Price: Low to High" Value="price_asc" />
            <asp:ListItem Text="Price: High to Low" Value="price_desc" />
            <asp:ListItem Text="Brand/Model: A to Z" Value="brand_asc" />
            <asp:ListItem Text="Brand/Model: Z to A" Value="brand_desc" />
        </asp:DropDownList>
    </div>

    <!-- Cars Grid -->
    <div class="grid-container">
        <h2>Cars </h2>
        <asp:GridView ID="gvCars" runat="server" AutoGenerateColumns="False" CssClass="gvCars" GridLines="None">
            <Columns>
                <asp:BoundField DataField="car_id" HeaderText="Car ID" Visible="false" />
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgCar" runat="server" ImageUrl='<%# Eval("image_path") %>' AlternateText="Car Image" CssClass="car-image" Width="100px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="brand" HeaderText="Brand" />
                <asp:BoundField DataField="model" HeaderText="Model" />
                <asp:BoundField DataField="year" HeaderText="Year" />
                <asp:BoundField DataField="description" HeaderText="Description" />
                <asp:BoundField DataField="price_per_day" HeaderText="Price (Rs/Day)" DataFormatString="{0:C}" />
            </Columns>
        </asp:GridView>
    </div>

    <!-- Deals Grid -->
    <div class="grid-container">
        <h2>Deals</h2>
        <asp:GridView ID="gvDeals" runat="server" AutoGenerateColumns="False" CssClass="gvDeals" GridLines="None">
            <Columns>
                <asp:BoundField DataField="deal_id" HeaderText="Deal ID" Visible="false" />
                <asp:TemplateField HeaderText="Image">
                    <ItemTemplate>
                        <asp:Image ID="imgDeal" runat="server" ImageUrl='<%# Eval("image_path") %>' AlternateText="Deal Image" CssClass="deal-image" Width="100px" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="title" HeaderText="Title" />
                <asp:BoundField DataField="description" HeaderText="Description" />
                <asp:BoundField DataField="discount_percent" HeaderText="Discount (%)" />
                <asp:BoundField DataField="valid_until" HeaderText="Valid Until" DataFormatString="{0:dd MMM yyyy}" />
                <asp:TemplateField HeaderText="Car Brand/Model">
                    <ItemTemplate>
                        <%# Eval("brand") != DBNull.Value ? Eval("brand").ToString() + " / " + Eval("model").ToString() : "N/A" %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
