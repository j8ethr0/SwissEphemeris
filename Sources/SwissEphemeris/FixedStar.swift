import Foundation

/// Models a fixed star.
public struct FixedStar: Codable {

    /// The fixed star name.
    public let rawValue: String

    /// Creates a `FixedStar`
    /// - Parameter star: The star.
    public init(_ star: String) {
        rawValue = star
    }
}

// MARK: - Equatable Conformance

extension FixedStar: Equatable {
    public static func == (lhs: FixedStar, rhs: FixedStar) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}

//MARK: Celestial body

extension FixedStar: CelestialBody {
    public var ipl: Int32 {
        0 //fixed stars do not have ipl
    }

    public var name: String {
        rawValue
    }
    
    public static var allCases: [FixedStar] { //add all cases for consistency, no stars for now.
        []
    }
}
