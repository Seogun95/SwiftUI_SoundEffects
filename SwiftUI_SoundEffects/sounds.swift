//
//  sounds.swift
//  SwiftUI_SoundEffects
//
//  Created by Seogun Kim on 2021/06/29.
//

import SwiftUI
import AVKit

class SoundManager: ObservableObject {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum soundOption: String {
        case Click
        case Knock
    }
    
    func playSound(sounds: soundOption) {
        guard let url = Bundle.main.url(forResource: sounds.rawValue, withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("재생하는데 오류가 생겼습니다. 오류코드 \(error.localizedDescription)")
        }
    }
    
}

struct sounds: View {
    @State var isLoading: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 30) {
                    profileViews(name: "서근개발노트", description: "안녕하세요")
                    profileViews(name: "하나", description: "스며들어 할지라도 낙원을 그들의 타오르고 역사를 보라.")
                    profileViews(name: "둘", description: "이것은 곧 인간이 공자는 길을 그들의 하는 때까지 없는 것이다. 싸인 주며, 이상 얼마나 사람은 부패뿐이다.")
                    profileViews(name: "셋", description: "있는 이상이 아니한 열락의 광야에서 하였으며, 물방아 안고, 있는가? 인도하겠다는 이상이 청춘의 몸이 안고, 이것이야말로 있으며, 봄바람이다.")
                }
                .padding()
                .navigationBarTitle("서근 개발 블로그")
                .redacted(reason: isLoading ? [] : .placeholder)
                Spacer()
                
                Button {
                    startNetworkCall()
                    SoundManager.instance.playSound(sounds: .Knock)
                } label: {
                    Text("숨김 / 펼치기")
                }
                
            }
        }
        
    }
    func startNetworkCall() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isLoading.toggle()
        }
    }
}

struct profileViews: View {
    var name: String
    var description: String
    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading, spacing: 3) {
                Text(name)
                    .font(.headline)
                Text(description)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 70)
        
    }
}

struct sounds_Previews: PreviewProvider {
    static var previews: some View {
        sounds()
    }
}
