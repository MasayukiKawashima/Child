//
//  MemoRepository.swift
//  IkinariMemo
//

import Foundation
import RealmSwift

/// テスト時にモック差し替えができるようにするためのプロトコル（任意）
protocol MemoRepositoryProtocol {
  func fetchAllSortedByCreatedAt() -> Results<UserMemo>
  func hasAnyMemo() -> Bool
  func observeAll(_ onChange: @escaping () -> Void) -> NotificationToken?
  func save(_ memo: UserMemo, title: String?, content: String?)
  func delete(_ memo: UserMemo)
  func deleteAll()
}

/// Realm への全アクセスを集約する層。
/// 書き込み系メソッドは、トランザクション成功後に必ず
/// Widget / 共有 UserDefaults への同期（WidgetSync.updateLatestMemo）を行う。
final class MemoRepository: MemoRepositoryProtocol {


  // MARK: - Properties

  static let shared = MemoRepository()
  private let realm: Realm


  // MARK: - Init

  /// テストではインメモリ Realm などを注入できる
  init(realm: Realm? = nil) {
    if let realm {
      self.realm = realm
    } else {
      do {
        self.realm = try Realm()
      } catch {
        fatalError("Realm の初期化に失敗しました: \(error)")
      }
    }
  }


  // MARK: - 読み取り

  func fetchAllSortedByCreatedAt() -> Results<UserMemo> {
    realm.objects(UserMemo.self).sorted(byKeyPath: "createdAt", ascending: false)
  }

  func hasAnyMemo() -> Bool {
    !realm.objects(UserMemo.self).isEmpty
  }

  func observeAll(_ onChange: @escaping () -> Void) -> NotificationToken? {
    fetchAllSortedByCreatedAt().observe { _ in onChange() }
  }


  // MARK: - 書き込み

  /// メモの新規保存 / 更新。
  /// title / content は変更したい項目だけ渡す（nil の項目は据え置き）。
  /// ※ プロパティの変更は必ず write トランザクション内で行う必要があるため、
  ///   値の代入は performWrite の中で実施している。
  func save(_ memo: UserMemo, title: String? = nil, content: String? = nil) {
    performWrite {
      if let title { memo.title = title }
      if let content { memo.content = content }
      memo.updatedAt = Date()
      realm.add(memo, update: .modified)
    }
  }

  func delete(_ memo: UserMemo) {
    performWrite {
      realm.delete(memo)
    }
  }

  func deleteAll() {
    performWrite {
      realm.delete(realm.objects(UserMemo.self))
    }
  }


  // MARK: - 共通処理

  /// write トランザクションを実行し、成功したら Widget / 共有 UserDefaults を同期する。
  /// - Parameter updates: write トランザクション内で行うデータ更新処理
  private func performWrite(_ updates: () -> Void) {
    do {
      try realm.write {
        updates()
      }
      // 内部で SharedUserMemoStore への保存（共有 UserDefaults）と
      // WidgetCenter.reloadTimelines をまとめて実行してくれる
      WidgetSync.updateLatestMemo()
    } catch {
      assertionFailure("Realm 書き込みに失敗しました: \(error)")
    }
  }
}
