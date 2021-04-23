//
//  NewsViewController.swift
//  News
//
//  Created Musa Kokcen on 15.03.2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit

private extension NewsViewController {
    struct Constant {
        struct UI {
            static let backgroundColor: UIColor = .white
            static let textColor: UIColor = .black
            
            struct TableView {
                static let cellHeight: CGFloat = 120
            }
            
            struct SearchBar {
                static let backgroundColor: UIColor = .white
                static let textFieldBackgroundColor: UIColor = UIColor.lightGray.withAlphaComponent(0.2)
                static let textColor: UIColor = .black
                static let cornerRadius: CGFloat = 8
            }
        }
    }
}

protocol NewsViewInterface: ViewInterface, Storyboarded {
    func prepareUI()
    func reloadTableView()
    func setNavigationControllerTitle(with title: String)
}

final class NewsViewController: BaseViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet private weak var newsTableView: UITableView! {
        didSet {
            newsTableView.delegate = self
            newsTableView.dataSource = self
            newsTableView.register(NewsCell.getNib(), forCellReuseIdentifier: NewsCell.identifier)
        }
    }
    
    private lazy var refreshNewsControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        return refreshControl
    }()
    
    static var storyboardName: String {
        return StoryboardNames.news.rawValue
    }
    
    var presenter: NewsPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    private func prepareNavigationBar() {
        navigationController?.navigationBar.changeTransparency(to: .transparent)
        navigationController?.navigationBar.tintColor = Constant.UI.textColor
    }
    
    private func prepareTableView() {
        newsTableView.backgroundColor = Constant.UI.backgroundColor
        newsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        newsTableView.indicatorStyle = .black
        newsTableView.refreshControl = refreshNewsControl
    }
    
    private func prepareSearchBar() {
        
        if let view: UIView = self.searchBar.subviews.first {
            for subView: UIView in view.subviews {
                if let textView = subView as? UITextField {
                    textView.tintColor = Constant.UI.SearchBar.textColor
                }
            }
        }
        
        searchBar.barTintColor = Constant.UI.SearchBar.backgroundColor
        searchBar.searchTextField.leftView?.tintColor = Constant.UI.SearchBar.textColor
        searchBar.tintColor = Constant.UI.SearchBar.textColor
        searchBar.searchBarStyle = .default
        searchBar.backgroundColor = Constant.UI.SearchBar.backgroundColor
        searchBar.isTranslucent = true
        
        searchBar.searchTextField.backgroundColor =  Constant.UI.SearchBar.textFieldBackgroundColor
        searchBar.searchTextField.textColor = Constant.UI.SearchBar.textColor
        searchBar.searchTextField.layer.cornerRadius = Constant.UI.SearchBar.cornerRadius
        searchBar.searchTextField.layer.masksToBounds = true
    }
    
    private func prepareRefreshControl() {
        refreshNewsControl.attributedTitle = NSAttributedString(string: Localizable.pullToRefresh)
    }
    
    @objc private func refreshNews(_ sender: Any) {
        refreshNewsControl.endRefreshing()
        presenter.refreshNews()
    }
    
    private func showSearchBarCancelButton(_ show: Bool) {
        UIView.performWithoutAnimation {
            searchBar.setShowsCancelButton(show, animated: true)
        }
    }
}

extension NewsViewController: NewsViewInterface {
    func prepareUI() {
        view.backgroundColor = Constant.UI.backgroundColor
        prepareNavigationBar()
        prepareSearchBar()
        prepareRefreshControl()
        prepareTableView()
    }
    
    func reloadTableView() {
        newsTableView.reloadData()
    }
    
    func setNavigationControllerTitle(with title: String) {
        navigationItem.title = title
    }
}

extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = newsTableView.dequeueReusableCell(with: NewsCell.self, for: indexPath)
        let data = presenter.getData(for: indexPath)
        cell.configure(with: data)
        
        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.articleSelected(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.UI.TableView.cellHeight
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter.willDisplayCell(at: indexPath)
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showSearchBarCancelButton(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBarTextChanged(to: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        showSearchBarCancelButton(false)
        view.endEditing(true)
    }
}
