//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ItemListCell: UITableViewCell {
    // MARK: - Outlets
    
    @IBOutlet private var backingView: UIView!
    @IBOutlet private var itemImageView: UIImageView!
    @IBOutlet private var itemNameLabel: UILabel!
    @IBOutlet private var tableView: UITableView!
    
    @IBOutlet private var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var tableViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var subitems = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let cellReuseIdentifier = "internalCell"
    private var tableViewBottom: CGFloat = 0
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.dataSource = self
        tableViewBottom = tableViewBottomConstraint.constant
        tableViewBottomConstraint.constant = 0
        selectionStyle = .none
        styleSubviews()
    }

    // MARK: - Public methods

    func set(_ viewModel: ItemViewModel) {
        itemImageView.image = .init(named: viewModel.logoName)
        itemNameLabel.text = viewModel.title
    }
    
    func expandSubitems() {
        toggleSubitems(shouldExpand: true)
    }
    
    func collapseSubitems() {
        toggleSubitems(shouldExpand: false)
    }
    
    // MARK: - Private methods
    
    private func styleSubviews() {
        // Round corners
        backingView.backgroundColor = .init(red: 174 / 255, green: 215 / 255, blue: 160 / 255, alpha: 1)
        backingView.layer.cornerRadius = 4
        
        // Shadow
        backingView.layer.masksToBounds = false
        backingView.layer.shadowColor = UIColor.black.cgColor
        backingView.layer.shadowOpacity = 0.15
        backingView.layer.shadowOffset = .init(width: 0, height: 1)
        backingView.layer.shadowRadius = 2
        backingView.layer.shouldRasterize = true
        backingView.layer.rasterizationScale = UIScreen.main.scale
        
        itemNameLabel.font = .init(name: "AvenirNext-DemiBold", size: 14)
        itemNameLabel.textColor = .white
    }
    
    private func toggleSubitems(shouldExpand: Bool) {
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: {
            self.tableViewHeightConstraint.constant = shouldExpand ? self.tableView.contentSize.height : 0
            self.tableViewBottomConstraint.constant = shouldExpand ? self.tableViewBottom : 0
            self.layoutIfNeeded()
        })
    }
}

// MARK: - UITableViewDataSource

extension ItemListCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subitems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        cell.textLabel?.text = subitems[indexPath.row]
        return cell
    }
}
