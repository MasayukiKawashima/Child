//
//  LatestMemoProvider.swift
//  MemoWidgetsExtension
//
//  Created by 川島真之 on 2026/08/25.
//

import Foundation
import WidgetKit

struct LatestMemoProvider: TimelineProvider {

  private var dummy: SharedUserMemo {
    SharedUserMemo(id: "preview",
                   title: "一日を良くする朝の習慣",
                   content: "朝の始まりを少し丁寧にするだけで、一日の気分や集中力が大きく変わる。目覚めたらまずカーテンを開けて自然光を取り込み、深呼吸で体を目覚めさせる。",
                   createdAt: .now,
                   updatedAt: .now)
  }


  // ウィジェットギャラリーを開いた直後や、システムがプレビューを描画するときに表示するダミーを設定するメソッド
  func placeholder(in context: Context) -> LatestUserMemoEntry {

    LatestUserMemoEntry(date: .now, memo: dummy)
  }
  
  // ユーザーがWidgetのギャラリーを見ているときに表示するWidgetの見本を設定するメソッド
  func getSnapshot(in context: Context, completion: @escaping (LatestUserMemoEntry) -> ()) {

    // ギャラリー表示中は見本を、それ以外は実データを返す
    let memo = context.isPreview ? dummy : SharedUserMemoStore.loadLatestMemo()
    completion(LatestUserMemoEntry(date: .now, memo: memo))
  }

  // 実際にWidgetに表示する本番用データを設定するメソッド
  func getTimeline(in context: Context, completion: @escaping (Timeline<LatestUserMemoEntry>) -> ()) {

    let entry = LatestUserMemoEntry(date: .now, memo: SharedUserMemoStore.loadLatestMemo())
    completion(Timeline(entries: [entry], policy: .never))
  }

  //    func relevances() async -> WidgetRelevances<Void> {
  //        // Generate a list containing the contexts this widget is relevant in.
  //    }
}
