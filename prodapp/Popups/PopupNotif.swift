//
//  PopupNotif.swift
//  Invert
//
//  Created by Dhruva Ramachandran on 6/3/24.
//

import Foundation
import MijickPopupView
import SwiftUI

struct PopupNotif: TopPopup {
    @State var closeButtonAppeared: Bool = false
    func configurePopup(popup: TopPopupConfig) -> TopPopupConfig {
        popup
            .cornerRadius(0)
            .backgroundColour(Color.onBackgroundPrimary)
    }
    func createContent() -> some View {
        HStack(spacing: 0){
            createTitle()
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 24)
    }
}
private extension PopupNotif {
    func createTitle() -> some View {
        Text("Task Saved!")
            .font(Font.nexaHeavy(20))
            .foregroundStyle(.white)
            .multilineTextAlignment(.leading)
    }
    
}
