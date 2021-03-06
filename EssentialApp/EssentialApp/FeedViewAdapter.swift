//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import EssentialFeed
import EssentialFeediOS

final class FeedViewAdapter: FeedView {
	private weak var controller: FeedViewController?
	private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
	private let onSelection: (FeedImage) -> Void
	
	init(
		controller: FeedViewController,
		imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher,
		onSelection: @escaping (FeedImage) -> Void
	) {
		self.controller = controller
		self.imageLoader = imageLoader
		self.onSelection = onSelection
	}
	
	func display(_ viewModel: FeedViewModel) {
		controller?.display(viewModel.feed.map { model in
			let adapter = FeedImageDataLoaderPresentationAdapter<WeakRefVirtualProxy<FeedImageCellController>, UIImage>(model: model, imageLoader: imageLoader)
			let view = FeedImageCellController(
				delegate: adapter,
				onSelection: { [onSelection] in
					onSelection(model)
				}
			)
			
			adapter.presenter = FeedImagePresenter(
				view: WeakRefVirtualProxy(view),
				imageTransformer: UIImage.init)
			
			return view
		})
	}
}
