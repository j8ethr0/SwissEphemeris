import Foundation
import CSwissEphemeris // Import the C library

/// The file manager for the JPL data files.
public class JPLFileManager {
    private static let fileManager = FileManager.default
    private static let jplDataPath = "JPL"

    private static var jplPath: String { // Make this a computed property
        Bundle.main.resourceURL?.appendingPathComponent(jplDataPath, isDirectory: true).path ?? ""
    }

    /// Sets the path to the JPL data file
    public static func setEphemerisPath(path: String = jplPath) { // Use the computed property
        set_ephe_path_(path) // Correct C function call
    }
}
