import Foundation
import CSwissEphemeris

/// Calculates the time a celestial body rises or sets.
public struct RiseTime<T: CelestialBody> {
    /// The date of the rise:
    public let date: Date //NO OPTIONAL
    /// The pointer for the longitude, latitude and altitude.
    let geoPos = UnsafeMutablePointer<Double>.allocate(capacity: 3)
    /// The pointer for the time.
    let time = UnsafeMutablePointer<Double>.allocate(capacity: 1)

    /// Creates a RisingTime
    /// - Parameters:
    ///    - date: The date to set for the rise.
    ///    - body: The celestial body that is rising.
    ///    - longitude: The longitude of the location.
    ///    - latitude: The latitude of the location.
    ///    - altitude: The height above sea level. The default value is zero.
    ///    - atmosphericPressure: The level of atmospheric pressure. The default value is zero.
    ///    - atmosphericTemperature: The atmospheric temperature. The default value is zero.
    ///    - isRise: Determines if  the time is set to sunrise, or sunset.
    public init(date: Date,
                body: T,
                longitude: Double,
                latitude: Double,
                altitude: Double = .zero,
                atmosphericPressure: Double = .zero,
                atmosphericTemperature: Double = .zero,
                isRise: Bool) {
        defer {
            geoPos.deallocate()
            time.deallocate()
        }
        geoPos[0] = longitude
        geoPos[1] = latitude
        geoPos[2] = altitude

        let flags = isRise == true ? 1 : 0

        swe_rise_trans(date.julianDate(),
                       body.ipl, // Use body.ipl directly
                       nil,
                       SEFLG_SWIEPH,
                       Int32(flags),
                       geoPos,
                       atmosphericPressure,
                       atmosphericTemperature,
                       time,
                       nil)
        self.date = Date(julianDay: time[0]) //NO OPTIONAL
    }
}
