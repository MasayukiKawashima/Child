//
//  DeleteDataView.swift
//  IkinariMemo
//
//  Created by 川島真之 on 2025/09/11.
//

import SwiftUI

struct DeleteDataView: View {


  // MARK: - Properties

  @StateObject private var viewModel: DeleteDataViewModel = DeleteDataViewModel()

  @State private var isShowDeleteConfirmationAlert = false
  @State private var isShowDeleteCompletedAlert = false


  // MARK: - Body

  var body: some View {
    VStack {
      List {
        HStack {
          Text("全てのメモを削除")
            .foregroundStyle(Color.red)

          Spacer()

          Button(action: {
              // ボタンがタップされた時のアクション
            isShowDeleteConfirmationAlert.toggle()
          }) {
            Image(systemName: "trash.fill")
              .foregroundColor(Color.red)
          }
          .alert("警告", isPresented: $isShowDeleteConfirmationAlert) {

              Button("削除する", role: .destructive) {
                // １データ削除処理
                viewModel.deleteAllMemos()
                //　２終了ログ表示
                isShowDeleteCompletedAlert.toggle()
              }

              Button("キャンセル", role: .cancel) {
              }
          } message: {
              Text("全てのメモを削除してもよろしいですか\nこの操作は取り消せません")
          }
          .alert("全てのメモが削除されました", isPresented: $isShowDeleteCompletedAlert) {
          }
        }
      }
      .scrollContentBackground(.hidden)
    }
    .background(Color.listBackgroundColor)
    .customBackButton()
  }
}

#Preview {
    DeleteDataView()
}
