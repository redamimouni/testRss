# testRss

This an iOS technical test for RATP Smart System. [Test App Toilets.pdf](https://github.com/redamimouni/testRss/files/9182021/Test.App.Toilets.pdf)


# Architecture

The architecture choosen is clean archi (View -> Presenter -> Domain -> Data), known to be a good archi to slice layers, so we can cover with unit test every layer. Also its a good slicing so each layer can have its responsability.

Coordinator pattern has been added to have a better navigation through the app, maybe its a little bit over kill for a technical test but can be a good choice for a scaling app.

> Improvement:
> Adding a network class that can handle all the http requests, this way the repository will not have the responsability to do the network task and can also switch with a storage service if we want to handle off line.
> A dependancy injection library can be useful, like Swinject to create containers for every flow.

# UI

The application UI is done with code, we can do it with storyboards, but I prefer code, due to difficulties managing conflicts when working as a team.

> Improvement:

>- I would handle error cases, by generating message for each domain and network error also by adding empty state view with an asset
>- Add a loader indicator that shows loading status
>- Improve the experience for table view filter by showing a drawer with 3 different options.

# Data

The data is fetch with URLSession, I don't think its necessary to use a library such as Alamofire for a small GET call.

An extension func of URLSession has been created to use cache in case the user is offline.

DTOs has been generated with https://app.quicktype.io/

# Tests

I tried to cover the code with some unit tests, we can use a mock library to avoid wirting mocks manually (e.g: SwiftyMocky).

The repository has not been tested, the proposition above 👆 can make it easier.

We can also add other kind of tests, like snapshot tests or ui tests.
