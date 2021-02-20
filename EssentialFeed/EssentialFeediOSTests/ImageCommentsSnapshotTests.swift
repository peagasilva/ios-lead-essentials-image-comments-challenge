//
//  ImageCommentsSnapshotTests.swift
//  EssentialFeediOSTests
//
//  Created by Raphael Silva on 19/02/2021.
//  Copyright © 2021 Essential Developer. All rights reserved.
//

@testable import EssentialFeed
import EssentialFeediOS
import XCTest

class ImageCommentsSnapshotTests: XCTestCase {

	func test_emptyComments() {
		let sut = makeSUT()

		sut.display(emptyComments())

		assert(
			snapshot: sut.snapshot(for: .iPhone8(style: .light)),
			named: "IMAGE_COMMENTS_EMPTY_COMMENTS_light"
		)
		assert(
			snapshot: sut.snapshot(for: .iPhone8(style: .dark)),
			named: "IMAGE_COMMENTS_EMPTY_COMMENTS_dark"
		)
	}

	func test_commentsWithContent() {
		let sut = makeSUT()

		sut.display(commentsWithContent())

		assert(
			snapshot: sut.snapshot(for: .iPhone8(style: .light)),
			named: "IMAGE_COMMENTS_WITH_COMMENTS_light"
		)
		assert(
			snapshot: sut.snapshot(for: .iPhone8(style: .dark)),
			named: "IMAGE_COMMENTS_WITH_COMMENTS_dark"
		)
	}

	func test_commentsWithError() {
		let sut = makeSUT()

		sut.display(.error(message: "This is a\nmulti-line\nerror message"))

		assert(
			snapshot: sut.snapshot(for: .iPhone8(style: .light)),
			named: "IMAGE_COMMENTS_WITH_ERROR_light"
		)
		assert(
			snapshot: sut.snapshot(for: .iPhone8(style: .dark)),
			named: "IMAGE_COMMENTS_WITH_ERROR_dark"
		)
	}

	// MARK: - Helpers

	private func makeSUT() -> ImageCommentsViewController {
		let bundle = Bundle(for: ImageCommentsViewController.self)
		let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
		let controller = storyboard.instantiateInitialViewController() as! ImageCommentsViewController
		controller.loadViewIfNeeded()
		controller.tableView.showsVerticalScrollIndicator = false
		controller.tableView.showsHorizontalScrollIndicator = false
		return controller
	}

	private func emptyComments() -> ImageCommentsViewModel {
		ImageCommentsViewModel(comments: [])
	}

	private func commentsWithContent() -> ImageCommentsViewModel {
		let comments = [
			ImageCommentViewModel(
				message: "a message",
				date: "a date ago",
				username: "a user name"
			),
			ImageCommentViewModel(
				message: "another message",
				date: "another date ago",
				username: "another user name"
			),
			ImageCommentViewModel(
				message: "yet another message 👍",
				date: "yet another date ago",
				username: "yet another user name"
			),
			ImageCommentViewModel(
				message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim blandit volutpat maecenas. Habitasse platea dictumst quisque sagittis purus sit amet volutpat. Tortor consequat id porta nibh venenatis cras sed felis eget. Luctus venenatis lectus magna fringilla urna porttitor rhoncus dolor purus. Malesuada fames ac turpis egestas integer eget aliquet. Purus semper eget duis at tellus. Sit amet risus nullam eget felis. Scelerisque felis imperdiet proin fermentum. Urna nunc id cursus metus aliquam eleifend mi in nulla. Duis tristique sollicitudin nibh sit amet commodo nulla facilisi.",
				date: "some other date ago",
				username: "some other user name"
			)
		]

		return ImageCommentsViewModel(
			comments: comments
		)
	}
}
