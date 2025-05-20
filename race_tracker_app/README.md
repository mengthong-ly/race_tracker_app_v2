# Race Tracker App

This project is a Dart application designed to track participants in a race. It allows for the management of participant data and the export of this data in CSV format.

## Project Structure

```
race_tracker_app
├── lib
│   ├── main.dart          # Entry point of the application
│   ├── model
│   │   ├── participant.dart # Defines the Participant class
│   │   └── csv
│   │       └── csv_exporter.dart # Implements CSV export functionality
├── pubspec.yaml           # Project configuration and dependencies
└── README.md              # Documentation for the project
```

## Setup Instructions

1. Ensure you have Dart installed on your machine.
2. Clone the repository:
   ```
   git clone <repository-url>
   ```
3. Navigate to the project directory:
   ```
   cd race_tracker_app
   ```
4. Install dependencies:
   ```
   dart pub get
   ```

## Usage

To run the application, use the following command:
```
dart run lib/main.dart
```

## Features

- Manage participant data including name, age, and race time.
- Export participant data to CSV format for easy sharing and analysis.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bug fixes.