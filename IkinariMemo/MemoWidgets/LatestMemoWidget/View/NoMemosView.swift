//
//  NoMemosView.swift
//  MemoWidgetsExtension
//
//  Created by 川島真之 on 2026/08/31.
//

import SwiftUI
import WidgetKit

struct NoMemosView: View {


  // MARK: - Properties

  private let contentTextFontOpacityRate = 0.7
  @ScaledMetric(relativeTo: .footnote) private var iconSize: CGFloat = 20


  // MARK: - Body

  var body: some View {
    Text("メモがまだありません")
      .font(.footnote)
      .foregroundStyle(.primary.opacity(contentTextFontOpacityRate))
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay(alignment: .topTrailing) {
        Image("EdgeOffIcon")
          .resizable()
          .scaledToFit()
          .frame(width: iconSize, height: iconSize)
      }
  }
}

// MARK: - Preview

// プレビュー専用に NoMemosView をラップした簡易 Widget
private struct NoMemosPreviewWidget: Widget {
  var body: some WidgetConfiguration {
    StaticConfiguration(kind: "NoMemosPreview", provider: LatestMemoProvider()) { _ in
      NoMemosView()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .containerBackground(for: .widget) {
          Color.white
        }
    }
    .supportedFamilies([.systemMedium])
  }
}

#Preview(as: .systemMedium) {
  NoMemosPreviewWidget()
} timeline: {
  LatestUserMemoEntry(date: .now, memo: nil)
}
