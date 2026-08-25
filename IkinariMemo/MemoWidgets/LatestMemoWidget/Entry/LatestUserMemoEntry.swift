//
//  LatestUserMemoEntry.swift
//  MemoWidgetsExtension
//
//  Created by 川島真之 on 2026/08/25.
//

import Foundation
import WidgetKit

struct LatestUserMemoEntry: TimelineEntry {

  let date: Date
  let memo: SharedUserMemo
}
