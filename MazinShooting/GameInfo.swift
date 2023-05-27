//
//  GameInfo.swift
//  MazinShooting
//
//  Created by 小松虎太郎 on 2023/05/27.
//
import SwiftUI

enum GameState {

    // ゲームメニューを表示しています
    case menu

    // 現実世界の平面を探しています
    case placingContent

    // ステージ1を表示しています
    case stage1

    // ステージ2を表示しています
    case stage2

    // ゲーム終了
    case endGame
}

final class GameInfo: ObservableObject {
    @Published var gameState: GameState = .menu
}



