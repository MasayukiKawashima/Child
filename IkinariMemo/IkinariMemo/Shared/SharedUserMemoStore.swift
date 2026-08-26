//
//  SharedUserMemoStore.swift
//  IkinariMemo
//
//  Created by 川島真之 on 2026/08/26.
//

import Foundation

enum SharedUserMemoStore {


  // MARK: - Properties

  static let appGroupID = "group.dev.kawashima.IkinariMemo"
  private static let latestMemoKey = "latestMemo"
  private static var userDefaults: UserDefaults? {
    UserDefaults(suiteName: appGroupID)
  }

  private static let titleLimit = 100
  private static let contentLimit = 500


  // MARK: - 保存 本体側からのみ利用

  static func saveLatestMemo(_ memo: SharedUserMemo?) {

    guard let userDefaults else {
      assertionFailure("App Group が設定されていません: \(appGroupID)")
      return
    }

    // メモが一件もなかった場合にWidget側に共有するメモも削除する
    // 例えば全メモ削除後、本体側ではメモが一件もないのに、widget側で表示されてしまうことを防ぐための処理
    guard let memo else {
      userDefaults.removeObject(forKey: latestMemoKey)
      return
    }

    do {
      let data = try JSONEncoder().encode(trimmed(memo))
      userDefaults.set(data, forKey: latestMemoKey)
    } catch {
      assertionFailure("SharedUserMemo のエンコードに失敗: \(error)")
    }
  }


  // MARK: - 読み込み Widget側からのみ利用

  static func loadLatestMemo() -> SharedUserMemo? {
      guard let data = userDefaults?.data(forKey: latestMemoKey) else { return nil }
      return try? JSONDecoder().decode(SharedUserMemo.self, from: data)
  }

  
  // MARK: - 文字数切り詰め

  /// ウィジェットの表示に必要な長さだけを残す
  private static func trimmed(_ memo: SharedUserMemo) -> SharedUserMemo {
    SharedUserMemo(
      id: memo.id,
      title: String(memo.title.prefix(titleLimit)),
      content: String(memo.content.prefix(contentLimit)),
      createdAt: memo.createdAt,
      updatedAt: memo.updatedAt
    )
  }

}
