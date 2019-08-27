# Movies NLU

Movies NLU is an iOS app that uses Natural Language Understanding to analyze the overall emotion and the targeted emotion of movie reviews. It uses The Movie DB API to get the reviews and the IBM Watson to analyze them.

## Getting Started

To run the app on XCode, you'll have to have the keys for both APIs (The Movie DB and IBM Watson).

### The Movie DB

1. Go to [The Movie DB](https://www.themoviedb.org/) website and sign up for a free account.
2. Once you are logged in, click your Profile Icon in the top right corner and then select Settings.
3. On the left side menu click API and then click Create in the middle of your screen.
4. After filling out the form, you will be given a TMDB API Key.

### IBM Watson

1. Go to the [IBM Cloud](https://cloud.ibm.com) website and sign up for an account.
2. Once you are logged in, go to your [resource list](https://cloud.ibm.com/resources)
3. Look for Natural Language Understanding and click on it
4. Fill out the information and click on create
5. Once you're on the service panel, click on Show Credentials to see your API Key.

## Running the app

After getting the keys, you'll need to put them on the project so you're app will be able to use the APIs. To do so, create a new Swift file on the *Model* folder and name it *Constants.swift*.
Open the file you've created and write the following:

```swift
// Constants.swift

let TheMovieDBApiKey = "YOUR API KEY FOR THE MOVIDE DB"
let NLUApiKey = "YOUR API KEY FOR IBM WATSON"

```

After doing that, you'll be able to run the project normally.

## Usage

To analyze the reviews of a movie you call the function


```swift
NLUFacade.shared.analyze(movieNamed: "NAME OF THE MOVIE")
```


