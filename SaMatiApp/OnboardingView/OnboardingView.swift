import SwiftUI

struct OnboardingView: View {
    @State private var isMainViewActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Circle()
                    .frame(width: 280, height: 280)
                    .foregroundColor(.orangeMain)
                    .offset(x: 140, y: -350)
                
                Circle()
                    .frame(width: 495, height: 495)
                    .foregroundColor(.blueMain)
                    .offset(y: 300)
                
                VStack(alignment: .leading) {
                    Text("SAMATI")
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                        .padding(.leading, 74)
                        .foregroundColor(.gray)
                    
                    Text("ทำสมาธิ\nก่อนเริ่มวันใหม่")
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                        .padding(.leading, 74)
                    
                    HStack {
                        Spacer()
                        Image(.samathi)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                    
                    NavigationLink(
                        destination: MainView(viewModel: MenuViewModel()),
                        isActive: $isMainViewActive,
                        label: {
                            EmptyView()
                        }
                    )
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isMainViewActive = true
                        }) {
                            Image(.arrowRight)
                                .foregroundColor(Color.red)
                                .padding()
                                .background(Color.utility)
                                .cornerRadius(32)
                        }
                        .frame(width: 64, height: 64)
                        .padding()
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
