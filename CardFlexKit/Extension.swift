//
//  Extension.swift
//  CardFlexKit
//
//  Created by jaydip jadav on 02/01/25.
//

import SwiftUI
extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self.frame(maxWidth: .infinity, alignment: alignment)
    }
}

//MARK: DummyData
extension String {
    func dummyData(_ character: Character, count: Int, showDigit: Bool = false) -> String {
        var temString = self.replacingOccurrences(of: String(character), with: "")
        let remaining = min(max(count - temString.count , 0), count)
        if remaining > 0 {
            temString.append(String(repeating: String(character), count: remaining))
        }
        return temString.formatterCardNumber()
    }
    //MARK: Number Validation
    func formatterCardNumber() -> String {
        var formatter = ""
        for (index, charter) in self.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatter.append(" ")
            }
            formatter.append(charter)
        }
        return formatter
    }
}
