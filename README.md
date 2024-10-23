# Recipes README

## Steps to Run the App

To run Recipes on your local machine:

	1.	Clone the Repository:

git clone https://github.com/coreybb/recipes.git

	2.	Open the Project in Xcode:
	•	Double-click on the Recipes.xcodeproj file to open the project in Xcode.

	3.	Open the Xcode Project:
	•	Open Recipes.xcodeproj in Xcode.
 
	4.	Build and Run the App:
	•	Select a simulator or a physical device.
	•	Press Cmd+R or click the Run button to build and run the app.

## Focus Areas

#### Architecture and Clean Code Practices

I prioritized implementing a clean and maintainable architecture using principles of Clean Architecture and MVVM (Model-View-ViewModel). The goal was to ensure that the codebase is scalable and easy to understand.

	•	Separation of Concerns: Divided the app into distinct layers, each responsible for a specific part of the functionality (e.g., data layer, domain layer, presentation layer).
	•	Protocols and Dependency Injection: Used protocols to define interfaces and injected dependencies to make the code more testable and flexible.
	•	Async/Await and Combine: Leveraged Swift’s async/await for asynchronous operations and Combine for reactive programming, making the code more concise and modern.

#### Error Handling and User Experience

	•	Robust Error Handling: Implemented comprehensive error handling throughout the app, ensuring that errors are caught and handled gracefully.
	•	User Feedback: Added user-friendly error messages and alerts to inform users of issues.

#### Testing

	•	Unit Testing: Wrote unit tests for key components, including repositories, use cases, and view models.
	•	Mocking and Dependency Injection: Created mock services and repositories to isolate units of code during testing, increasing test reliability.

#### Caching and Performance

	•	Disk and Memory Caching: Implemented a DiskImageCache and DefaultImageLocalRepository to cache images locally, reducing network usage.
  • Presentation leverages lazy loading, prefetching and dynamic cancellation of loading for performance.
	•	SHA256 Hashing: Used SHA256 hashing for file names in the disk cache to avoid conflicts and manage file storage efficiently.

## Time Spent

I spent approximately 5 hours working on this project. 

## Trade-offs and Decisions

	•	Complexity vs. Deadlines: Chose to focus on a clean architecture even though it required more initial setup time.
	•	Third-Party Libraries: The app uses no external dependencies, opting to implement certain functionalities manually (e.g., image caching, networking).
	•	Concurrency Model: Adopted async/await over older concurrency models for cleaner asynchronous code, even though it limits compatibility to iOS 15 and above.
  •	The app does not use logging.

## Weakest Part of the Project

The weakest part of the project is the UI/UX design, could be more polished and visually appealing. I focused more on the app’s architecture and performance rather than the design aspects.

## External Code and Dependencies

	•	Combine: Used for reactive programming and handling asynchronous data streams.
	•	CommonCrypto: Utilized for SHA256 hashing in image caching.
	•	UIKit: Employed for building the user interface.

No external libraries or frameworks were used beyond the standard iOS SDK and system-provided libraries.

## Additional Information

	•	Unit Tests: Focused on testing critical components and used mocking to isolate units of code.
	•	Actors and Concurrency: Employed Swift’s actor model to manage state in a thread-safe manner, especially in the local storage and networking layers.

## Constraints and Considerations

	•	iOS Version Compatibility: The use of async/await and actors requires iOS 15 or later.
	•	Networking: Assumed that the API endpoints are reliable and did not implement retry logic or exponential backoff strategies.
	•	Localization: The app currently supports only English, and localization was not implemented.

Thank you for taking the time to review this project.
