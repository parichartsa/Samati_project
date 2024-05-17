import SwiftUI

struct MeditationDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: MeditationDetailViewModel
    @StateObject var audioManager = AudioManager.shared

    init(model: MeditationModel) {
        let audioURL: URL
        switch model.index {
        case 1:
            audioURL = Bundle.main.url(forResource: "music1", withExtension: "mp3")!
        case 2:
            audioURL = Bundle.main.url(forResource: "music2", withExtension: "mp3")!
        case 3:
            audioURL = Bundle.main.url(forResource: "music3", withExtension: "mp3")!
        case 4:
            audioURL = Bundle.main.url(forResource: "music4", withExtension: "mp3")!
        default:
            audioURL = Bundle.main.url(forResource: "music1", withExtension: "mp3")!
        }
        self.viewModel = MeditationDetailViewModel(model: model, audioURL: audioURL)
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()

                CircleView(image: viewModel.model.image,
                           backgroundColor: viewModel.model.background)
                
                Text(viewModel.model.text)
                    .fontWeight(.medium)
                    .font(.system(size: 24))
                    .padding(.top)
                
                Text("Samati")
                    .fontWeight(.medium)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                
                HStack(alignment: .center) {
                    playPauseButton
                }
                .padding()
                
                progressView
                    .padding(.top, 34)
                    .padding(.horizontal, 30)
                
                Spacer()
            }
            .background(Color.white)
            .cornerRadius(24)
            .background(
                Color(red: 254/255, green: 248/255, blue: 198/255)
                    .ignoresSafeArea()
            )
            .navigationBarItems(
                leading: backButton,
                trailing: Image("download")
            )
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            audioManager.play(url: viewModel.audioURL)
        }
    }

    private var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image("chevronArrowLeft")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 24, height: 24)
                .foregroundColor(.blue)
        }
        .frame(width: 44, height: 44)
    }

    private var playPauseButton: some View {
        Button(action: {
            audioManager.togglePlayPause()
        }) {
            Image(systemName: audioManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .frame(width: 32, height: 32)
                .padding()
                .background(Color(red: 254/255, green: 222/255, blue: 206/255))
                .foregroundColor(.white)
                .cornerRadius(32)
        }
        .frame(width: 64, height: 64)
    }

    private var progressView: some View {
        HStack(alignment: .center) {
            Text("00:02")
                .fontWeight(.regular)
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            MusicTimelineProgressView(progress: $audioManager.progress,
                                      mainColor: Color(red: 0/255, green: 67/255, blue: 236/255))
            .tint(Color.yellow)
            
            Text("00:0\(viewModel.model.time)")
                .fontWeight(.regular)
                .font(.system(size: 12))
                .foregroundColor(.gray)
        }
    }
}

struct MeditationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationDetailView(model: MeditationModel(text: "Reflection",
                                                    image: .reflection,
                                                    background: .blue,
                                                    time: 6, index: 1))
    }
}
