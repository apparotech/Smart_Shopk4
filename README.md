
An Instagram-like social media application built using **Flutter**, **Firebase**, and modern UI practices. This project replicates core functionalities of Instagram including posting, liking, following, push notifications, user authentication, and more.

## 🛠 Tech Stack

- 🔧 **Flutter** (Dart)
- ☁️ **Firebase Auth** – User Sign in / Sign up
- 🔥 **Cloud Firestore** – Real-time Database
- 📦 **Firebase Storage** – Store user images
- 💬 **Provider** – State Management
- 🔔 **Firebase Cloud Messaging (FCM)** – Push Notifications
- 📱 Android & iOS support

---

## ✨ Features

| 🔹 Feature                        | ✅ Available |
|----------------------------------|--------------|
| User Authentication (SignUp/SignIn) | ✔️ |
| Upload Post (Image + Caption)      | ✔️ |
| Like & Comment on Posts            | ✔️ |
| Follow / Unfollow Users            | ✔️ |
| Real-time Feed                     | ✔️ |
| Edit Profile & Update Image        | ✔️ |
| Stories Feature (like Instagram)   | ✔️ (if added) |
| Search Other Users                 | ✔️ |
| Push Notifications (New Posts, Follows, Likes) | ✔️ |
| Save/Bookmark Posts                | 🚧 (Coming Soon) |

---

## 📸 Screenshots

| Login Page | Register Page | Profile Page |
|------------|---------------|--------------|
| ![Login](https://github.com/user-attachments/assets/8230ba04-cdfa-4532-8208-838bb0eab503) | ![Register](https://github.com/user-attachments/assets/7a8cd7a3-63fd-4d5a-acdf-f303b9cca057) | ![Profile](https://github.com/user-attachments/assets/6261aa76-70d9-4fdd-b600-1562b8571a89) |


| Feed Page | Other Profile Page | List Posts Page |
|-----------|--------------------|-----------------|
| ![Feed](https://github.com/user-attachments/assets/f7c95ca8-a1de-4e69-ac1b-03ac3506a591) | ![Other Profile](https://github.com/user-attachments/assets/5374a914-6ca8-4b89-a2c1-c81bc6ef2794) | ![List Posts](https://github.com/user-attachments/assets/96fc1baf-e362-4867-be24-74a6dc6907d5) |


| ChatList Page | Chat Page | Search Page |
|---------------|-----------|--------------|
| ![ChatList](https://github.com/user-attachments/assets/0d3d8c68-bb17-496c-9c4c-65df825e7ccc) | ![Chat](https://github.com/user-attachments/assets/cd630c6e-b33f-4db6-b173-e248f2f4ad15) | ![Search](https://github.com/user-attachments/assets/946c16d7-0d94-4f06-999d-c01ced08c2ff) |


| Comment Page | Story Page | Edit Profile Page |
|--------------|------------|-------------------|
| ![Comment](https://github.com/user-attachments/assets/df3db87b-9b02-49bf-94bc-50532af84e0e) | ![Story](https://github.com/user-attachments/assets/b198bf47-96f9-49e5-89c5-567836c50325) | ![EditProfile](https://github.com/user-attachments/assets/6531f495-0b57-4701-bd7e-aa33a595ef43) |



---

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name

2. Install dependencies
flutter pub get

3. Setup Firebase

Go to Firebase Console

Create a new project

Add Android and iOS apps

Download the google-services.json and GoogleService-Info.plist files

Place them in:

android/app/ for Android

ios/Runner/ for iOS

Enable the following in Firebase:

Authentication → Email/Password

Cloud Firestore

Firebase Storage

Firebase Cloud Messaging (FCM) → For Push Notifications

For push notifications:

Add Firebase Cloud Messaging to your app

Configure notification permissions in AndroidManifest.xml and Info.plist

Handle messages using firebase_messaging package

4. Run the app
flutter run


📁 Flutter Project Structure

lib/
├── Model/                    # Data models (user, post, etc.)
├── Pages/                   # All UI Screens and their related logic
│   ├── Add_Product/         # Product addition screen
│   ├── Bottom_Navigation_Bar/ # Bottom navigation bar components
│   ├── Chat_Page/           # Chat UI and logic
│   ├── CommentPage/         # Comments and interactions
│   ├── Components/          # Reusable widgets and UI components
│   ├── const/               # Constants like colors, text styles
│   ├── EditProfile/         # Edit profile screen
│   ├── feeds/               # News feed or post feed page
│   ├── Follow/              # Follow/follower logic
│   ├── HelperFunction/      # Helper methods used across the app
│   ├── Home_Page/           # Main home screen
│   ├── InboxList/           # Inbox or chat list screen
│   ├── Login_Page/          # Login UI
│   ├── mainScreen/          # Main screen managing navigation
│   ├── Notification_Page/   # Notification screen
│   ├── OtherUserProfilePage/ # Other users' profile page
│   ├── Parterns/            # Likely a typo of "Patterns" or related UI logic
│   ├── posts/               # Post-related logic and UI
│   ├── Profile_Page/        # User's profile page
│   ├── SearchScreen/        # Search functionality
│   ├── Settings/            # App settings
│   ├── SignIn_Page/         # Sign-in screen
│   ├── SignUp_page/         # Sign-up screen
│   ├── StoryPage/           # Story display like Instagram/Facebook
├── services/                # Backend services like Firebase, APIs
├── utils/                   # Utility functions
├── view_model/              # State management (e.g., Provider, BLoC)
├── firebase_options.dart    # Firebase auto-generated config
└── main.dart                # App entry point

🙌 Contribution
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

📬 Contact
Created by Raj Kumar Mahto

📧 Email: 7061rajaryan@gmail.com

💼 LinkedIn: Raj Aryan [https://www.linkedin.com/in/raj-aryan-313368256/]

💻 GitHub: 

