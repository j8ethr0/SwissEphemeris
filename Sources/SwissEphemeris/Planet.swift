import Foundation
import CSwissEphemeris // ✅ Ensure the correct import

public enum Planet: Int32, CaseIterable, Codable, Hashable, CelestialBody {
    case sun = 0, moon, mercury, venus, mars, jupiter, saturn, uranus, neptune, pluto, northNode, southNode

    public var ipl: Int32 { // ✅ Required by `CelestialBody`
        switch self {
        case .sun: return SE_SUN
        case .moon: return SE_MOON
        case .mercury: return SE_MERCURY
        case .venus: return SE_VENUS
        case .mars: return SE_MARS
        case .jupiter: return SE_JUPITER
        case .saturn: return SE_SATURN
        case .uranus: return SE_URANUS
        case .neptune: return SE_NEPTUNE
        case .pluto: return SE_PLUTO
        case .northNode: return SE_TRUE_NODE
        case .southNode: return -SE_TRUE_NODE
        }
    }

    public var name: String { // ✅ Required by `CelestialBody`
        switch self {
        case .sun: return "Sun"
        case .moon: return "Moon"
        case .mercury: return "Mercury"
        case .venus: return "Venus"
        case .mars: return "Mars"
        case .jupiter: return "Jupiter"
        case .saturn: return "Saturn"
        case .uranus: return "Uranus"
        case .neptune: return "Neptune"
        case .pluto: return "Pluto"
        case .northNode: return "North Node"
        case .southNode: return "South Node"
        }
    }
}
