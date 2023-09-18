# Comments

I have detailed the suggested refactoring in the [REFACTORING.md](./REFACTORING.pdf) document and the associated [Architecture diagram](./PokemonApp.pdf).

I have begin the suggested refactoring in this project by splitting it out in to Swift Packages, but the main app target will not currently compile until all this refactoring work is completed. I started the refactoring at the lower level with the intention of working my way 'up' the stack - so I haven't got as far as adding a view model to the view controllers, etc.

I have shown the suggested approach to testing within the PokemonService package - this uses a new API client protocol, and the tests for the Pokemon List query are provided. The same pattern would be applied to the tests for the Detail query. 

To address the bonus questions: if the view model adopted the `ObservableObject` protocol and used `@Published` properties, then this view model would work for SwiftUI view as well as UIKit ViewControllers

To enable using analytics libraries without touching the code, this could be achieved with method swizzling the UIViewController methods like `ViewDidAppear` to log analytics events - although widely used this kind of approach isn't really recommended. Personally I think it would be better to have another module for Analytics that abstracted out the implementation, allowing the library to be switched if required without rewriting the calls in the code. 


---
Original readme:
# Zapmap Lead iOS Developer Task

This is a planning/development task for a Lead iOS role at Zap-Map. 

We are using this task to see if you can design code in a way that is highly decoupled to allow future changes, as well as assessing your knowledge of writing automated tests.

If you have any questions, please email benrosen@zap-map.com.

## Background

A junior iOS developer wrote a Pokemon app according to the [requirements (described in a following section)](#the-pokemon-app-requirements).

Whilst the app is functional, it is not written in a way that is testable or flexible for future changes.

We would like to improve it so that:

* We can easily switch to use different 3rd party libraries
* We can easily add a database backup for the Pokemon data.
* The list and details code can exist in separate feature modules.
* We can easily change features and functionality with feature flags/entitlements.
* BONUS: We can easily switch from UIKit to SwiftUI with as little code change as possible.
* BONUS: We can easily add analytics and logging without modifying the classes that contain the logic.

## The task

1. Document how we can achieve the above mentioned improvements, making the codebase decoupled and flexible for future change. This can be a document in any format, we would expect to see architecture and class diagrams.
2. Demonstrate your automated testing skills by implementing some of your suggested changes whilst adding lots of tests. We recommend you choose an area harder to test so you can show off your testing skills.

Rules:

- Don't change any code in the ZoogleAnalytics package.
- Don't code any more functionality, we want the code to be ready for more features, but not for them to be added.
- Don't add any more third party libraries.

## The Pokemon App Requirements

I would like to be presented with a list of Pokemon names from the https://pokeapi.co/ API and be able to find out some details about them. The API does not require an API key.

**Note, please capitalise the `name` values in the JSON rather than fetching the localised version.**

### Pokemon list

On first opening the app I would like to see a list of Pokemon names.

These will come from the `https://pokeapi.co/api/v2/pokemon` endpoint.

Upon tapping on a Pokemon name I would like to be presented with the Pokemon's details. The Pokemon id selected must be logged in Zoogle Analytics.

The list should have infinite scrolling to go through all the Pokemon names.

### Pokemon details

The Pokemon details page will use the `https://pokeapi.co/api/v2/pokemon/{id}/` endpoint, e.g. https://pokeapi.co/api/v2/pokemon/1/.

This page should show the following details once loaded:
- The Pokemon's name
- A single image of the pokemon from the front (found under `sprites`)
- The Pokemon's "types" e.g. grass
- The Pokemon's weight in kg
- The Pokemon's height in cm

The page should also have some form of back button to go back to the Pokemon list.