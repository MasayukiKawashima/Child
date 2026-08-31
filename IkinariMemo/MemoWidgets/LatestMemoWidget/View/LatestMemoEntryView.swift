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

        NoMemosView()
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .containerBackground(for: .widget) {
      Color.white
    }
  }
}


// MARK: - Preview

// プレビュー専用に LatestMemoEntryView をラップした簡易 Widget
private struct LatestMemoEntryPreviewWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "LatestMemoEntryPreview", provider: LatestMemoProvider()) { entry in
      LatestMemoEntryView(entry: entry)
    }
    .supportedFamilies([.systemMedium])
  }
}

#Preview(as: .systemMedium) {
  LatestMemoEntryPreviewWidget()
} timeline: {
  LatestUserMemoEntry(date: .now, memo: SharedUserMemo(
    id: "1",
    title: "買い物リスト",
    content: "牛乳、卵、パン\n帰りにドラッグストアへ寄る",
    createdAt: .now,
    updatedAt: .now))
}
