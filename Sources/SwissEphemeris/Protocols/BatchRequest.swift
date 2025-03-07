import Foundation

/// Interface for making batch requests to the ephemeris.
public protocol BatchRequest {
    associatedtype Body: CelestialBody & Hashable
    /// The request for the body.
    var body: Body { get }
    /// Fetches the ephemeris data.
    /// - Parameters:
    ///   - start: The start of the date range.
    ///   - end: The end of the data range.
    ///   - interval: The interval between each data point.
    func fetch(start: Date, end: Date, interval: TimeInterval) async -> [Coordinate<Body>]
}

public extension BatchRequest {
    func fetch(start: Date, end: Date, interval: TimeInterval) async -> [Coordinate<Body>] {
        let startJd = start.julianDate()
        let endJd = end.julianDate()
        let intervalJd = interval / (24 * 60 * 60) // Convert seconds to Julian Day fraction

        return await withTaskGroup(of: Coordinate<Body>?.self, returning: [Coordinate<Body>].self) { group in
            var results: [Coordinate<Body>] = []
            for julianDay in stride(from: startJd, through: endJd, by: intervalJd) { //removed strideable
                group.addTask {
                    let date = Date(julianDay: julianDay) //Uses date extension
                    return Coordinate(body: self.body, date: date) //remove try
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
