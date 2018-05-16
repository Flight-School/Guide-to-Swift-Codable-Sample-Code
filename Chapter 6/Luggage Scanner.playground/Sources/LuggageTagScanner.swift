import Foundation
import CoreData
import CoreImage
import UIKit

public class LuggageTagScanner {
    private lazy var detector: CIDetector? = {
        let context = CIContext()
        let options = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: context, options: options)
        return detector
    }()
    
    public required init() {}
    
    public enum Point {
        case origin, destination
    }
    
    public func scan(image uiImage: UIImage, at point: Point, in context: NSManagedObjectContext) throws {
        guard
            let ciImage = CIImage(image: uiImage),
            let features = detector?.features(in: ciImage),
            let qrCode = features.first as? CIQRCodeFeature,
            let data = qrCode.messageString?.data(using: .utf8) else {
                return
        }
        
        let decoder = JSONDecoder()
        decoder.userInfo[.context] = context
    
        let luggage = try decoder.decode(Luggage.self, from: data)

        switch point {
        case .origin:
            luggage.departedAt = NSDate()
        case .destination:
            luggage.arrivedAt = NSDate()
        }
    }
}
