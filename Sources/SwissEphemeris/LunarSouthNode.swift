import Foundation
import CSwissEphemeris

/// Maps the Moon's south node to the zodiacs.
public enum LunarSouthNode: Int32, CaseIterable, Hashable, CelestialBody { //MAKE ENUM
    case meanNode = 10
    case trueNode

     public var ipl: Int32 { rawValue + 1 } //KEEP

    public var name: String { "Lunar South Node" } //ADD

    public init(nodeCoordinate: Coordinate<LunarNorthNode>) { //KEEP FOR REFERENCE
        let val = nodeCoordinate.longitude + 180
        if val >= 360 {
            self = .trueNode // Dummy values
        } else {
            self = .meanNode// Dummy values
        }
    }
}
