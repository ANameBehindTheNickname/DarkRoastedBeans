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
    
    var onDidSelectRow: (() -> Void)?
    
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource

extension ItemListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let vm = itemViewModels[indexPath.row]
        
        cell.imageView?.image = .init(named: vm.logoName)
        cell.textLabel?.text = vm.title
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ItemListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onDidSelectRow?()
    }
}
