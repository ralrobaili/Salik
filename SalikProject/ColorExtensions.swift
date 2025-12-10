import SwiftUI

extension Color {

    init(hex: String) {
        let hexString = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&int)
        let r, g, b, a: UInt64
        switch hexString.count {
        case 3:
            (r, g, b, a) = (((int >> 8) & 0xF) * 17,
                            ((int >> 4) & 0xF) * 17,
                            (int & 0xF) * 17,
                            255)
        case 6:
            (r, g, b, a) = ((int >> 16) & 0xFF,
                            (int >> 8) & 0xFF,
                            int & 0xFF,
                            255)
        case 8:
            (a, r, g, b) = ((int >> 24) & 0xFF,
                            (int >> 16) & 0xFF,
                            (int >> 8) & 0xFF,
                            int & 0xFF)
        default:
            (r, g, b, a) = (0, 0, 0, 255)
        }

        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }


    static let tabGreenDark = Color(hex: "#4B9960")

    static let tabGreenLight = Color(hex: "#E2F1E7")

    static let tabGreenSelected = Color(hex: "#4B9960")

    static let tabGray = Color(hex: "#9E9E9E")
}
