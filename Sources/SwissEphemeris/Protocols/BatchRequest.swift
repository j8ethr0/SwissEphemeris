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
