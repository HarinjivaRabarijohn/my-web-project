<%@ Page Title="Our Cars" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="Cars.aspx.cs" Inherits="RentalCar2025.Cars" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .car-list-container {
            max-width: 1200px;
            margin: 50px auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.07);
        }

        .car-list-title {
            text-align: center;
            font-size: 36px;
            color: #8B0000;
            font-weight: 700;
            margin-bottom: 40px;
        }

        .car-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 35px;
        }

        .car-card {
           background-color: #fff;
            padding: 20px;
            border-radius: 14px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
            transition: transform 0.3s ease, background-color 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            cursor: pointer;
        }

        .car-card:hover {
            transform: translateY(-5px);
            background-color: #fcecec;
        }

        .car-card img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .car-name {
            font-size: 22px;
            font-weight: 700;
            color: #222;
            margin-bottom: 6px;
        }

        .car-brand {
            font-size: 16px;
            color: #666;
            margin-bottom: 8px;
        }

        .car-description {
            font-size: 14px;
            color: #777;
            padding: 0 10px;
            line-height: 1.5;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="car-list-container">
        <div class="car-list-title">Explore Our Cars</div>
        <div class="car-grid">
         

            <div class="car-card">
                <img src="images/car1.jpeg" alt="Sedan">
                <div class="car-name">Toyota Corolla</div>
                <div class="car-brand">Toyota - 2021</div>
                <div class="car-description">Comfortable and fuel efficient sedan for city drives.</div>
            </div>

            <div class="car-card">
                <img src="images/suv.jpeg" alt="SUV">
                <div class="car-name">Nissan X-Trail</div>
                <div class="car-brand">Nissan - 2023</div>
                <div class="car-description">Spacious SUV ideal for family and countryside tours.</div>
            </div>
            <div class="car-card">
                <img src="images/mini.jpeg" alt="Mini Cooper" />
                <div class="car-name">Mini Cooper</div>
                <div class="car-brand">Mini - 2022</div>
                <div class="car-description">Compact luxury hatchback with stylish design and great handling.</div>
            </div>

            <div class="car-card">
                <img src="images/convertible.jpeg" alt="Convertible">
                <div class="car-name">BMW Z4</div>
                <div class="car-brand">BMW - 2022</div>
                <div class="car-description">Stylish convertible perfect for sunny coastal rides.</div>
            </div>

            <div class="car-card">
                <img src="images/jeep.jpeg" alt="Jeep">
                <div class="car-name">Jeep Wrangler</div>
                <div class="car-brand">Jeep - 2020</div>
                <div class="car-description">Rugged and adventurous for off-road experiences.</div>
            </div>

            <div class="car-card">
                <img src="images/car2.jpeg" alt="Nissan Patrol" />
                <div class="car-name">Nissan Patrol</div>
                <div class="car-brand">Nissan - 2023</div>
                <div class="car-description">Powerful full-size SUV designed for off-road dominance and luxury.</div>
            </div>

            <div class="car-card">
                <img src="images/car3.jpeg" alt="Honda Civic" />
                <div class="car-name">Honda Civic</div>
                <div class="car-brand">Honda - 2023</div>
                <div class="car-description">A sleek sedan that blends performance with comfort and fuel efficiency.</div>
            </div>

              <div class="car-card">
                <img src="images/swift.jpeg" alt="Suzuki Swift" />
                <div class="car-name">Suzuki Swift</div>
                <div class="car-brand">Suzuki - 2023</div>
                <div class="car-description">Popular small car known for efficiency and agility in urban driving.</div>
            </div>


            <div class="car-card">
                <img src="images/hatchback.jpeg" alt="Hatchback">
                <div class="car-name">Honda Fit</div>
                <div class="car-brand">Honda - 2021</div>
                <div class="car-description">Compact hatchback for quick and easy maneuvering.</div>
            </div>

            <div class="car-card">
                <img src="images/luxury.jpeg" alt="Luxury">
                <div class="car-name">Mercedes-Benz E-Class</div>
                <div class="car-brand">Mercedes - 2022</div>
                <div class="car-description">Luxury and elegance for professional and VIP needs.</div>
            </div>

            <div class="car-card">
                <img src="images/minivan.jpeg" alt="Minivan">
                <div class="car-name">Kia Carnival</div>
                <div class="car-brand">Kia - 2023</div>
                <div class="car-description">Spacious minivan for family and group travels.</div>
            </div>

            <div class="car-card">
                <img src="images/yaris.jpeg" alt="Toyota Yaris" />
                <div class="car-name">Toyota Yaris</div>
                <div class="car-brand">Toyota - 2021</div>
                <div class="car-description">Reliable subcompact ideal for city travel and easy parking.</div>
            </div>

            <div class="car-card">
                <img src="images/fiat500.jpeg" alt="Fiat 500" />
                <div class="car-name">Fiat 500</div>
                <div class="car-brand">Fiat - 2022</div>
                <div class="car-description">Charming small car perfect for stylish, efficient city driving.</div>
            </div>

            <div class="car-card">
                <img src="images/electric.jpeg" alt="Electric Car">
                <div class="car-name">Tesla Model 3</div>
                <div class="car-brand">Tesla - 2023</div>
                <div class="car-description">Eco-friendly electric car with smart features.</div>
            </div>

            <div class="car-card">
                <img src="images/pickup.jpeg" alt="Pickup">
                <div class="car-name">Ford Ranger</div>
                <div class="car-brand">Ford - 2022</div>
                <div class="car-description">Powerful pickup for both utility and comfort.</div>
            </div>

            <div class="car-card">
                <img src="images/coupe.jpeg" alt="Coupe">
                <div class="car-name">Audi TT</div>
                <div class="car-brand">Audi - 2021</div>
                <div class="car-description">Compact, sporty coupe for sleek city driving.</div>
            </div>
        </div>
    </div>
</asp:Content>
