//
//  EmptyViewPresenter.swift
//  OunassCase
//
//  Created by Yasin Akbas on 13.03.2025.
//

import UIKit

public protocol EmptyViewPresenterInterface: AnyObject {
    func load()
}

public struct EmptyViewPresenterArguments {
    let message: String
    let titleColor: UIColor
    let titleFontSize: Double
    
    public init(message: String, titleColor: UIColor, titleFontSize: Double) {
        self.message = message
        self.titleColor = titleColor
        self.titleFontSize = titleFontSize
    }
}

public class EmptyViewPresenter {
    private weak var view: EmptyViewInterface?
    private let arguments: EmptyViewPresenterArguments

    public init(view: EmptyViewInterface, arguments: EmptyViewPresenterArguments) {
        self.view = view
        self.arguments = arguments
    }
}

// MARK: - EmptyViewPresenterInterface
extension EmptyViewPresenter: EmptyViewPresenterInterface {
    public func load() {
        view?.prepareUI()
        view?.prepareTextLabel(message: arguments.message, color: arguments.titleColor, fontSize: arguments.titleFontSize)
    }
}
