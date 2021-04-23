//
//  ArticleViewController.swift
//  News
//
//  Created Musa Kokcen on 16.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import WebKit

private extension ArticleViewController {
    struct Constant {
        struct UI {
            static let backgroundColor: UIColor = .white
            static let title: String = Localizable.article.uppercased()
        }
    }
}

protocol ArticleViewInterface: ViewInterface, Storyboarded {
	func prepareUI()
    func prepareArticle(with source: URL)
}

final class ArticleViewController: BaseViewController {
    
    @IBOutlet private weak var articleView: WKWebView! {
        didSet {
            articleView.navigationDelegate = self
        }
    }
    
    static var storyboardName: String {
        return StoryboardNames.article.rawValue
    }

	var presenter: ArticlePresenterInterface!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

extension ArticleViewController: ArticleViewInterface {
	func prepareUI() {
        view.backgroundColor = Constant.UI.backgroundColor
        articleView.backgroundColor = Constant.UI.backgroundColor
        navigationItem.title = Constant.UI.title
    }

    func prepareArticle(with source: URL) {
        articleView.load(URLRequest(url: source))
        articleView.allowsBackForwardNavigationGestures = true
    }
}

extension ArticleViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter.articleLoaded()
    }
}
