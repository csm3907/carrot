//
//  SearchViewController.swift
//
//
//  Created by 최승민 on 9/20/24.
//

import Core
import Design

import UIKit
import Combine

public class SearchViewController: UIViewController {
    var isEditMode: Bool {
        let searchController = navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.keyboardDismissMode = .onDrag
        view.bounces = false
        view.register(SearchCell.self, forCellReuseIdentifier: SearchCell.identifier)
        view.register(FooterView.self, forCellReuseIdentifier: FooterView.identifier)
        view.delegate = self
        return view
    }()
    
    private var dataSources: SearchDataSource!
    var searchViewModel: SearchViewModelType = SearchViewModel()
    var cancellables: Set<AnyCancellable> = .init()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "검색"
        
        bind()
        setTableView()
        setupSearchController()
    }
    
    func bind() {
        searchViewModel.output.bookList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] bookList in
                guard  let self else { return }
                if bookList.isEmpty {
                    
                } else {
                    let snapshot = self.searchViewModel.output.makeSnapshot()
                    self.setSnapshot(snapshot)
                }
            }
            .store(in: &cancellables)
        
        searchViewModel.output.error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorString in
                self?.alert(message: errorString)
            }
            .store(in: &cancellables)
    }
    
    private func setTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        dataSources = dataSource(tableView: tableView)
    }
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchTextField.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func dataSource(tableView: UITableView) -> SearchDataSource {
        return SearchDataSource(tableView: tableView) { /*[weak self]*/ tableView, indexPath, item in
            switch item {
            case .bookInfo(let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as? SearchCell
                cell?.titleLbl.text = model.title
                cell?.subTitleLbl.text = model.subTitle
                cell?.priceLbl.text = model.price
                cell?.iconImageView.loadImage(from: model.imageURL)
                return cell
            case .footer:
                let cell = tableView.dequeueReusableCell(withIdentifier: FooterView.identifier, for: indexPath) as? FooterView
                cell?.progressView.startAnimating()
                self.searchViewModel.input.findMore()
                return cell
            }
        }
    }
    
    func setSnapshot(_ snapshot: SearchSnapshot) {
        dataSources.apply(snapshot, animatingDifferences: false)
    }
}

extension SearchViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text?.trim() else { return true }
        searchViewModel.input.findSearch(text: text)
        return true
    }
}

extension SearchViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = dataSources.itemIdentifier(for: indexPath) else { return }
        if case .bookInfo(let model) = item {
            let detailVC = DetailViewController(bookID: model.id)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
