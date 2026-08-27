//
//  LatestMemoEntryView.swift
//  MemoWidgetsExtension
//
//  Created by 川島真之 on 2026/08/22.
//

import SwiftUI
import WidgetKit

struct LatestMemoEntryView: View {

  // MARK: - Properties

  let entry: LatestUserMemoEntry

  private let contentTextFontOpacityRate = 0.7
  private let backgroundColorOpacityRate = 0.175
  private let dateTextFontOpacityRate: Double = 0.7
  private let separatorHeight: CGFloat = 0.5
  private let titleLineLimit = 1
  private let topLevelVStackSpacing: CGFloat = 6

  @ScaledMetric(relativeTo: .footnote) private var iconSize: CGFloat = 20

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: topLevelVStackSpacing) {

      if let memo = entry.memo {

        HStack {
          Text(memo.updatedAt, format: .dateTime.year().month().day())
            .font(.footnote)
            .foregroundStyle(.primary.opacity(dateTextFontOpacityRate))

          Spacer()

          Image("EdgeOffIcon")
            .resizable()
            .scaledToFit()
            .frame(width: iconSize, height: iconSize)
        }

        Text(memo.title)
          .font(.headline)
          .lineLimit(titleLineLimit)

        Rectangle()
          .frame(height: separatorHeight)
          .foregroundStyle(Color.mainColor)

        Text(memo.content)
          .font(.footnote)
          .foregroundStyle(.primary.opacity(contentTextFontOpacityRate))
          .truncationMode(.tail)

      } else {

        Text("メモがまだありません")
          .font(.footnote)
          .foregroundStyle(.primary.opacity(contentTextFontOpacityRate))
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .containerBackground(for: .widget) {
      Color.white
    }
  }
}

// MARK: - レイアウトプレビュー用の仮要素

//import WidgetKit
//
//struct MemoEntry: TimelineEntry {
//    let date: Date
//}

//struct LatestMemoProvider: TimelineProvider {
//    func placeholder(in context: Context) -> MemoEntry { MemoEntry(date: .now) }
//
//    func getSnapshot(in context: Context, completion: @escaping (MemoEntry) -> Void) {
//        completion(MemoEntry(date: .now))
//    }
//
//    func getTimeline(in context: Context, completion: @escaping (Timeline<MemoEntry>) -> Void) {
//        completion(Timeline(entries: [MemoEntry(date: .now)], policy: .never))
//    }
//}

//struct LatestMemoWidget: Widget {
//    static let kind = "LatestMemoWidget"
//
//    var body: some WidgetConfiguration {
//        StaticConfiguration(kind: Self.kind, provider: LatestMemoProvider()) { entry in
//            LatestMemoEntryView()
//        }
//        .configurationDisplayName("最新のメモ")
//        .description("直近に更新したメモを表示します。")
//        .supportedFamilies([.systemMedium])
//    }
//}

//#Preview(as: .systemMedium) {
//    LatestMemoWidget()
//} timeline: {
//    MemoEntry(date: .now)
//}

//#Preview {
//    LatestMemoEntryView()
//        .frame(width: 338, height: 158)
//        .background(.fill.tertiary)
//        .clipShape(RoundedRectangle(cornerRadius: 22))
//        .padding()
//}
