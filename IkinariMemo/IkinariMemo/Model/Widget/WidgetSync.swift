//
//  WidgetSync.swift
//  IkinariMemo
//
//  Created by 川島真之 on 2026/08/30.
//

import Foundation
import RealmSwift
import WidgetKit


// FIXME: - 将来的にWidgetの種類が増えた場合にWidgetSyncの再設計を検討
// 現状では最新メモWidget専用の設計になっているため、全てのWidgetに対応するように汎化を行うべきかも

enum WidgetSync {

  static func updateLatestMemo() {
    autoreleasepool {
      guard let realm = try? Realm() else {
        assertionFailure("Realm を開けませんでした")
        return
      }

      let latest = realm.objects(UserMemo.self)
        .sorted(byKeyPath: "updatedAt", ascending: false)
        .first

      SharedUserMemoStore.saveLatestMemo(latest.map {
        SharedUserMemo(id: $0.id.stringValue,
                       title: $0.title,
                       content: $0.content,
                       createdAt: $0.createdAt,
                       updatedAt: $0.updatedAt)
      })

      WidgetCenter.shared.reloadTimelines(ofKind: WidgetKind.latestMemo)
    }
  }
}
