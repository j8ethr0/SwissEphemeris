import Foundation
import CSwissEphemeris


/// Models a `CelestialBody` point in the sky.
public struct Coordinate: ZodiacMappable {

    /// The type of `CelestialBody`.
    public let body: any CelestialBody //REMOVE GENERICS
    /// The date of the the coordinate.
    public let date: Date
    /// The coordinate's longitude.
    public let longitude: Double
    /// The coordinate's latitude.
    public let latitude: Double
    /// The distance in AU.
    public let distance: Double
    /// The speed in longitude (deg/day).
    public let speedLongitude: Double
    /// The speed in latitude (deg/day).
    public let speedLatitude: Double
    /// The speed in distance (AU/day).
    public let speedDistance: Double
    /// The pointer that holds all values.
    private var pointer = UnsafeMutablePointer<Double>.allocate(capacity: 6)
    /// The pointer for the fixed star name.
    private var charPointer = UnsafeMutablePointer<CChar>.allocate(capacity: 1)

    // MARK: - ZodiacMappable Properties

    public let tropical: ZodiacCoordinate
    public let sidereal: ZodiacCoordinate

    // MARK: - Initializers

    /// Creates a `Coordinate`.
    /// - Parameters:
    ///   - body: The `CelestialBody` for the placement.
    ///   - date: The date for the location of the coordinate.
    public init(body: any CelestialBody, date: Date) { //REMOVED GENERICS
        defer {
            pointer.deinitialize(count: 6)
            pointer.deallocate()
            if let star = body as? FixedStar {
                charPointer.deinitialize(count: star.rawValue.count)
                charPointer.deallocate()
            }
        }
        self.body = body
        self.date = date

        switch body {
        case let planet as Planet:
            pointer.initialize(repeating: 0, count: 6)
            swe_calc_ut(date.julianDate(), planet.ipl, SEFLG_SPEED, pointer, nil)
        case let node as LunarNorthNode:
            pointer.initialize(repeating: 0, count: 6)
            swe_calc_ut(date.julianDate(), node.ipl, SEFLG_SPEED, pointer, nil)
        case let node as LunarSouthNode:
            pointer.initialize(repeating: 0, count: 6)
            swe_calc_ut(date.julianDate(), node.ipl, SEFLG_SPEED, pointer, nil)
        case let star as FixedStar:
            charPointer.initialize(from: star.rawValue, count: star.rawValue.count)
            charPointer = strdup(star.rawValue)
            swe_fixstar2(charPointer, date.julianDate(), SEFLG_SPEED, pointer, nil)
        default:
            break
        }

        longitude = pointer[0]
        latitude = pointer[1]
        distance = pointer[2]
        speedLongitude = pointer[3]
        speedLatitude = pointer[4]
        speedDistance = pointer[5]
        tropical = ZodiacCoordinate(value: longitude)
        sidereal = ZodiacCoordinate(value: longitude, offset: Ayanamsha()(for: date))
    }
}

// MARK: - Codable Conformance

extension Coordinate: Codable {

    public enum CodingKeys: CodingKey {
        case body
        case date
        case longitude
        case latitude
        case distance
        case speedLongitude
        case speedLatitude
        case speedDistance
        case tropicalCoordinate
        case siderealCoordinate
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        date = try container.decode(Date.self, forKey: .date)
        longitude = try container.decode(Double.self, forKey: .longitude)
        latitude = try container.decode(Double.self, forKey: .latitude)
        distance = try container.decode(Double.self, forKey: .distance)
        speedLongitude = try container.decode(Double.self, forKey: .speedLongitude)
        speedLatitude = try container.decode(Double.self, forKey: .speedLatitude)
        speedDistance = try container.decode(Double.self, forKey: .speedDistance)
        tropical = try container.decode(ZodiacCoordinate.self, forKey: .tropicalCoordinate)
        sidereal = try container.decode(ZodiacCoordinate.self, forKey: .siderealCoordinate)

        //This is a workaround for the type erasure
        let bodyInt = try container.decode(Int32.self, forKey: .body)
        if let planet = Planet(rawValue: bodyInt) {
            body = planet
        } else if let node = LunarNorthNode(rawValue: bodyInt){
            body = node
        } else {
            body =  try container.decode(FixedStar.self, forKey: .body) //decode as best you can
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(body.ipl, forKey: .body)
        try container.encode(date, forKey: .date)
        try container.encode(longitude, forKey: .longitude)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(distance, forKey: .distance)
        try container.encode(speedLongitude, forKey: .speedLongitude)
        try container.encode(speedLatitude, forKey: .speedLatitude)
        try container.encode(speedDistance, forKey: .speedDistance)
        try container.encode(tropical, forKey: .tropicalCoordinate)
        try container.encode(sidereal, forKey: .siderealCoordinate)
    }
}
