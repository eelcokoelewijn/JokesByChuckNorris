import NetworkKit
import Foundation

// https://api.icndb.com/jokes/random

let waitSignal = DispatchSemaphore(value: 0)

let icndbService = MixInICNDBService()
icndbService.getRandomJoke { joke in
    print("\(joke)\n")
}

icndbService.getRandomJoke(substituteFirstname: "Henk", substituteLastname: "Spenk") {
    print("\($0)\n")
}

icndbService.getJokeCategories { c in
    c.forEach {
        print("\($0)\n")
    }
}

icndbService.getRandom(numberOfJokes: 3) { jokes in
    defer {
        waitSignal.signal()
    }
    jokes.forEach { joke in
        print("\(joke)\n")
    }
}

let waitTimeout = waitSignal.wait(timeout: DispatchTime.distantFuture)

