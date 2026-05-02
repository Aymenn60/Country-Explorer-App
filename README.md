# 🌍 Country Explorer App

## 👤 Student Information

* Name: Aymen Mohammed
* Student ID: ATE/6588/15

---

## 🎯 Track Chosen

Mobile Application Development (Flutter)

---

## 📱 App Description

Country Explorer is a Flutter-based mobile application that allows users to explore information about countries around the world.

The app fetches real-time data from a public API and displays:

* Country name and flag
* Region and capital city
* Population
* Area size
* Languages spoken
* Currencies used
* Time zones

Users can:

* View a list of countries
* Search for specific countries
* Tap a country to see detailed information

---

## ⚙️ How to Run the App Locally

### 1. Prerequisites

Make sure you have:

* Flutter SDK installed
* Android Studio or VS Code
* An Android device or emulator

---

### 2. Clone the Repository

git clone https://github.com/Aymenn60/country-explorer.git
cd country-explorer

---

### 3. Install Dependencies

flutter pub get

---

### 4. Run the App

flutter run

---

### ⚠️ If you get Gradle errors

Run:

flutter clean
flutter pub get

---

### 🌐 .env File (if applicable)

This project does not require a `.env` file since it uses a public API.

---

## 🔗 API Endpoints Used

The app uses the REST Countries API (v3.1):

* Get all countries:

https://restcountries.com/v3.1/all

* Get country by code:

https://restcountries.com/v3.1/alpha/{code}

---

## ⚠️ Known Limitations / Bugs

* Some countries may have missing data (depending on API response)
* Internet connection is required (no offline mode yet)
* Error handling is basic (retry button included)
* UI can be improved for responsiveness on all screen sizes
* No caching (data reloads every time)

---

## 🚀 Future Improvements

* Add offline caching
* Improve UI/UX design
* Add region-based filtering
* Add favorites feature
* Implement dark mode
* Optimize performance

---

## 🛠 Technologies Used

* Flutter (Dart)
* REST API (HTTP requests)
* Material UI Components

---

## 📌 Notes

This project was built as part of a mobile development assignment and demonstrates:

* API integration
* State management using FutureBuilder
* Error handling and retry mechanism
* Clean UI design

---