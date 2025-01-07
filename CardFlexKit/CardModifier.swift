//
//  CardFlexModifier.swift
//  CardFlexKit
//
//  Created by jaydip jadav on 03/01/25.
//

import SwiftUI
//MARK: Button Modifier
struct CardFlexButtonstyle: ViewModifier {
    var tin: Color
    var backgorund: Color = .clear
    var isValid: Bool = false
    func body(content: Content) -> some View {
        content
            .foregroundColor(tin)
            .padding()
            .background(backgorund.gradient)
            .clipShape(Capsule())
            .opacity(!isValid ? 1 : 0.5)
            .disabled(isValid)
            
    }
}

//MARK: TextField Modifier
struct CardFlexTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                Color.white
                    .shadow(.drop(color: Color.black.opacity(0.08), radius: 20, x: 3, y: 3))
                    .shadow(.drop(color: Color.black.opacity(0.06), radius: 20, x: -3, y: -3)),in: RoundedRectangle(cornerRadius: 8))
    }
}
