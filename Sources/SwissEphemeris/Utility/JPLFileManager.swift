import Foundation
import CSwissEphemeris

/// The file manager for the JPL data files.
public class JPLFileManager {
    private static let fileManager = FileManager.default
    private static let jplDataPath = "JPL"

    private static var jplPath: String {
        Bundle.main.resourceURL?.appendingPathComponent("JPL", isDirectory: true).path ?? ""  // Use bundle resources
    }

    /// Sets the path to the JPL data file
    public static func setEphemerisPath(path: String = jplPath) {
        set_ephe_path_(path)
    }
}
