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
import MultipeerConnectivity

struct EntityName {
    static let bulletAnchor = "BulletAnchor"
    static let bullet = "Bullet"

    // 弾丸
    static let selfBullet = "SelfBullet"
    static let enemyBullet = "EnemyBullet"
}

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

        arView.session.delegate = self

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

        setupGestureRecognizers()

        // ステージ1に移行
        gameInfo.gameState = .stage1

        // 平面検出の停止
        arView.session.run(ARWorldTrackingConfiguration())
    }

    func setupGestureRecognizers() {

          // タップして撃つ
          let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addBulletAnchor(recognizer:)))

          tapRecognizer.numberOfTouchesRequired = 1

          // シーンにジェスチャー追加
          addGestureRecognizer(tapRecognizer)
      }

      // 弾丸のARAnchor追加
      @objc func addBulletAnchor(recognizer: UITapGestureRecognizer){

          // sessionにARAnchorを追加する (ARAnchorはARKitのクラス)
          let bulletAnchor = ARAnchor(name: EntityName.bulletAnchor, transform: arView.cameraTransform.matrix)
          arView.session.add(anchor: bulletAnchor)

      }

      // 弾丸を発射します
      func bulletShot(named entityName: String, for anchor: ARAnchor) {

          // Bulletを取得する
          let bulletEntity = try! ModelEntity.load(named: entityName)

          // ARAnchorをAnchorEntityに変換します
          let anchorEntity = AnchorEntity(anchor: anchor)
//          let anchorEntity = AnchorEntity() //previewのときのみ

          anchorEntity.addChild(bulletEntity)
          arView.scene.addAnchor(anchorEntity)

          // 弾丸が0.4秒で端に到達するので、プラス0.1秒後に消します
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
              self.arView.scene.removeAnchor(anchorEntity)
          }

      }

      //MARK:- ARSessionDelegate

      // ARAnchorが追加されると呼ばれます
      func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {

          for anchor in anchors {

              if let anchorName = anchor.name, anchorName == EntityName.bulletAnchor {
                  bulletShot(named: EntityName.bullet, for: anchor)
              }
          }
      }
}
