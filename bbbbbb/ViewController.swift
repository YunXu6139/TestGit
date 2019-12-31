//
//  ViewController.swift
//  bbbbbb
//
//  Created by ezbuy on 2019/4/24.
//  Copyright © 2019 xuyun. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var xxxButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.title = "我是傻逼"
        xxxButton.layer.borderColor = UIColor.white.cgColor
        xxxButton.layer.borderWidth = 2
        xxxButton.layer.cornerRadius = 45
        xxxButton.layer.masksToBounds = true
        
        let str1 = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
        let font = UIFont.systemFont(ofSize: 16)
        print(str1.width(font: font))
        print(str1.width(CGFloat.greatestFiniteMagnitude, font: font))
        print(str1.width(100, font: font))
        print(str1.height(0, font: font))
        print(str1.height(50, font: font))
        
        print(str1.size(CGSize.zero, font: font))
        print(str1.size(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), font: font))
        print(str1.size(CGSize(width: 50, height: CGFloat.greatestFiniteMagnitude), font: font))
        
        print(str1.caculateLabelWidthWithFontSize(16))
        print(str1.caculateLabelHeight(withFontSize: 16, width: CGFloat.greatestFiniteMagnitude))
    }

    @IBAction func cilisbtn(_ sender: UIButton) {
        print("dian ji")
//        if let vc = LoanInfoConfirmViewController.make() {
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        let item = EZMenuItem(title: "Translate", image: nil) { (item) in
            
        }

        let controller = EZMenuController.shared
        controller.items = [item]
        controller.setTargetRect(sender.bounds, in: sender)
        controller.menuVisibleAction = { isVisable in
        }
        
        if !controller.isMenuVisible {
            controller.setMenuVisible(true, in: self)
        }
    }
    
}

extension String {
    func caculateLabelWidthWithFontSize(_ fontSize: Int) -> CGRect {
        let stringOC: NSString = self as NSString
        if !stringOC.isEqual(to: "") {
            return stringOC.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 40), options: [], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(fontSize))], context: nil)
        } else {
            return CGRect.zero
        }
    }
    
    func caculateLabelHeight(withFontSize fontSize: Int, width: CGFloat) -> CGRect {
        let stringOC: NSString = self as NSString
        if !stringOC.isEqual(to: "") {
            return stringOC.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(fontSize))], context: nil)
        } else {
            return CGRect.zero
        }
    }
    
    public func height(_ constraintWidth: CGFloat, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {
        
        return self.size(CGSize(width: constraintWidth, height: CGFloat.infinity), font: font).height
    }
    
    public func width(_ constraintHeight: CGFloat = 40, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGFloat {
        
        return self.size(CGSize(width: CGFloat.infinity, height: constraintHeight), font: font).width
    }
    
    public func size(_ constraintSize: CGSize, font: UIFont = UIFont.systemFont(ofSize: 14)) -> CGSize {
        
        return self.size(constraintSize, attributes: [NSAttributedString.Key.font: font])
    }
    
    public func size(_ constraintSize: CGSize, attributes: [NSAttributedString.Key : Any]) -> CGSize {
        
        let attr = NSAttributedString(string: self, attributes: attributes)
        
        let rect = attr.boundingRect(with: constraintSize, options: [.usesFontLeading, .usesLineFragmentOrigin], context: nil)
        
        return rect.size
    }
}


class PlayerViewController: AVPlayerViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4") {
            let player = AVPlayer(url: url)
            self.player = player
            self.player?.play()
        }
        
    }
}

class GradientShadowButton: UIButton {
        
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
    
    func configureUI() {
        addCornerRadius()
        addShadow()
        addGradientColor()
    }
    
    func addCornerRadius() {
//        self.layer.cornerRadius = 4.0
//        self.layer.masksToBounds = true
    }
    
    func addShadow() {
        self.layer.shadowColor = Colors.brandingColor.cgColor
        self.layer.shadowRadius = 16
        self.layer.shadowOpacity = 0.2
    }
    
    func addGradientColor() {
        let graidnetLayer = CAGradientLayer()
        let color1 = UIColor(0x2b77f8)
        let color2 = UIColor(0x4388ff)
        graidnetLayer.colors = [color1, color2]
        graidnetLayer.startPoint = CGPoint(x: 0, y: 1)
        graidnetLayer.endPoint = CGPoint(x: 1, y: 0)
        graidnetLayer.frame = self.bounds
        self.layer.insertSublayer(graidnetLayer, at: 0)
    }
}

//
//  EZMenuController.swift
//  MenuItemKit-Swift
//
//  Created by wangding on 2019/6/30.
//  Copyright © 2019 lazyapps. All rights reserved.
//

public class EZMenuItem: NSObject {

    public var title: String?
    public var image: UIImage?
    public var action: ((EZMenuItem) -> Void)?
    public init(title: String?, image: UIImage?, action: ((EZMenuItem) -> Void)?) {
        super.init()
        self.title = title
        self.image = image
        self.action = action
    }
}

extension EZMenuItem {

    static let EZItemHeight: CGFloat = 30

    func menuItemSize() -> CGSize {
        let height: CGFloat = EZMenuItem.EZItemHeight

        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 9)
        button.setTitle(self.title, for: UIControl.State())
        button.setImage(self.image, for: UIControl.State())

        let size = button.systemLayoutSizeFitting(CGSize(width: CGFloat.infinity, height: height), withHorizontalFittingPriority: .defaultLow, verticalFittingPriority: .required)

        return CGSize(width: size.width, height: height)
    }
}

public class EZMenuController: UIViewController {


    public static let shared: EZMenuController = {
        
        
        let vc = UIStoryboard(name: "Main", bundle: nil ).instantiateViewController(withIdentifier: "EZMenuController") as! EZMenuController
        return vc
    }()

//    @IBOutlet weak var collectionView: UICollectionView!

    public var items: [EZMenuItem]?

    public fileprivate(set) var isMenuVisible: Bool = false
    
    public var menuVisibleAction: ((Bool) -> Void)?

    @available(*, unavailable)
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
//        self.collectionView.dataSource = self
//        self.collectionView.delegate = self
//
//        self.collectionView.reloadData()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.menuVisibleAction?(true)
        if self.isViewLoaded {
//            self.collectionView.reloadData()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.menuVisibleAction?(false)
    }

    fileprivate var _targetRect: CGRect = .zero
    fileprivate var _targetView: UIView?

    override public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = self.items?.reduce(0, { (result, item) -> CGFloat in
            return result + item.menuItemSize().width
        }) ?? 0
        self.preferredContentSize = CGSize(width: width, height: EZMenuItem.EZItemHeight)
    }
}

extension EZMenuController {

    public func setTargetRect(_ frame: CGRect, in view: UIView?) {
        self._targetRect = frame
        self._targetView = view
    }

    public func setMenuVisible(_ visible: Bool, in viewController: UIViewController?) {
        let shared = EZMenuController.shared
        shared.modalPresentationStyle = .popover
        shared.popoverPresentationController?.sourceRect = self._targetRect
        shared.popoverPresentationController?.sourceView = self._targetView
        shared.popoverPresentationController?.permittedArrowDirections = [.up, .down]
        shared.popoverPresentationController?.delegate = self
//        shared.popoverPresentationController?.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        EZMenuController.shared.isMenuVisible = visible
        viewController?.present(shared, animated: false, completion: {
//            self.collectionView.reloadData()
            
            let width = self.items?.reduce(0, { (result, item) -> CGFloat in
                return result + item.menuItemSize().width
            }) ?? 0
            shared.preferredContentSize = CGSize(width: width, height: EZMenuItem.EZItemHeight)
        })
    }
}

extension EZMenuController: UIPopoverPresentationControllerDelegate {

    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    public func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        EZMenuController.shared.isMenuVisible = false
    }
}

extension EZMenuController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = self.items?[indexPath.row] else {
            return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EZMenuItemCollectionCell", for: indexPath)
        let button = cell.viewWithTag(101) as? UIButton
        button?.setTitle(item.title, for: UIControl.State())
        button?.setImage(item.image, for: UIControl.State())
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        guard let item = self.items?[indexPath.row] else {
            return
        }
        self.dismiss(animated: false) {
            EZMenuController.shared.isMenuVisible = false
            item.action?(item)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = self.items?[indexPath.row] else {
            return .zero
        }
        return item.menuItemSize()
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.005
    }
}
