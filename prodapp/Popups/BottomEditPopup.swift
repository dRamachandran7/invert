//
//  BottomEditPopup.swift
//  prodapp
//
//  Created by Dhruva Ramachandran on 4/1/24.
//

import SwiftUI
import MijickPopupView

struct BottomEditPopup: BottomPopup {
    @Binding var jobs: [Job]
    @Binding var job: Job
    func configurePopup(popup: BottomPopupConfig) -> BottomPopupConfig {
        popup
            .contentFillsWholeHeigh(true)
            .dragGestureEnabled(true)
            .backgroundColour(Color.onBackgroundPrimary)
    }
    func createContent() -> some View {
        EditJob(jobs: $jobs, job: $job).background(Color.onBackgroundPrimary)
    }
}


