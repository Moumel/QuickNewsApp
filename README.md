# Quick News App

## 📰 Flutter News Feed App
A modern, responsive, and feature-rich news application built with Flutter, integrating with NewsAPI to deliver up-to-date headlines across various categories.

## ✨ Features
📰 Category Tabs: Browse news effortlessly across predefined categories:

Technology

Business

Sports

Health

🌙 Theme Switching: Seamlessly toggle between Dark Mode and Light Mode for a personalized viewing experience.

🔍 Search Functionality: Powerful, debounced search bar to find articles by keywords across all available sources.

🚀 Splash Screen: A custom splash screen providing a polished first impression and loading app resources.

📡 API Integration: Real-time data fetching using the NewsAPI.

🔒 Secure Key Management: Utilizes a .env file to securely manage API keys, keeping credentials out of the codebase.

🏗️ State Management: Uses Provider for efficient and simple state management across the application.

✨ Clean UI/UX: Features smooth transitions and adaptive layouts for a great experience on both mobile and tablet devices.

![Image Alt](https://github.com/Moumel/QuickNewsApp/blob/515d87435065e7726aabfdee4427ac6606f28607/news_app_images/Picsart_25-10-15_23-30-09-642.jpg)

## ⚙️ Setup and Installation
Follow these steps to get your local copy up and running.

Prerequisites
1. Flutter SDK: Make sure you have the latest stable version of Flutter installed.

Dart SDK: Included with Flutter.

2. Install Dependencies
Fetch all the required packages:

flutter pub get

3. API Key Configuration
This project requires a NewsAPI key to fetch data.

Sign up for a free key at NewsAPI.

Create a file named .env in the root directory of your project (same level as pubspec.yaml).

Add your API key to the .env file in the following format:

NEWS_API_KEY=YOUR_SECRET_NEWSAPI_KEY_HERE

4. Run the Application
Execute the following command in your terminal:

flutter run

The app should now build and run on your connected device or simulator.

## 🛠️ Built With
Flutter - UI Toolkit

Provider - State Management

Dio - HTTP Client for API calls

flutter_dotenv - For managing environment variables (.env)
