<%@ Page Title="Deals" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Deals.aspx.cs" Inherits="RentalCar2025.Deals" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .deals-section {
            padding: 50px 5%;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            margin: 30px auto;
        }

        .deals-section h2 {
            font-size: 2em;
            color: #8B0000;
            margin-bottom: 25px;
            text-align: center;
            border-bottom: 2px solid #f2943e;
            display: inline-block;
            padding-bottom: 5px;
        }

        .deal-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            justify-content: center;
        }

        .deal-card {
            background-color: #fafafa;
            width: 300px;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .deal-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        }

        .deal-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
        }

        .deal-body {
            padding: 18px;
            text-align: center;
        }

        .deal-title {
            font-size: 20px;
            color: #8B0000;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .deal-description {
            font-size: 15px;
            color: #555;
            line-height: 1.5;
        }

        .deal-tag {
            background-color: #f2943e;
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            display: inline-block;
            margin-bottom: 12px;
            font-size: 13px;
        }

        .explore-link {
            margin-top: 30px;
            display: block;
            text-align: center;
            font-weight: bold;
            color: #8B0000;
            text-decoration: underline;
        }

        .explore-link:hover {
            color: #a52a2a;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="deals-section">
        <h2>Hot Deals Just For You!</h2>
        <div class="deal-cards">
            <div class="deal-card">
                <img src="images/deal1.jpeg" alt="Long Term Discount" />
                <div class="deal-body">
                    <div class="deal-tag">SAVE 15%</div>
                    <div class="deal-title">Long Term Rental</div>
                    <div class="deal-description">
                        Rent for more than 30 days and get 15% off on your total price!
                    </div>
                </div>
            </div>

            <div class="deal-card">
                <img src="images/deal2.jpeg" alt="Early Bird Offer" />
                <div class="deal-body">
                    <div class="deal-tag">EARLY BIRD</div>
                    <div class="deal-title">Book Early & Save</div>
                    <div class="deal-description">
                        Reserve your car 2 weeks in advance and get 5% off instantly.
                    </div>
                </div>
            </div>

            <div class="deal-card">
                <img src="images/deal3.jpeg" alt="Weekend Deal" />
                <div class="deal-body">
                    <div class="deal-tag">WEEKEND SPECIAL</div>
                    <div class="deal-title">Free Fuel on Weekends</div>
                    <div class="deal-description">
                        Book any car for Friday–Sunday and enjoy free fuel up to Rs 500.
                    </div>
                </div>
            </div>

            <div class="deal-card">
                <img src="images/deal4.png" alt="Family Pack" />
                <div class="deal-body">
                    <div class="deal-tag">FAMILY DEAL</div>
                    <div class="deal-title">Family Bundle</div>
                    <div class="deal-description">
                        Rent a 7-seater for 5+ days and get free child seat & 10% off.
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
