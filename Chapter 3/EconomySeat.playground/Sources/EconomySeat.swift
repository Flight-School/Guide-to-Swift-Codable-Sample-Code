public class EconomySeat: Decodable {
    public var number: Int
    public var letter: String
    
    public init(number: Int, letter: String) {
        self.number = number
        self.letter = letter
    }
}
