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
    @IBOutlet private var lineViewToTableViewDistanceConstraint: NSLayoutConstraint!
    @IBOutlet private var lineViewHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    private(set) var selectedSubitemRow: Int?
    private let cellReuseIdentifier = "internalCell"
    private var viewModel: ItemListCellViewModel?
    private var lineViewHeight: CGFloat = 0
    private var lineViewToTableView: CGFloat = 0
    private var tableViewBottom: CGFloat = 0
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nibName = String(describing: ExtraOptionCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        tableView.delegate = self
        tableViewBottom = tableViewBottomConstraint.constant
        tableViewBottomConstraint.constant = 0
        
        lineViewHeight = lineViewHeightConstraint.constant
        lineViewHeightConstraint.constant = 0
        
        lineViewToTableView = lineViewToTableViewDistanceConstraint.constant
        lineViewToTableViewDistanceConstraint.constant = 0
        
        selectionStyle = .none
        styleSubviews()
    }

    // MARK: - Public methods
    
    func set(_ viewModel: ItemListCellViewModel) {
        self.viewModel = viewModel
        itemImageView.image = .init(named: viewModel.mainItem.logoName)
        itemNameLabel.text = viewModel.mainItem.title
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
            self.lineViewToTableViewDistanceConstraint.constant = shouldExpand ? self.lineViewToTableView : 0
            self.lineViewHeightConstraint.constant = shouldExpand ? self.lineViewHeight : 0
            self.layoutIfNeeded()
        })
    }
}

// MARK: - UITableViewDataSource

extension ItemListCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.subitems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basicCell = UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? ExtraOptionCell,
            let subitems = viewModel?.subitems
        else { return basicCell }
        
        
        cell.optionLabel.text = subitems[indexPath.row].title
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ItemListCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if tableView.indexPathForSelectedRow == indexPath {
            tableView.deselectRow(at: indexPath, animated: false)
            selectedSubitemRow = nil
            let cell = tableView.cellForRow(at: indexPath) as? ExtraOptionCell
            cell?.uncheck()
            return nil
        }

        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSubitemRow = indexPath.row
        let cell = tableView.cellForRow(at: indexPath) as? ExtraOptionCell
        cell?.check()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedSubitemRow = nil
        let cell = tableView.cellForRow(at: indexPath) as? ExtraOptionCell
        cell?.uncheck()
    }
}
