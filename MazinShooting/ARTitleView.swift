//
//  ContentView.swift
//  MazinShooting
//

import SwiftUI
import RealityKit

struct ARTitleView : View {
    @EnvironmentObject var gameInfo: GameInfo
    var body: some View {
        ZStack {
            ARViewContainer(gameInfo: gameInfo)

            if gameInfo.gameState != .menu {
                Image("Aim")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .offset(y: -25)
            }

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

                // ステージ表示中
                if  gameInfo.gameState == .stage1 ||
                        gameInfo.gameState == .stage2 {

                    // ライフが残っている状態
                    if gameInfo.selfLife > 0 {

                        VStack {

                            HStack {

                                Spacer()

                                // タイトル画面へ戻るボタン
                                Button(action: {

                                    self.gameInfo.gameState = .menu
                                }) {

                                    Text("Menu")
                                        .padding([.trailing, .top], 15)
                                }
                            }

                            Spacer()

                            HStack {

                                // ライフ表示
                                Text("Life: " + String(gameInfo.selfLife))
                                    .foregroundColor(.white)
                                    .font(.system(size: 30))
                                    .padding([.leading, .bottom], 15)

                                Spacer()
                            }
                        }
                    }
                    else {

                        VStack(spacing: 200) {

                            // ゲームオーバー
                            Text("Game Over")
                                .foregroundColor(.white)
                                .font(.system(size: 60))

                            // 全回復して、続けてプレイ
                            Button(action: {

                                self.gameInfo.selfLife = 10
                            }) {

                                Text("Continue")
                            }
                        }
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
