//
//  HPBarView.swift
//  MazinShooting
//

import SwiftUI

struct HPBarView: View {
    @EnvironmentObject var gameInfo: GameInfo

    @State private var percentage: CGFloat = 1.0
    private var percentages: [CGFloat] = [1, 0.9, 0.7, 0.2, 0]
    var body: some View {
        VStack {
            Capsule()
                .fill(.gray.opacity(0.2))
                .frame(width: 300, height: 8)
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 300 * percentage)
                        .animation(.easeOut(duration: 1), value: percentage)
                }
                .overlay(alignment: .leading) {
                    Rectangle()
                        .fill(.green)
                        .frame(width: 300 * percentage)
                        .animation(.easeOut(duration: 0.1), value: percentage)
                }
                .cornerRadius(4)

            Text("\(gameInfo.selfLife)/10")
                .font(.footnote.bold())
                .kerning(2)

            //preview用
//            Button(action: {
//                gameInfo.selfLife -= 1
//            }, label: {
//                Text("Start")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 8)
//                    .padding(.horizontal, 16)
//                    .background(Color.blue)
//                    .cornerRadius(20)
//            })
        }
        .onChange(of: gameInfo.selfLife) { newValue in
            percentage = CGFloat(newValue) / 10
        }
    }
}

struct HPBarView_Previews: PreviewProvider {
    static var previews: some View {
        HPBarView()
            .environmentObject(GameInfo())
    }
}
