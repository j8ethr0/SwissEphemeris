import Foundation

/// Models the lunar nodes.
/// The the raw `Int32` values map to the IPL bodies.
public enum LunarNorthNode: Int32, CaseIterable, Hashable { //ADD CASEITERABLE AND HASHABLE
    case meanNode = 10
    case trueNode
}

// MARK: - CelestialBody Conformance

extension LunarNorthNode: CelestialBody {
    public var ipl: Int32 {
        rawValue
    }
}
