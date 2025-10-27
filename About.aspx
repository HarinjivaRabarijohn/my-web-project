<%@ Page Title="About Us" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="RentalCar2025.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .about-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 15px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
        }

        .section-title {
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            color: #8B0000;
            margin-bottom: 30px;
        }

        .history {
            text-align: justify;
            font-size: 16px;
            line-height: 1.8;
            color: #444;
            margin-bottom: 50px;
        }

        .grid-section {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 30px;
            text-align: center;
            margin-bottom: 50px;
        }

        .card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .card img {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
        }

        .card h4 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 8px;
            color: #333;
        }

        .card p {
            font-size: 14px;
            color: #555;
        }

        .contact-info {
            text-align: center;
            font-size: 16px;
            line-height: 1.6;
            color: #333;
        }

        .contact-info strong {
            color: #8B0000;
        }

        @media (max-width: 768px) {
            .about-container {
                padding: 20px;
            }

            .section-title {
                font-size: 28px;
            }
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="about-container">

        <div class="section-title">Our History</div>
        <div class="history">
            InstantCar Rentals was founded in 2015 with a mission to provide convenient, stylish and affordable car rental services across Mauritius for everyone. <br />
            Starting with only 5 cars and 1 office, we have grown to become one of the leading rental services on the island,
            with multiple locations and a wide range of vehicles. Our passion for customer satisfaction and innovation has earned us several national service excellence awards.
        </div>

        <div class="section-title">Our Team & Achievements</div>
        <div class="grid-section">
            <div class="card">
                <img src="images/owner.jpg" alt="Owner" />
                <h4>Rabarijohn Kanto</h4>
                <p><strong>Founder & CEO</strong><br />Visionary entrepreneur leading the company since its launch in 2015.</p>
            </div>
            <div class="card">
                <img src="images/manager.jpeg" alt="Manager" />
                <h4>Anai Soalah</h4>
                <p><strong>Operations Manager</strong><br />Oversees daily logistics and customer satisfaction nationwide.</p>
            </div>
            <div class="card">
                <img src="images/award.jpeg" alt="Awards" />
                <h4>Awards & Recognition</h4>
                <p><strong>Best Service Award 2023</strong><br />Customer Satisfaction Excellence<br /><strong>Innovation in Car Rental 2023</strong></p>
            </div>
        </div>

        <div class="section-title">Contact Us</div>
        <div class="contact-info">
            <p><strong>Address:</strong> Royal Road, Port Louis, Mauritius</p>
            <p><strong>Email:</strong> support@instantcar.mu</p>
            <p><strong>Phone:</strong> +230 5890 1234</p>
            <p><strong>Business Hours:</strong> Monday to Saturday, 8AM – 6PM <br /> Week-end and Sunday, 9AM - 13PM</p>
        </div>
    </div>
</asp:Content>
