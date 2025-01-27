# Skyfora

Skyfora is a weather forecasting app that provides detailed and accurate weather information. It includes features like 5-day forecasts, offline caching, city search with autocomplete, and dynamic page backgrounds that adapt to the current weather conditions.

## Features
- **Current Weather**: View real-time weather data for your location.
- **5-Day Forecast**: Detailed forecasts for the next five days.
- **City Search**: Search for cities with autocomplete functionality.
- **Offline Mode**: Cached weather data is displayed when offline.

## Installation

To get started with Skyfora, follow these steps:

### Prerequisites
1. Ensure that you have Flutter installed. You can follow the [official Flutter installation guide](https://docs.flutter.dev/get-started/install).
2. Ensure you have the necessary Android/iOS setup for Flutter.

### Steps to Install

1. **Clone the Repository**
   ```bash
   git clone https://github.com/gracemakai/skyfora_weather
   cd skyfora
   ```

2. **Install Dependencies**
   Run the following command to install all required dependencies:
   ```bash
   flutter pub get
   ```

3. **Setup the Environment File**
    - Create a `.env` file in the root directory of the project.
    - Add the following variables to the `.env` file:
      ```env
      APIKEY=your_openweather_api_key
      BASEURL=https://api.openweathermap.org/data/2.5/
      ```
    - Replace `your_openweather_api_key` with your API key from [OpenWeather](https://openweathermap.org/).

4. **Run the Application**
    - Use the following command to run the app:
      ```bash
      flutter run
      ```

## Testing the Application

- **Debug Mode**: To run the app in debug mode, use:
  ```bash
  flutter run --debug
  ```

- **Release Mode**: To run the app in release mode, use:
  ```bash
  flutter run --release
  ```

## Contributions

Contributions are welcome! Feel free to submit a pull request or create an issue for feature requests or bug reports.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Enjoy using Skyfora!
