//
//  OptionSelectViewController.swift
//  aaaaaaaaaa
//
//  Created by ezbuy on 2019/4/24.
//  Copyright © 2019 ezbuy. All rights reserved.
//

import UIKit

enum OptionType {
    case amount
    case loanReason
}

protocol OptionSelectViewControllerDelegate: class {
    func optionSelectViewControllerDidSelect(info: [String], type: OptionType?)
}

class OptionSelectViewController: UIViewController {
    
    var optionType: OptionType?
    
    var listInfo: [String]? = ["aaaaaaqq", "bbbbbbbqq"]
    
    weak var delegate: OptionSelectViewControllerDelegate?
    
    var selectedInfo: [String] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var tableViewToConfirmButtonCons: NSLayoutConstraint!
    @IBOutlet weak var tableViewToSuperViewCons: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        tableView.rowHeight = 44
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateView()
    }
    
    func updateView() {
        
        switch optionType {
        case .amount?:
            self.confirmButton.isHidden = true
            self.confirmButton.isUserInteractionEnabled = false
            self.tableViewToSuperViewCons.priority = UILayoutPriority(rawValue: 999)
            self.tableViewToConfirmButtonCons.priority = UILayoutPriority(rawValue: 1)
            self.tableView.allowsMultipleSelection = false
        case .loanReason?:
            self.confirmButton.isHidden = false
            self.confirmButton.isUserInteractionEnabled = true
            self.tableViewToSuperViewCons.priority = UILayoutPriority(rawValue: 1)
            self.tableViewToConfirmButtonCons.priority = UILayoutPriority(rawValue: 999)
            self.tableView.allowsMultipleSelection = true
        default:
            break
        }
        
        tableView.reloadData()
    }

    @IBAction func confirmButtonDidTapped(_ sender: UIButton) {
        delegate?.optionSelectViewControllerDidSelect(info: selectedInfo, type: .loanReason)
        self.dismiss(animated: true, completion: nil)
    }
}

extension OptionSelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OptionSelectcCell", for: indexPath) as? OptionSelectcCell else { return UITableViewCell() }
        
        if let info  = listInfo?[indexPath.row] {
            cell.title = info
            cell.isSelected = selectedInfo.contains(info)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let info = listInfo?[indexPath.row] else { return }
        
        switch optionType {
        case .amount?:
            selectedInfo.removeAll()
            selectedInfo.append(info)
            delegate?.optionSelectViewControllerDidSelect(info: selectedInfo, type: .amount)
            self.dismiss(animated: true, completion: nil)
        case .loanReason?:
            selectedInfo.append(info)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let info = listInfo?[indexPath.row] else { return }
        
        selectedInfo.removeAll { (str) -> Bool in
            return str == info
        }
    }
    
}

class OptionSelectcCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var title: String? {
        didSet {
            updatecCell(with: self.title)
        }
    }
    
    func updatecCell(with title: String?) {
        titleLabel.text = title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        title = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton.isSelected = selected
    }
}
