//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ItemListVC: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet private weak var listTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properites
    
    var onViewDidLoad: (() -> Void)?
    var onDidSelectRow: ((Int) -> Void)?
    var onDidDeselectRow: ((Int) -> Void)?
    
    // MARK: - Private properites
    
    private let cellReuseIdentifier = "cell"
    private let listTitle: String
    private let itemViewModels: [ItemViewModel]
    
    // MARK: - Init
    
    init(listTitle: String, itemViewModels: [ItemViewModel]) {
        self.listTitle = listTitle
        self.itemViewModels = itemViewModels
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTitleLabel.text = listTitle
        listTitleLabel.font = .init(name: "AvenirNext-Medium", size: 24)
        let nib = UINib(nibName: String(describing: ItemListCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Brew with Lex"
        navigationItem.backBarButtonItem = .init(title: "", style: .plain, target: nil, action: nil)
        onViewDidLoad?()
    }
}

// MARK: - UITableViewDataSource

extension ItemListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ItemListCell
        let vm = itemViewModels[indexPath.row]
        
        cell?.set(vm)
        
        return cell ?? .init(style: .default, reuseIdentifier: nil)
    }
}

// MARK: - UITableViewDelegate

extension ItemListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onDidSelectRow?(indexPath.row)
        updateTableView()
        let cellRect = tableView.rectForRow(at: indexPath)
        if !tableView.bounds.contains(cellRect) {
            tableView.scrollToRow(at: indexPath, at: .none, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        onDidDeselectRow?(indexPath.row)
        updateTableView()
    }
    
    private func updateTableView() {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}
