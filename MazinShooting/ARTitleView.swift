//
//  ContentView.swift
//  MazinShooting
//
//  Created by 小松虎太郎 on 2023/05/27.
//

import SwiftUI
import RealityKit

struct ARTitleView : View {
    @EnvironmentObject var gameInfo: GameInfo
    var body: some View {
        ZStack {
            ARViewContainer(gameInfo: gameInfo)

            VStack(spacing: 200) {

                if gameInfo.gameState == .menu {
                    Text("布団ちゃんシューティング").bold()
                        .font(.system(size: 20))
                        .foregroundColor(.white)

                    Button {
                        self.gameInfo.gameState = .placingContent
                    } label: {
                        Text("討伐開始")
                    }
                }

            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    var gameInfo: GameInfo

      func makeUIView(context: Context) -> UIView {

          return ARShootingView(frame: .zero, gameInfo: gameInfo)
      }

      func updateUIView(_ uiView: UIView, context: Context) {}
}

#if DEBUG
struct ARTitleView_Previews : PreviewProvider {
    static var previews: some View {
        ARTitleView()
            .environmentObject(GameInfo())
    }
}
#endif
