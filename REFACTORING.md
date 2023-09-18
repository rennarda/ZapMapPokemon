# Pokemon App Refactoring

### Architecture
The app should be refactored to use an MVVM architecture. 
The ViewControllers (List and Detail) should use a ViewModel type for data access and for all business logic.
The service and networking layer should be separated out into their own modules. 
At all levels the interfaces should be defined with Swift Protocols, allowing for mocking of dependencies during tests, and the modules should provide concrete implementations of these protocols. 

[Architecture diagram](./PokemonApp.pdf)

### Modules
The app should be broken down into the following modules (Swift Packages). 
#### PokemonTypes
This contains the core types used by the application, such as the `PokemonItem` and `PokemonDetail`
#### PokemonFeatures
This manages application feature flags. Its dependencies are the `Network` library for requesting feature flag settings from the feature flag service, or possibly a third party feature flag service such as Firebase.
#### PokemonPersistence
This module manages saving downloaded data to a persistent store. The exact store used is an implementation detail of this module, although this could be CoreData, cached JSON files,  or a third party framework such as Realm. It is dependent on the `PokemonTypes` library.  The  protocol for this module would save and return `PokemonItem`and `PokemonDetail`and internally maintain a relationship between these. 
#### PokemonServices
This module provides a protocol to obtain an array of `PokemonItem` and `PokemonDetail` for an item, from a remote service. It is dependent on the `PokemonTypes` and `Network`modules. 
#### Network
This module should implement a generic RESTful interface over HTTP, accepting `Codable` types as arguments. It should be highly reusable, and as such has no dependencies on other application modules. 
#### PokemonList
This contains the `ListViewController` and the `ListViewModel`. It has a dependency on the `PokemonTypes`, `Persistence` , `Configuration`and `PokemonService` modules. 
The `ListViewController` displays the fetched `PokemonItem`s in a UITableView by implementing the `UITableViewDelegate` and `UITableViewDatasource` protocols. Data to populate the cells is supplied by the view model. 
The `ListViewModelProtocol` provides methods to refresh the data from the remote service, and supply the view controller with data at specific index paths. The implementation  of this should call the `PokemonService` type to fetch new data, and persist this using the `PersistentStoreManager`. The data returned from the store should be the source of truth for the data source methods. Optionally this type should be a class that inherits from `ObservableObject` and use `@Published`properties (or just decorated with the `@Observable` macro in iOS17) to act as a `@StateObject` for a SwiftUI. 
An alternate SwiftUI view would be a `List` that used the view model as a `@StateObject` property (or just `@State` in iOS17). 
#### PokemonDetail 
This contains the view controller and view model for the Pokemon detail view. It follows the same pattern as detailed in the `PokemonList` view, with the same dependencies

### Other points
A Coordinator component could also be introduced to manage navigation, although for such a simple app at this stage this level of abstraction is probably not necessary. 

Refactor to use structured concurrency (async/await) instead of callback blocks. Async/Await is back deployed to iOS13 has a much more readable syntax that is easier to understand and reason about.

Other modules that could be introduced would be a configuration module to manage global settings like switching environments (eg. test and production), a theme module for globally defining colours and fonts used in the app, and a localisation module to contain strings and other localisable resources. 