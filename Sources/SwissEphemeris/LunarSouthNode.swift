import Foundation
import CSwissEphemeris

/// Maps the Moon's south node to the zodiacs.
public enum LunarSouthNode: Int32, CaseIterable, Hashable, CelestialBody { //MAKE ENUM
    case meanNode = 10
    case trueNode

    public init(nodeCoordinate: Coordinate) { //KEEP FOR REFERENCE
        let val = nodeCoordinate.longitude + 180
        if val >= 360 {
            self = .trueNode // Dummy values
        } else {
            self = .meanNode// Dummy values
        }
    }

    public var ipl: Int32 { //CELESTIAL BODY
        rawValue + 1
    }
     public var name: String { "Lunar South Node" } //ADD NAME
}
