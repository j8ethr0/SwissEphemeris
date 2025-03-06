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
}
