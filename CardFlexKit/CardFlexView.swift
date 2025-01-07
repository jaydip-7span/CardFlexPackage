//
//  CardFlexView.swift
//  CardFlexKit
//
//  Created by jaydip jadav on 03/01/25.
//

import SwiftUI


public struct Card {
    public var name: String = ""
    public var number: String = ""
    public var year: String = ""
    public var month: String = ""
    public var cvv: String = ""
    var rawCardNumber: String {
        number.replacingOccurrences(of: " ", with: "")
    }
    public init(number: String = "", name: String = "", year: String = "", month: String = "", cvv: String = "") {
        self.number = number
        self.name = name
        self.year = year
        self.month = month
        self.cvv = cvv
    }
    
    
}


public enum ActiveField {
   case number
   case name
   case month
   case year
   case cvv
}

public enum CardVariant {
//   case master
//   case visa
//   case american
   case cardinfo(name: String, cardIcon: String, color: Color)
   
   var desription: String {
       switch self {
//       case .master:
//           return "Mastercard"
//       case .visa:
//           return "Visa"
//       case .american:
//           return "American Express"
       case .cardinfo(let name, _, _):
           return name
       }
   }
   var cardicon: String {
       switch self {
//       case .master:
//           return "master"
//       case .visa:
//           return "visa"
//       case .american:
//           return "american"
       case .cardinfo( _,let cardicon, _):
           return cardicon
       }
   }
   var color: Color {
       switch self {
//       case .master:
//           return .mint.opacity(0.7)
//       case .visa:
//           return .brown.opacity(0.5)
//       case .american:
//           return .blue.opacity(0.4)
       case .cardinfo( _, _, let color):
           return color
       }
   }
}


public struct CardFlexAnimationView: View {
    //MARK: Dynamic Property
    @Binding public var card: Card
    @State public var cardVariant: CardVariant
    
    //MARK: Private Property
    @FocusState private var activeField: ActiveField?
    @State private var animateField: ActiveField?
   
   
    //MARK: Button Action
   public var onAction:()->()

    public init(card: Binding<Card>, cardVariant: CardVariant, onAction: @escaping () ->()) {
        self._card = card
        self._cardVariant = State(initialValue: cardVariant)
        self.onAction = onAction
    }
   public var body: some View {
        VStack(spacing: 40) {
            Spacer().frame(height: 0)
            
            //MARK: CardDetails and Animation
            ZStack {
                cardDetails()
                    .rotation3DEffect(.degrees(activeField != .cvv ? 0 : -90), axis: (x: 1, y: 0, z: 0))
                    .scaleEffect(x: activeField != .cvv ? 1 : 0.5)
                    .animation(activeField != .cvv ? .linear.delay(0.35) : .linear, value: activeField)
                
                cardBackSide()
                    .rotation3DEffect(.degrees(activeField != .cvv ? 90 : 0.0), axis: (x: 1, y: 0, z: 0))
                    .scaleEffect(x: activeField == .cvv ? 1 : 0.5)
                    .animation(activeField == .cvv ? .linear.delay(0.35) : .linear, value: activeField)
                   
            }
            
            
            //MARK: Card textfield
           // if isTextFieldShow {
                VStack(spacing: 20) {
                    // Card Number TextField
                    CardFlexTextField(hit: "Card Number", titale: "Card Number", value: $card.number) {
//                        if let number = Int(card.number) {
//                            switch number {
//                            case 3:
//                                cardVariant = .american
//                            case 2,5:
//                                cardVariant = .master
//                            case 4:
//                                cardVariant = .visa
//                            default:
//                                break
//                            }
//                        }
                        card.number = String(card.rawCardNumber.formatterCardNumber().prefix(19))
                        if card.number.count == 19 {
                            activeField = .name
                        }
                    }
                    .focused($activeField, equals: .number)
                    
                    // Card Holder Name TextField
                    CardFlexTextField(hit: "Card Holder Name", titale: "Customer Name", value: $card
                        .name, keyboardType: .alphabet) {
                            card.name = card.name
                        }
                        .focused($activeField, equals: .name)
                    HStack(spacing: 8) {
                        // Card Month TextField
                        CardFlexTextField(hit: "Month", titale: "MM", value: $card
                            .month) {
                                if let number = Int(card.month), number > 1 {
                                    card.month = (number > 12 ? "12" : number < 10 ? "0\(number)" : card.month)
                                    card.month = String(card.month.prefix(2))
                                        activeField = .year
                                }else {
                                    card.month = String(card.month.prefix(2))
                                    if card.month.count == 2 {
                                        activeField = .year
                                    }
                                }
                            }
                            .focused($activeField, equals: .month)
                        
                        // Card Year TextField
                        CardFlexTextField(hit: "Year", titale: "YY", value: $card
                            .year) {
                                card.year = String(card.year.prefix(2))
                                if card.year.count == 2 {
                                    activeField = .cvv
                                }
                            }
                            .focused($activeField, equals: .year)
                        
                        // Card CVV TextField
                        CardFlexTextField(hit: "CVV", titale: "CVV", isSecure: true, value: $card
                            .cvv) {
                                card.cvv = String(card.cvv.prefix(3))
                                if card.cvv.count == 3 {
                                    UIApplication.shared.endEditing()
                                }
                            }
                            .focused($activeField, equals: .cvv)
                            
                    }
                }
                
                // Button Action
                Button {
                    onAction()
                } label: {
                    Text("Save Card Details")
                }
                .modifier(CardFlexButtonstyle(tin: Color.black, backgorund: cardVariant.color, isValid: (card.number.isEmpty || card.name.isEmpty || card.month.isEmpty || card.year.isEmpty || card.cvv.isEmpty)))
                Spacer()

            //}
            
        }
    }
    
    //MARK: Frount Card Details View
    @ViewBuilder
    func cardDetails() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cardVariant.desription.uppercased())
                    .bold()
                Spacer()
                Image(cardVariant.cardicon)
                    .resizable()
                    .frame(width: 80,height: 60)
            }
                Spacer()
            HStack(spacing: 20) {
                Image("chip",bundle: Bundle(identifier: "jaydip-jadav.CardFlexKit"))
                    .resizable()
                    .frame(width: 50, height: 40)
                Text(String(card.rawCardNumber.dummyData("*", count: 16, showDigit: true).prefix(19)))
                    .font(.title2)
            }
           
    
            Spacer()
            HStack {
                    Text(card.name)
                        .lineLimit(1)
                        .monospaced()
                Spacer()
                
                VStack {
                    Text("EXPIRES")
                       // .bold()
                    HStack(spacing: 5) {
                        Text(card.month.isEmpty ? "MM" : card.month.prefix(2))
                        Text("/")
                        Text(card.year.isEmpty ? "YY" : card.year.prefix(2))
                    }
                }
            }
        }
        .padding()
        .frame(height: 200)
        .monospaced()
        .contentTransition(.numericText())
        .background(cardVariant.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    //MARK: Backend Card Details View
    @ViewBuilder
    func cardBackSide() -> some View {
        VStack {
            Rectangle()
                .fill(Color.black)
                .padding(.horizontal, -16)
                .frame(height: 50)
            
            Text("CVV").padding([.top,.trailing], 20).hSpacing(.trailing)
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .padding(.horizontal)
                .frame(height: 40)
                .overlay(alignment: .trailing) {
                    Text(card.cvv.dummyData("*", count: 3).prefix(3)).padding(.trailing, 24)
                }
        }
        .padding()
        .frame(height: 200)
        .monospaced()
        .contentTransition(.numericText())
        .background(cardVariant.color.gradient)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}


extension UIApplication {
    func endEditing() {
        if let windowScene = connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.endEditing(true)
        }
    }
}
