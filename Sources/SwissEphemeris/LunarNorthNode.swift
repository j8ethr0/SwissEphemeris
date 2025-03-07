import Foundation

/// Models the lunar nodes.
/// The the raw `Int32` values map to the IPL bodies.
public enum LunarNorthNode: Int32, CaseIterable, Hashable, CelestialBody {
    case meanNode = 11
    case trueNode

    public var ipl: Int32 {
        rawValue
    }
    public var name: String { "Lunar North Node" }
}
