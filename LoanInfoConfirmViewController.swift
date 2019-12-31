//
//  LoanInfoConfirmViewController.swift
//  aaaaaaaaaa
//
//  Created by ezbuy on 2019/4/24.
//  Copyright © 2019 ezbuy. All rights reserved.
//

import UIKit

extension LoanInfoConfirmViewController {
    
    class func make() -> LoanInfoConfirmViewController? {
        let sb = UIStoryboard(name: "testbbbb", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoanInfoConfirmViewController") as? LoanInfoConfirmViewController
        
        return vc
    }
}

class LoanInfoConfirmViewController: UIViewController {

    @IBOutlet weak var amontLabel: UILabel!
    @IBOutlet weak var loanReasonLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "借款信息确认"
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ToOptionSelectVCAmount":
            let vc = segue.destination as? OptionSelectViewController
            vc?.optionType = .amount
//            vc?.listInfo = []
            vc?.transitioningDelegate = self
            vc?.modalPresentationStyle = .custom
            vc?.delegate = self
            
        case "ToOptionSelectVCReason":
            let vc = segue.destination as? OptionSelectViewController
            vc?.optionType = .loanReason
//            vc?.listInfo = []
            vc?.transitioningDelegate = self
            vc?.modalPresentationStyle = .custom
            vc?.delegate = self
            
        default:
            break
        }
    }
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        print("点击屏幕")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("点击屏幕2222222")
    }

}

extension LoanInfoConfirmViewController: OptionSelectViewControllerDelegate {
    
    func optionSelectViewControllerDidSelect(info: [String], type: OptionType?) {
        switch type {
        case .amount?:
            self.amontLabel.text = info.first
        case .loanReason?:
            self.loanReasonLabel.text = info.joined(separator: ",")
        default:
            break
        }
    }
}


extension LoanInfoConfirmViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        return InnerPresentationController(presentedViewController: presented, presenting: presenting).handleFrame({ (_, _) -> CGRect in
            
            let width = UIScreen.main.bounds.width * 0.75
            let height = UIScreen.main.bounds.height * 0.6
            let x = (UIScreen.main.bounds.width - width) * 0.5
            let y = (UIScreen.main.bounds.height - height) * 0.5
                return CGRect(x: x, y: y, width: width, height: height)
        })
    }
}
