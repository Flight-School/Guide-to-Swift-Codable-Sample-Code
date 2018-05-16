/// The Recording Industry Association of America (RIAA) parental advisory
/// for the content.
/// For more information,
/// see  http://itunes.apple.com/WebObjects/MZStore.woa/wa/parentalAdvisory
public enum Explicitness: String, Decodable {
    /// Explicit lyrics, possibly explicit album cover
    case explicit
    
    /// Cleaned version with explicit lyrics "bleeped out"
    case clean
    
    /// No explicit lyrics
    case notExplicit
}
