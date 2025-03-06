import Foundation

/// Models a planets request for batch requests.
public struct PlanetsRequest: BatchRequest {
    public typealias Body = Planet

    public let body: Planet

    /// Creates an instance of `PlanetsRequest`.
    /// - Parameter body: The `Planet`.
    public init(body: Planet) {
        self.body = body
    }

    public func fetch(start: Date, end: Date, interval: TimeInterval) async -> [Coordinate<Planet>] { // Added 'public'
        let startJd = start.julianDate()
        let endJd = end.julianDate()
        let intervalJd = interval / (24 * 60 * 60) // Convert seconds to Julian Day fraction

        return await withTaskGroup(of: Coordinate<Planet>?.self, returning: [Coordinate<Planet>].self) { group in
            var results: [Coordinate<Planet>] = []

            // Capture 'body' and 'intervalJd' directly, NOT self
            let localBody = self.body

            for julianDay in stride(from: startJd, through: endJd, by: intervalJd) { //removed strideable
                group.addTask {
                    let date = Date(julianDay: julianDay) //removed strideable, uses extension
                    // Use localBody here
                    return try? Coordinate(body: localBody, date: date)
                }
            }

            for await result in group {
                if let result = result {
                    results.append(result)
                }
            }
            return results
        }
    }
}
