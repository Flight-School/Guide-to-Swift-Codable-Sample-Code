public class PremiumEconomySeat: EconomySeat {
    public var mealPreference: String?

    private enum CodingKeys: String, CodingKey {
        case mealPreference
    }
    
    public init(number: Int, letter: String, mealPreference: String?) {
        super.init(number: number, letter: letter)
        self.mealPreference = mealPreference
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealPreference =
            try container.decodeIfPresent(String.self, forKey: .mealPreference)
        try super.init(from: decoder)
    }
}
