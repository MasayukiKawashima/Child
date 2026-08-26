//
//  SharedUserMemoStoreTests.swift
//  IkinariMemoTests
//

import XCTest
@testable import IkinariMemo

final class SharedUserMemoStoreTests: XCTestCase {

    // 各テスト前後に共有ストアを空にして、テスト間の状態を独立させる
    override func setUpWithError() throws {
        SharedUserMemoStore.saveLatestMemo(nil)
    }

    override func tearDownWithError() throws {
        SharedUserMemoStore.saveLatestMemo(nil)
    }

    // MARK: - Helpers

    private func makeMemo(
        id: String = "test-id",
        title: String = "タイトル",
        content: String = "本文",
        createdAt: Date = Date(timeIntervalSince1970: 1_000),
        updatedAt: Date = Date(timeIntervalSince1970: 2_000)
    ) -> SharedUserMemo {
        SharedUserMemo(
            id: id,
            title: title,
            content: content,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }

    // MARK: - 保存 → 読み込み

    func test_saveThenLoad_returnsSameMemo() {
        let memo = makeMemo()

        SharedUserMemoStore.saveLatestMemo(memo)
        let loaded = SharedUserMemoStore.loadLatestMemo()

        XCTAssertEqual(loaded?.id, memo.id)
        XCTAssertEqual(loaded?.title, memo.title)
        XCTAssertEqual(loaded?.content, memo.content)
        XCTAssertEqual(loaded?.createdAt, memo.createdAt)
        XCTAssertEqual(loaded?.updatedAt, memo.updatedAt)
    }

    // MARK: - nil 保存で削除される

    func test_saveNil_loadReturnsNil() {
        SharedUserMemoStore.saveLatestMemo(makeMemo())
        XCTAssertNotNil(SharedUserMemoStore.loadLatestMemo())

        SharedUserMemoStore.saveLatestMemo(nil)

        XCTAssertNil(SharedUserMemoStore.loadLatestMemo())
    }

    func test_loadWithoutSave_returnsNil() {
        XCTAssertNil(SharedUserMemoStore.loadLatestMemo())
    }

    // MARK: - 文字数切り詰め

    func test_saveTrimsTitleTo100() {
        let longTitle = String(repeating: "あ", count: 150)
        SharedUserMemoStore.saveLatestMemo(makeMemo(title: longTitle))

        let loaded = SharedUserMemoStore.loadLatestMemo()

        XCTAssertEqual(loaded?.title.count, 100)
        XCTAssertEqual(loaded?.title, String(repeating: "あ", count: 100))
    }

    func test_saveTrimsContentTo500() {
        let longContent = String(repeating: "い", count: 600)
        SharedUserMemoStore.saveLatestMemo(makeMemo(content: longContent))

        let loaded = SharedUserMemoStore.loadLatestMemo()

        XCTAssertEqual(loaded?.content.count, 500)
        XCTAssertEqual(loaded?.content, String(repeating: "い", count: 500))
    }

    func test_saveDoesNotTrimStringsAtLimit() {
        let title = String(repeating: "a", count: 100)   // ちょうど上限
        let content = String(repeating: "b", count: 500) // ちょうど上限
        SharedUserMemoStore.saveLatestMemo(makeMemo(title: title, content: content))

        let loaded = SharedUserMemoStore.loadLatestMemo()

        XCTAssertEqual(loaded?.title, title)
        XCTAssertEqual(loaded?.content, content)
    }
}
