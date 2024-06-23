//
//  CenterNoDataAlert.swift
//  Invert
//
//  Created by Dhruva Ramachandran on 6/2/24.
//

import Foundation
import MijickPopupView
import SwiftUI

struct CenterNoDataAlert: CentrePopup {
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup.horizontalPadding(28)
            .backgroundColour(Color.onBackgroundPrimary)
    }
    func createContent() -> some View {
        VStack(spacing: 0) {
            createTitle()
            Spacer().frame(height: 35)
            createDesc()
            Spacer().frame(height: 15)
            Button{
                dismiss()
            } label: {
                Text("Dismiss")
                    .font(Font.satoshiMedium(18))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(Color.onBackgroundSecondary)
                    .cornerRadius(8)
            }
        }
        .padding(.top, 12)
        .padding(.bottom, 24)
        .padding(.horizontal, 24)
    }
}

private extension CenterNoDataAlert {
    func createTitle() -> some View {
        Text("Add some info?")
            .font(Font.nexaHeavy(25))
    }
    func createDesc() -> some View {
        Text("Some info is missing. Fill it out to save this task.")
            .font(Font.satoshiMedium(20))
    }
}
