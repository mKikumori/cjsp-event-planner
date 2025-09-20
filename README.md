# CJSP event_planner App

A app for members of the CJSP Choiur group to register for events, give details about their individual performance, request for help from staff or other students, and for admins to organize and schedule the event.

# Architecture

This project follows the MVVM (Model-View-ViewModel) architectural pattern to ensure a clean separation of concerns, maintainability, and scalability.

### MVVM Breakdown:

1. **Model**: This layer is responsible for the data and business logic of the application. It interacts with external resources, such as APIs or databases, to retrieve or manipulate data.
    - Located in: `lib/models/` and `lib/services/`
    - **Example**: `user.dart`, `application.dart`, `auth_service.dart`, `application_service.dart`

2. **View**: The **View** layer represents the UI and displays the data that is passed from the **ViewModel**. It is mostly passive and doesn't handle business logic.
    - Located in: `lib/views/`
    - **Example**: `sign_up.dart`, `home.dart`, `applications_list.dart`

3. **ViewModel**: The **ViewModel** is responsible for managing the application's state, handling business logic, and preparing data for the **View** to display. It communicates with the **Model** layer to fetch and process data.
    - Located in: `lib/view_models/`
    - **Example**: `auth_view_model.dart`, `application_view_model.dart`


### Folder Structure

```plaintext
lib/
├── main.dart              # Entry point of the app
├── config/                # Configuration files
│   └── app_config.dart    # App-wide configuration (theme, routes, etc.)
├── models/                # Data models (e.g., for user, application)
│   └── user.dart          # User model
│   └── application.dart  # Application model
├── services/              # API services and data logic
│   └── auth_service.dart  # Authentication logic (sign in, sign up, MFA)
│   └── application_service.dart  # CRUD operations for applications
├── view_models/           # ViewModel layer (State management)
│   └── auth_view_model.dart  # Handles business logic for auth pages
│   └── application_view_model.dart  # Handles business logic for application pages
├── views/                 # View layer (UI components/pages)
│   ├── launch/            # Launch related views
│   │   ├── start.dart     # Start page
│   ├── auth/              # Authentication-related views
│   │   ├── sign_up.dart  # Sign up page
│   │   ├── sign_in.dart  # Sign in page
│   │   └── mfa.dart      # MFA page
│   ├── home/             # Home-related views
│   │   └── home.dart     # Home page
│   ├── applications/     # Application-related views
│   │   ├── applications_list.dart  # Applications list view
│   │   ├── application_read.dart   # Application read view
│   │   ├── application_edit.dart   # Application edit view
│   │   └── application_create.dart # Application create view
├── widgets/               # Reusable UI components
    ├── custom_button.dart # Reusable button widget
    ├── custom_text_field.dart # Reusable text field widget
    └── loading_indicator.dart  # Loading spinner widget
