import UIKit
import SwiftUI

struct JobMenu: View {
    @Binding var jobs: [Job]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    var body: some View {
        Text("Tasks").font(Font.nexaHeavy(27)).multilineTextAlignment(.leading)
        VStack{
            NavigationStack{
                List($jobs, id: \.name){ job in
                    VStack{
                        JobCardView(jobs: $jobs, job: job, timeClosed: .constant(Date.now), mustRedo: .constant(false))
                    }
                    
                }
                .toolbar{
                    NavigationLink{
                        CreateJob(jobs: $jobs)
                    } label: {
                        Image(systemName: "plus")
                    }
                    Button{
                        InfoPopup().showAndStack()
                    } label: {
                        Image(systemName: "info.circle").frame(alignment: .leading)
                    }
                }
            }
            
        }
        .onAppear() {
            WelcomePopup().showAndStack()
        }
    }
}
    #Preview {
        JobMenu(jobs: .constant(Job.sampleData), saveAction: {})
    }
