//
//  InfoPopup.swift
//  Invert
//
//  Created by Dhruva Ramachandran on 6/9/24.
//

import Foundation
import MijickPopupView
import SwiftUI

struct InfoPopup: CentrePopup {
    func configurePopup(popup: CentrePopupConfig) -> CentrePopupConfig {
        popup.horizontalPadding(28)
            .backgroundColour(Color.onBackgroundPrimary)
            .tapOutsideToDismiss(true)
    }
    func createContent() -> some View {
            VStack(spacing: 20){
                createTitle()
                VStack(spacing: 25){
                    HStack{
                        createTaskDesc()
                        Spacer().frame(width: 10)
                        createTimerDesc()
                    }
                    Spacer().frame(height: 15)
                    HStack{
                        Image("CreateJob")
                            .resizable()
                            .frame(width: 120, height: (120/9)*16)
                            .cornerRadius(10)
                        Spacer().frame(width: 15)
                        Image("TimerView")
                            .resizable()
                            .frame(width: 120, height: (120/9)*16)
                            .cornerRadius(10)
                    }
                }
                createDismiss()
            }
            .padding(.bottom, 20)
            .padding(.top, 20)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
}

extension InfoPopup {
    func createTitle() -> some View {
        Text("Here's how to use Invert")
            .font(Font.nexaHeavy(30))
            .foregroundStyle(.white)
    }
    func createTaskDesc() -> some View {
        VStack{
            Text("- Start by creating your tasks")
            Text("- Invert can suggest a work to break split for you, or you can edit those times")
        }
        .font(Font.satoshiMedium(10))
        .foregroundStyle(.white)
        .multilineTextAlignment(.leading)
    }
    func createTimerDesc() -> some View {
        VStack{
            Text("- Once you press the start button, the 'ding' noise will signal the beginning of the timer when you place the phone face down.")
            Text("- If the phone is picked up, another ding plays, and the timer pauses. You must place the phone back down to resume.")
            Text("- Once your time is up, breaktime begins, signaled by another tone.")
        }
        .font(Font.satoshiMedium(10))
        .foregroundStyle(.white)
        .multilineTextAlignment(.leading)
    }
    func createDismiss() -> some View {
        Button{
            dismiss()
        } label: {
            Text("Got it")
                .font(Font.satoshiMedium(25))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.onBackgroundSecondary)
                .cornerRadius(9)
                .padding(.top, 12)
                //.padding(.bottom, 15)
                .padding(.horizontal, 24)
        }
    }
}
