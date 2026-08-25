//
//  LatestMemoProvider.swift
//  MemoWidgetsExtension
//
//  Created by 川島真之 on 2026/08/25.
//

import Foundation
import WidgetKit

struct LatestMemoProvider: TimelineProvider {

  // TODO: SharedStore.load() に差し替える
  private var dummy: SharedUserMemo {
    SharedUserMemo(id: "preview",
                   title: "買い物リスト",
                   content: "牛乳、卵、パン\n帰りにドラッグストアへ寄る",
                   createdAt: .now,
                   updatedAt: .now)
  }

  func placeholder(in context: Context) -> LatestUserMemoEntry {
    LatestUserMemoEntry(date: .now, memo: dummy)
  }

  func getSnapshot(in context: Context, completion: @escaping (LatestUserMemoEntry) -> ()) {
    completion(LatestUserMemoEntry(date: .now, memo: dummy))
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<LatestUserMemoEntry>) -> ()) {

    completion(Timeline(entries: [LatestUserMemoEntry(date: .now, memo: dummy)], policy: .never))
  }

//    func relevances() async -> WidgetRelevances<Void> {
//        // Generate a list containing the contexts this widget is relevant in.
//    }
}
