//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit

public final class ErrorView: UIButton {
	public var message: String? {
		get { isVisible ? title(for: .normal) : nil }
		set { setMessageAnimated(newValue) }
	}
	
	public var onHide: (() -> Void)?

	private var isVisible: Bool { alpha > 0 }
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	private func configure() {
		backgroundColor = .errorBackgroundColor
		
		addTarget(self, action: #selector(hideMessageAnimated), for: .touchUpInside)
		configureLabel()
		hideMessage()
	}
	
	private func configureLabel() {
		titleLabel?.textColor = .white
		titleLabel?.textAlignment = .center
		titleLabel?.numberOfLines = 0
		titleLabel?.adjustsFontForContentSizeCategory = true
		titleLabel?.font = .preferredFont(forTextStyle: .body)
	}
	
	private func setMessageAnimated(_ message: String?) {
		if let message = message {
			showAnimated(message)
		} else {
			hideMessageAnimated()
		}
	}
	
	private func showAnimated(_ message: String) {
		setTitle(message, for: .normal)
		contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)

		UIView.animate(withDuration: 0.25) {
			self.alpha = 1
		}
	}
	
	@objc private func hideMessageAnimated() {
		UIView.animate(
			withDuration: 0.25,
			animations: { self.alpha = 0 },
			completion: { completed in
				if completed { self.hideMessage() }
			})
	}
	
	private func hideMessage() {
		setTitle(nil, for: .normal)
		alpha = 0
		contentEdgeInsets = .init(top: -2.5, left: 0, bottom: -2.5, right: 0)
		onHide?()
	}
}

extension UIColor {
	static var errorBackgroundColor: UIColor {
		UIColor(red: 1, green: 106 / 255, blue: 106 / 255, alpha: 1)
	}
}

extension UITableView {
	func configureHeader(using errorView: ErrorView) {
		let container = UIView()
		container.backgroundColor = .clear
		container.addSubview(errorView)

		errorView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			errorView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
			container.trailingAnchor.constraint(equalTo: errorView.trailingAnchor),
			errorView.topAnchor.constraint(equalTo: container.topAnchor),
			container.bottomAnchor.constraint(equalTo: errorView.bottomAnchor),
		])

		tableHeaderView = container

		errorView.onHide = { [weak self] in
			self?.beginUpdates()
			self?.sizeTableHeaderToFit()
			self?.endUpdates()
		}
	}
}
