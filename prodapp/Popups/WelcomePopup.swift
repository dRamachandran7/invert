//
//  WelcomePopup.swift
//  Invert
//
//  Created by Dhruva Ramachandran on 6/9/24.
//

import Foundation
import SwiftUI
import MijickPopupView

struct WelcomePopup: CentrePopup {
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup.horizontalPadding(28)
            .backgroundColour(Color.onBackgroundPrimary)
    }
    func createContent() -> some View {
        VStack{
            Spacer().frame(height: 15)
            createTitle()
            Spacer().frame(height: 15)
            createButton()
            Spacer().frame(height: 15)
        }
       
    }
}
extension WelcomePopup{ 
    func createTitle() -> some View {
        Text("Welcome to Invert!")
            .font(Font.nexaHeavy(30))
            .foregroundStyle(.white)
    }
    func createButton() -> some View {
        Button{
            dismiss()
        } label: {
            Text("Get Started")
                .font(Font.satoshiMedium(25))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.onBackgroundSecondary)
                .cornerRadius(9)
                .padding(.top, 12)
                .padding(.bottom, 15)
                .padding(.horizontal, 24)
        }
    }
}
