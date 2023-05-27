//
//  ARShootingView.swift
//  MazinShooting
//
//  Created by 小松虎太郎 on 2023/05/27.
//

import SwiftUI
import ARKit
import RealityKit
import Combine

class ARShootingView: UIView, ARSessionDelegate {

    // ARView
    let arView = ARView(frame: UIScreen.main.bounds)

    // コーチングオーバーレイビュー
    let coachingOverlayView = ARCoachingOverlayView(frame: UIScreen.main.bounds)

    // ステージ
    var gameAnchor = try! GameStages.loadStage1()

    // ゲーム情報
    var gameInfo: GameInfo

    // ゲーム情報を受け取るタスク
    var gameInfoTask: AnyCancellable?

    // 初期化
    init(frame frameRect: CGRect, gameInfo: GameInfo) {

        // ゲーム情報の受け取り
        self.gameInfo = gameInfo

        // 親クラスの初期化
        super.init(frame: frameRect)

        // ARViewの追加
        addSubview(arView)

        // ゲーム情報の受け取りタスク
        self.gameInfoTask = gameInfo.$gameState.receive(on: DispatchQueue.main).sink { (value) in

            if value == .placingContent {

                self.setupConfiguration()

                self.addCoachingOverlayView()
            }
        }
    }

    //クラスを生成する際に必ずinitメソッドを実行するように強制するメソッド
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK:- Configuration

    // コンフィグ設定
    func setupConfiguration() {

        // 床の平面を探す
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config, options: [])
    }

    //MARK:- Game

    // ゲーム開始
    func startGame() {

        // ゲームアンカー追加
        //この追加によって3DコンテンツがAR空間に表示されます。
        arView.scene.addAnchor(gameAnchor)

        // ステージ1に移行
        gameInfo.gameState = .stage1

        // 平面検出の停止
        arView.session.run(ARWorldTrackingConfiguration())
    }
}
