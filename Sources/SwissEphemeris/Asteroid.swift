import Foundation

/// Defines asteroids that can be calculated.
/// The the raw `Int32` values map to the IPL bodies.
public enum Asteroid: Int32, CaseIterable {
    case ceres = 1
    case pallas
    case juno
    case vesta
    case chiron = 15
    case pholus
    case nessus
    case asbolus
    case chariklo
    case hylonome
    case pelion
    case okyrhoe
    case ixion = 24
    case rhadamanthus
    case varuna
    case quaoar
    case orcus
    case sedna
    case eris
    case haumea
    case makemake
}

// MARK: - CelestialBody Conformance
extension Asteroid: CelestialBody {
    public var ipl: Int32 { rawValue }
    public var name: String { String(describing: self) } //ADD NAME
}
