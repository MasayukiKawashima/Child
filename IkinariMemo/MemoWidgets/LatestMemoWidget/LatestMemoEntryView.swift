//
//  LatestMemoEntryView.swift
//  MemoWidgetsExtension
//
//  Created by 川島真之 on 2026/08/22.
//

import SwiftUI

struct LatestMemoEntryView: View {


  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: 6) {
      Text("仮タイトル仮タイトル仮タイトル")
        .font(.headline)
        .lineLimit(1)

      Text("仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文仮本文")
        .font(.caption)
        .foregroundStyle(.secondary)
        .lineLimit(3)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
  }
}


// MARK: - レイアウトプレビュー用の仮要素

import WidgetKit

struct MemoEntry: TimelineEntry {
    let date: Date
}

struct LatestMemoProvider: TimelineProvider {
    func placeholder(in context: Context) -> MemoEntry { MemoEntry(date: .now) }

    func getSnapshot(in context: Context, completion: @escaping (MemoEntry) -> Void) {
        completion(MemoEntry(date: .now))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MemoEntry>) -> Void) {
        completion(Timeline(entries: [MemoEntry(date: .now)], policy: .never))
    }
}

struct LatestMemoWidget: Widget {
    static let kind = "LatestMemoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: Self.kind, provider: LatestMemoProvider()) { entry in
            LatestMemoEntryView()
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("最新のメモ")
        .description("直近に更新したメモを表示します。")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    LatestMemoWidget()
} timeline: {
    MemoEntry(date: .now)
}

//#Preview {
//    LatestMemoEntryView()
//        .frame(width: 338, height: 158)
//        .background(.fill.tertiary)
//        .clipShape(RoundedRectangle(cornerRadius: 22))
//        .padding()
//}
