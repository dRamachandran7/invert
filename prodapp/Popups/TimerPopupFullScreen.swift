//
//  TimerPopupFullScreen.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 4/1/24.
//

import Foundation
import MijickPopupView
import SwiftUI

struct TimerPopupFullScreen: BottomPopup {
    @Binding var job: Job
    @Binding var jobs: [Job]
    func configurePopup(popup: BottomPopupConfig) -> BottomPopupConfig {
        popup
            .contentFillsEntireScreen(true)
            .dragGestureEnabled(false)
            .backgroundColour(Color.onBackgroundPrimary)
    }
    func createContent() -> some View {
        VStack(spacing: 0) {
            Button{
                dismiss()
            } label: {
                Text("Dismiss")
                    .mask(Capsule().fill(Color.onBackgroundSecondary))
            }
            Spacer().frame(height: 20)
            TimerView(job: $job, jobs: $jobs, saveTime: {}).foregroundStyle(.white)
        }
        .ignoresSafeArea()
    }
}

private extension TimerPopupFullScreen{
    func createCloseButton() -> some View {
        Button{
            dismiss()
        } label: {
            Text("Close")
        }
    }
}
