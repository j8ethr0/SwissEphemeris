import Foundation

/// Models a planet, moon, astroid, star or celestial body both real or imaginary.
public protocol CelestialBody: CaseIterable, Codable {
    /// The IPL body number.
     var ipl: Int32 { get } //MAKE PUBLIC
    var name: String { get } //MAKE PUBLIC
}
