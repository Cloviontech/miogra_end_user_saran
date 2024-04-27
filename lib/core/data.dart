import "package:flutter/material.dart";

List<Map<String, String>> categories = [
  {
    "image": "assets/images/phone.jpeg",
    "name": "Mobiles",
  },
  {
    "image": "assets/images/groceries.jpeg",
    "name": "Groceries",
  },
  {
    "image": "assets/images/fashion.jpeg",
    "name": "Fashion",
  },
  {
    "image": "assets/images/furniture.jpeg",
    "name": "Furniture",
  },
  {
    "image": "assets/images/appliances.jpeg",
    "name": "Appliances",
  },
  {
    "image": "assets/images/auto.webp",
    "name": "Auto Accessories",
  },
  {
    "image": "assets/images/kitchen.jpeg",
    "name": "Kitchen",
  },
  {
    "image": "assets/images/electronics.jpeg",
    "name": "Electronics",
  },
  {
    "image": "assets/images/pet.jpeg",
    "name": "Pet Supplies",
  },
  {
    "image": "assets/images/toys.jpeg",
    "name": "Toys",
  },
  {
    "image": "assets/images/sports.jpeg",
    "name": "Sports & Fitness",
  },
  {
    "image": "assets/images/books.webp",
    "name": "Books",
  },
  {
    "image": "assets/images/personal.jpg",
    "name": "Personal Care",
  },
];

List<Map<String, String>> foodCategories = [
  {
    "image": "assets/images/Ellipse 1.png",
    "name": "Tiffen",
  },
  {
    "image": "assets/images/Ellipse_7.png",
    "name": "Meals",
  },
  {
    "image": "assets/images/Ellipse 2.png",
    "name": "briyani",
  },
  {
    "image": "assets/images/Ellipse 5.png",
    "name": "Chicken",
  },
  {
    "image": "assets/images/Ellipse 4.jpg",
    "name": "Beaf & Mutton",
  },
  {
    "image": "assets/images/Ellipse 6.png",
    "name": "burger_and_sandwich",
  },
  {
    "image": "assets/images/Ellipse 3.png",
    "name": "Pizza",
  },
  {
    "image": "assets/images/Ellipse 1 (1).png",
    "name": "Tea & Coffe",
  },
  // {
  //   "image":"assets/images/pet.jpeg",
  //   "name":"Pet Supplies",
  // },
  // {
  //   "image":"assets/images/toys.jpeg",
  //   "name":"Toys",
  // },
  // {
  //   "image":"assets/images/sports.jpeg",
  //   "name":"Sports & Fitness",
  // },
  // {
  //   "image":"assets/images/books.webp",
  //   "name":"Books",
  // },
  // {
  //   "image":"assets/images/personal.jpg",
  //   "name":"Personal Care",
  // },
];

List<Map<String, String>> freshCutCategories = [
  {
    "image": "assets/images/Ellipse 1 (2).png",
    "name": "Chicken",
  },
  {
    "image": "assets/images/Ellipse 7.png",
    "name": "Mutton",
  },
  {
    "image": "assets/images/Ellipse 2 (2).png",
    "name": "Seafoods",
  },
  {
    "image": "assets/images/Ellipse 5 (2).png",
    "name": "Beaf",
  },
  {
    "image": "assets/images/Ellipse 4.jpg",
    "name": "Dry Fish",
  },
  {
    "image": "assets/images/Ellipse 6 (2).png",
    "name": "Prawns",
  },
  {
    "image": "assets/images/Ellipse 3 (2).png",
    "name": "Pond Fishes",
  },
  {
    "image": "assets/images/Ellipse 1 (3).png",
    "name": "Eggs",
  },
  {
    "image": "assets/images/veg.jpg",
    "name": "Vegetables",
  },
  // {
  //   "image":"assets/images/toys.jpeg",
  //   "name":"Toys",
  // },
  // {
  //   "image":"assets/images/sports.jpeg",
  //   "name":"Sports & Fitness",
  // },
  // {
  //   "image":"assets/images/books.webp",
  //   "name":"Books",
  // },
  // {
  //   "image":"assets/images/personal.jpg",
  //   "name":"Personal Care",
  // },
];

List<Map<String, String>> jewelCategories = [
  {
    "image": "assets/images/earrings.jpg",
    "name": "Ear Rings",
  },
  {
    "image": "assets/images/rings.jpg",
    "name": "Rings",
  },
  {
    "image": "assets/images/Ellipse 11.png",
    "name": "Brazelets",
  },
  {
    "image": "assets/images/Ellipse 12.png",
    "name": "Chains",
  },
];


List<Map<String, String>> dailyMioCategories = [
  {
    "image": "assets/images/Ellipse 1 (5).png",
    "name": "grocery",
  },
  {
    "image": "assets/images/Ellipse 7 (1).png",
    "name": "Meat",
  },
  {
    "image": "assets/images/Ellipse 2 (1).png",
    "name": "Fish",
  },
  {
    "image": "assets/images/Ellipse 1 (3).png",
    "name": "Eggs",
  },
  {
    "image": "assets/images/Ellipse 4 (1).png",
    "name": "Fruits",
  },
  
  {
    "image": "assets/images/Ellipse 6 (1).png",
    "name": "Vegetables",
  },
  {
    "image": "assets/images/Ellipse 3 (1).png",
    "name": "Dairy",
  },
  
];

List<Map<String, String>> pharmCategories = [
  {
    "image": "assets/images/allo.jpg",
    "name": "Allopathy",
  },
  {
    "image": "assets/images/ayur.png",
    "name": "Ayurvedic",
  },
  {
    "image": "assets/images/Siddhachakra-Jain-Symbols.png",
    "name": "Sidda",
  },
  {
    "image": "assets/images/una.png",
    "name": "Unani",
  }
];

List<Map<String, dynamic>> todayDeals = [
  {
    "pid": "",
    "image": "assets/images/home-theater.jpeg",
    "name": "Home Theater",
    "oldPrice": 7000,
    "newPrice": 5000,
    "offer": 30,
    "color": const Color(0x6B870081)
  },
  {
    "pid": "",
    "image": "assets/images/tv.jpeg",
    "name": "Smart TV",
    "oldPrice": 7000,
    "newPrice": 5000,
    "offer": 30,
    "color": const Color(0x6B870081)
  },
  {
    "pid": "",
    "image": "assets/images/oven.jpeg",
    "name": "Migrowave Oven",
    "oldPrice": 7000,
    "newPrice": 5000,
    "offer": 30,
    "color": const Color(0x6B870081)
  },
  {
    "pid": "",
    "image": "assets/images/stove.webp",
    "name": "Induction Stove",
    "oldPrice": 7000,
    "newPrice": 5000,
    "offer": 30,
    "color": const Color(0x6B870081)
  },
];
List<Map<String, dynamic>> trendingProducts = [
  {
    "pid": "",
    "image": "assets/images/phone.jpeg",
    "name": "Samsung Galaxy F14 (6GB RAM)",
    "oldPrice": 18000,
    "newPrice": 15000,
  },
  {
    "pid": "",
    "image": "assets/images/phone.jpeg",
    "name": "Samsung Galaxy F14 (6GB RAM)",
    "oldPrice": 18000,
    "newPrice": 15000,
  },
  {
    "pid": "",
    "image": "assets/images/phone.jpeg",
    "name": "Samsung Galaxy F14 (6GB RAM)",
    "oldPrice": 18000,
    "newPrice": 15000,
  },
  {
    "pid": "",
    "image": "assets/images/phone.jpeg",
    "name": "Samsung Galaxy F14 (6GB RAM)",
    "oldPrice": 18000,
    "newPrice": 15000,
  },
];
List<Map<String, dynamic>> relatedToSearch = [
  {
    "pid": "",
    "image": "",
    "description": """""",
  },
  {
    "pid": "",
    "image": "",
    "description": """""",
  },
  {
    "pid": "",
    "image": "",
    "description": """""",
  },
  {
    "pid": "",
    "image": "",
    "description": """""",
  },
  {
    "pid": "",
    "image": "",
    "description": """""",
  },
  {
    "pid": "",
    "image": "",
    "description": """""",
  },
];
List<Map<String, dynamic>> restaurants = [
  {
    "image": "assets/images/appliances.jpeg",
    "name": "MK's Chikk Inn Restaurant",
    "location": "azhagiyamandapam",
    "from": 10,
    "to": 20,
    "ratings": 4.3,
  },
  {
    "image": "assets/images/appliances.jpeg",
    "name": "MK's Chikk Inn Restaurant",
    "location": "azhagiyamandapam",
    "from": 10,
    "to": 20,
    "ratings": 4.3,
  },
  {
    "image": "assets/images/appliances.jpeg",
    "name": "MK's Chikk Inn Restaurant",
    "location": "azhagiyamandapam",
    "from": 10,
    "to": 20,
    "ratings": 4.3,
  },
  {
    "image": "assets/images/appliances.jpeg",
    "name": "MK's Chikk Inn Restaurant",
    "location": "azhagiyamandapam",
    "from": 10,
    "to": 20,
    "ratings": 4.3,
  },
  {
    "image": "assets/images/appliances.jpeg",
    "name": "MK's Chikk Inn Restaurant",
    "location": "azhagiyamandapam",
    "from": 10,
    "to": 20,
    "ratings": 4.3,
  },
];
List<Map<String, dynamic>> freshCutTodayDeals = [
  {
    "image": "",
    "name": "",
    "quantity": "",
    "oldPrice": 0,
    "newPrice": 0,
  }
];

// Used Products
List<Map<String, String>> userProductsCategory = [
  {
    "image": "assets/images/phone.jpeg",
    "name": "Mobiles",
  },
  {
    "image": "assets/images/electronics.jpeg",
    "name": "Electronics & Appliances",
  },
  {
    "image": "assets/images/furniture.jpeg",
    "name": "Furnitures",
  },
  {
    "image": "assets/images/bike.webp",
    "name": "Bikes",
  },
  {
    "image": "assets/images/car.jpg",
    "name": "Cars",
  },
  {
    "image": "assets/images/home.jpg",
    "name": "Properties",
  },
];
List<Map<String, String>> usedProductsItems = [
  {
    "image": "assets/images/phone.jpeg",
    "name": "realme 11 Pro+ 5G (Oasis Green,12GB Ram, 256GB Storage)",
    "price": "5000",
    "contact": "9876543210",
    "location": "kanyakumari",
  },
  {
    "image": "assets/images/phone.jpeg",
    "name": "realme 11 Pro+ 5G (Oasis Green,12GB Ram, 256GB Storage)",
    "price": "5000",
    "contact": "9876543210",
    "location": "kanyakumari",
  },
  {
    "image": "assets/images/phone.jpeg",
    "name": "realme 11 Pro+ 5G (Oasis Green,12GB Ram, 256GB Storage)",
    "price": "5000",
    "contact": "9876543210",
    "location": "kanyakumari",
  },
  {
    "image": "assets/images/phone.jpeg",
    "name": "realme 11 Pro+ 5G (Oasis Green,12GB Ram, 256GB Storage)",
    "price": "5000",
    "contact": "9876543210",
    "location": "kanyakumari",
  },
  {
    "image": "assets/images/phone.jpeg",
    "name": "realme 11 Pro+ 5G (Oasis Green,12GB Ram, 256GB Storage)",
    "price": "5000",
    "contact": "9876543210",
    "location": "kanyakumari",
  },
];
