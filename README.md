# Weather App


## Getting Started :rocket:

**Weather App** is a hybrid application (Android and iOS) that allows users to look up the weather for any location. The project is hosted on GitHub at [https://github.com/jisjoe/weather-app](https://github.com/jisjoe/weather-app).

### Features

The application is capable of:
- Searching for a location with 'autocomplete' and displaying the weather forecast for that location, humidity, visibility, pressure and wind of current weather, also an upcoming weather forecast including time, humidity, min and max temperature. This also persists the search history.
- Toggling between the metric and imperial systems when displaying units in the settings.
- Refreshing the weather for the selected location on "pull to refresh".
- Network handling with offline persistence of last searched location.


### Preparations

Given the 2-hour time constraint, I aimed to ensure the project is neat, robust, and of high code quality. Here are the preparations I made:

1. **Project Planning**
    - Outlined the features, implementation steps, and commit milestones.

2. **Data Persistence**
    - Decided to use ISAR for offline search data persistence, ensuring efficient local storage and retrieval.

3. **Environment Configuration**
    - Prepared multiple flavors (Dev, Stg, Prod) for both Android and iOS.
    - Implemented routing using go_router to leverage Navigator 2.0 for efficient navigation.

4. **Weather API**
    - Tested the APIs from the OpenWeatherMap API to understand the response structure and identify the required data.
    - Created Dart models using json_serializable for rapid code generation and efficient data handling.

5. **Geocoding API**
    - Tested the geocoding API from OpenWeatherMap API to implement the autocomplete feature.
    - Analyzed the JSON data and prepared corresponding Dart models using json_serializable to expedite the development process.

### Technical Features and Implementation

- The project uses the OpenWeatherMap API to pull weather data.
- The code is organized with a clear, consistent architecture of BLoC following SOLID principles.
- The application uses BloC for state management, ensuring the code is scalable and maintainable.
- The app runs smoothly on both iOS and Android platforms.
- The application has unit and widget tests ensuring more than 70% coverage.


### Future Enhancements

- Improve coverage - even though there are unit, widget tests, there is a coverage on 72% only, which can be enhanced to 90% plus
- Add a CI/CD pipeline set up using GitHub Actions for deploying Android/iOS production-level applications.
- Write integration tests for ETE testing.
- Add observability tools like Sentry or Firebase Crashlytics.
- Add analytics tools like Segment or other to improve user experience and enhance error resolution.

### How to run the project

- Clone the project using ``` git clone https://github.com/jisjoe/weather-app```
- Set the Flavor in the Run configuration to either `dev`, `stg`, or `prod`.
- Set the Environment:
    - Download the `.env` file attached in the email.
    - Place the `.env` file inside the project folder.
- Install dependencies and build the project: ```
  $ flutter pub get
  $ dart run build_runner build --delete-conflicting-outputs  ```
- Run the code after selecting the appropriate Android emulator or iOS simulator.

### How to run tests

- Inside the project terminal ``` $ flutter test --coverage```
- To view coverage using lcov, ```$ brew install lcov
  genhtml -o coverage coverage/lcov.info```

## The Code Structure and elements :abcd:
The application is capable of running in Android and iOS devices and built using Flutter. The code uses BLoC as the state management tool.
The following packages are used in the development:
* envied: ^0.5.4+1
* collection: ^1.18.0
* json_annotation: ^4.9.0
* equatable: ^2.0.5
* bloc: ^8.1.4
* isar: ^3.1.0+1
* isar_flutter_libs: ^3.1.0+1
* bloc_concurrency: ^0.2.5
* http: ^1.2.1
* drop_down_search_field: ^1.0.4
* intl: ^0.19.0
* lottie: ^3.1.2
* go_router: ^14.1.4
* flutter_bloc: ^8.1.5
* connectivity_plus: ^6.0.3
* path_provider: ^2.1.3

# Also the dev dependencies:

* flutter_lints: ^2.0.0
* envied_generator: ^0.5.4+1
* build_runner: ^2.4.11
* json_serializable: ^6.8.0
* isar_generator: ^3.1.0+1
* mocktail: ^1.0.3
* bloc_test: ^9.1.7