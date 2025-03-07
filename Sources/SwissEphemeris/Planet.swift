import Foundation

/// Models the nine celestial objects usually considered to be planets in astrological systems.
/// The raw `Int32` values map to the IPL planetary bodies.
public enum Planet: Int32, CaseIterable, Codable, Hashable, CelestialBody { // Added `Codable` & `Hashable`
    case sun
    case moon
    case mercury
    case venus
    case mars
    case jupiter
    case saturn
    case uranus
    case neptune
    case pluto

    /// The IPL body number (Required by CelestialBody)
    public var ipl: Int32 { self.rawValue }

    /// The name property required by `CelestialBody`
    public var name: String { self.formatted }

    /// The symbol commonly associated with the planet.
    public var symbol: String {
        switch self {
        case .sun: return "☉"
        case .moon: return "☾"
        case .mercury: return "☿"
        case .venus: return "♀"
        case .mars: return "♂︎"
        case .jupiter: return "♃"
        case .saturn: return "♄"
        case .uranus: return "♅"
        case .neptune: return "♆"
        case .pluto: return "♇"
        }
    }

    /// The name of the planet formatted with the `symbol`.
    public var formatted: String {
        switch self {
        case .sun: return "☉ Sun"
        case .moon: return "☾ Moon"
        case .mercury: return "☿ Mercury"
        case .venus: return "♀ Venus"
        case .mars: return "♂️ Mars"
        case .jupiter: return "♃ Jupiter"
        case .saturn: return "♄ Saturn"
        case .uranus: return "♅ Uranus"
        case .neptune: return "♆ Neptune"
        case .pluto: return "♇ Pluto"
        }
    }
}
