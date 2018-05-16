import Foundation

public enum ColorEncodingStrategy {
    case rgb
    case hexadecimal(hash: Bool)
}

extension CodingUserInfoKey {
    public static let colorEncodingStrategy =
        CodingUserInfoKey(rawValue: "colorEncodingStrategy")!
}
