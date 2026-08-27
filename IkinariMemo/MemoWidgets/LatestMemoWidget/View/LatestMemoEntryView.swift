//
//  LatestMemoEntryView.swift
//  MemoWidgetsExtension
//
//  Created by 川島真之 on 2026/08/22.
//

import SwiftUI

struct LatestMemoEntryView: View {


  // MARK: - Properties

  private var contentTextFontOpacityRate = 0.7
  private var separatorOpacityRate = 0.3
  private var backgroundColorOpacityRate = 0.175
  private var dateTextFontOpacityRate: Double = 0.7
  private var separatorHeight: CGFloat = 0.5
  private var titleLineLimit = 1
  private var topLevelVStackSpacing: CGFloat = 6

  @ScaledMetric(relativeTo: .footnote) private var iconSize: CGFloat = 20

  private var dummyTitle = "仮タイトル仮タイトル仮タイトル仮タイトル仮タイトル仮タイトル"
  private var dummyText = "あああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ"

  private var dummyDate = "2026.08.24"

  // MARK: - Body

  var body: some View {
    VStack(alignment: .leading, spacing: topLevelVStackSpacing) {

      HStack {

        Text(dummyDate)
          .font(.footnote)
          .foregroundStyle(.primary.opacity(dateTextFontOpacityRate))

        Spacer()

        Image("EdgeOffIcon", bundle: .main)
          .resizable()
          .scaledToFit()
          .frame(width: iconSize, height: iconSize)
      }

      Text(dummyTitle)
        .font(.headline)
        .lineLimit(titleLineLimit)

      Rectangle()
        .frame(height: separatorHeight)
        .foregroundStyle(Color.mainColor)

      Text(dummyText)
        .font(.footnote)
        .foregroundStyle(.primary.opacity(contentTextFontOpacityRate))
        .truncationMode(.tail)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .containerBackground(for: .widget) {
//      Color.mainColor.opacity(backgroundColorOpacityRate)
      Color.white
    }
  }
}


// MARK: - レイアウトプレビュー用の仮要素

import WidgetKit

struct MemoEntry: TimelineEntry {
    let date: Date
}

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
