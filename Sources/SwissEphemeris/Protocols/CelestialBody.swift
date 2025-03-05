import Foundation

/// Models a planet, moon, astroid, star or celestial body both real or imaginary.
public protocol CelestialBody: CaseIterable, Codable { //MAKE PROPERTIES PUBLIC
    /// The IPL body number.
     var ipl: Int32 { get }
    var name: String { get }
}
