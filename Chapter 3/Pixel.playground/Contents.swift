import Foundation

let encoder = JSONEncoder()
encoder.userInfo[.colorEncodingStrategy] = ColorEncodingStrategy.hexadecimal(hash: true)

let cyan = Pixel(red: 0, green: 255, blue: 255)
let magenta = Pixel(red: 255, green: 0, blue: 255)
let yellow = Pixel(red: 255, green: 255, blue: 0)
let black = Pixel(red: 0, green: 0, blue: 0)

let json = try! encoder.encode([cyan, magenta, yellow, black])
let string = String(data: json, encoding: .utf8)!

print(string)
