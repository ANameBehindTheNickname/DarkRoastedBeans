//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TableContentView: UIView, UIContentView {
    @IBOutlet private var contentView: UIView!
    @IBOutlet private(set) var tableView: UITableView!
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(with: configuration)
            constraintSubviews()
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame:.zero)
        commonInit()
        constraintSubviews()
    }
    
    required init?(coder: NSCoder) {
        self.configuration = TableConfiguration(tableItemConfigs: [])
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let nibName = String(describing: TableContentView.self)
        Bundle.main.loadNibNamed(nibName, owner: self)
        addSubview(contentView)
        configureTableView()
        contentView.backgroundColor = .clear
        configure(with: configuration)
    }
    
    private func configureTableView() {
        tableView.register(NewItemListCell.self, forCellReuseIdentifier: "expandedCell")
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isScrollEnabled = false
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }
    
    private func configure(with configuration: UIContentConfiguration) {
        guard let config = configuration as? TableConfiguration else { return }
        
        tableView.delegate = config
        tableView.dataSource = config
        tableView.reloadData()
    }
    
    private func constraintSubviews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height)
        ])
    }
}
