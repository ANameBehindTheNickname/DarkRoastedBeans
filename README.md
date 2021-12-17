# DarkRoastedBeans <img src="https://img.shields.io/badge/iOS-13.0+-00ADD8?logo=apple"/>

# 🤔 Business logic
At the core of the application lies the `DrinkService` protocol that has only one function – `getDrinkMenu`.
The idea to program against this interface gives more flexibility and maintainability to the Client.
Now you can use anybody who implements this protocol without knowing its concrete type.
Meaning you can easily extend the app by adding cache, some other drink brewing service, etc. 

For now only `DarkRoastedBeansRemoteService` implements `DrinkService`.

All of those classes are bundled in the DrinkService macOS framework, so you can develop and test it super fast (because you don't need to launch the simulator every time).
But how can it run on iOS and use in my app then? Choose DrinkService target, go to <ins>Build Setting</ins> and observe *iOS macOS* under <ins>Supported Platforms</ins>. By default, only macOS is there, so I had to extend it manually.
DrinkService is a Static Library, meaning you don't have to embed it in your application.

Let's move on. How do we get drinks after calling `getDrinkMenu`? `DrinkServiceDelegate` got us covered with its method<br> `didReceive(_ drinkMenu: DrinkMenu)`.
I could have used a simple closure and didn't bother creating a delegate, passing it as a property... This way `getDrinkMenu` signature could've become something like this<br> `func getDrinkMenu(completion: @escaping (DrinkMenu) -> ())`.
But I avoided this design on purpose. Closure forces a client of the method to handle the results, but if you have a separate Delegate you can separate the command from the result. So you can have one part of the code calling `getDrinkMenu`, but you have somebody else as a delegate. This way, you have a more object-oriented design.

# 🌈 Brewing Flow
`DrinkBrewingFlow` is a separate object that handles navigation. This way, a ViewController is decoupled from creating other controllers and pushing them onto the navigation stack. This design lets us change the brewing flow easily. Want to present Extras before Sizes? Just create a new flow with the changed steps, and a ViewController remains intact.
It opens the possibility to experiment with the order + A/B testing.

# 🖼 UI
The main and only (except some helper controllers) player is `ItemListVC`. Drink, size, and extra are basically just items and can be presented in a generic way.
How does `ItemListVC` plays out with `DrinkBrewingFlow`. It has a set of closures `onViewDidLoad, onDidSelectRow, onDidDeselectRow` that are assigned during the flow creation and triggered with according events.
If there are no Extras, this step is skipped, and the User proceeds to the Overview screen.

# 🎭 Animations
There are custom animations of presenting and hiding Extra options.
Brew button on the Overview screen also has a custom animation.

# 🖇 App composition
Neither the DrinkService module nor the UI module doesn't depend on each other. They are connected with `BrewingMachineAdapter`, which takes the `DrinkService` instance via initializer, and conforms to `BrewingMachine` (the interface that UI uses to talk to the outside world). It also conforms to `DrinkServiceDelegate` and notifies UI via `delegate: BrewingMachineDelegate` property.
All of the classes instantiated and composed inside the Composition Root.

# 🦾 Refactoring
There is [feature/refactoring](https://github.com/ANameBehindTheNickname/DarkRoastedBeans/tree/feature/refactoring) branch.
It has a much cleaner UI design (I compose views instead of having constraints logic), although not finished. I use iOS14 APIs `UIContentView` and `UIContentConfiguration`.
It was fun to refactor (I certainly liked how my code UI improved), but due to the lack of time and first acquaintance with those APIs, I decided to roll back and finish what I started.

# 🎢 Git workflow
In this project I used GitFlow.

# 🎉 Thank you
I hope you'll like what you'll see in my project. Have a good day!
