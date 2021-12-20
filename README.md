# gm_weather_app

Dear team,

It is a pleasure to present you this little project. I kept the UI/UX as lean as possible so that is easy to showcase the functionalities.

Main points and considerations:

- MVVM design/architecture pattern
- API requests has been implemented as requested and showcases London’s weather
- 5 day forecast component is dynamic and the UI can handle more than 5 days since it is scrollable on horizontal axis and could automatically fetch data from the API
- Pull to refresh gesture implemented instead of button to keep the UX follow common mobile pattern
- implemented data persistence. In case of missing internet connection the app will handle the saving of the data.
- Native web view has been implemented for iOS. Android version provides InAppWebView plugin based on native view
- Back button and navigation pattern added to the webview for the user to go back and forth in the product

