//
//  Protocols.swift
//  April
//
//  Created by Mehmed Kadir on 8.07.19.
//  Copyright © 2019 Mehmed Kadir. All rights reserved.
//

import Foundation
import  UIKit


//MARK: - Reuse identifier
protocol ReusableView: class {}
extension ReusableView where Self: UIView  {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}


//MARK: - Nib Loader
protocol NIbLoadableView: class {}
extension NIbLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}


// MARK: - Generic UITableView registeing and dequeing cells with identifiers
extension UITableViewCell: ReusableView, NIbLoadableView {}
extension UITableView {
    
    func register<T: UITableViewCell>(_: T.Type){
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeReusableCell<T: UITableViewCell>(forindexPath indexPath: IndexPath)->T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}


// MARK: - Generic UICollectionView registering and dequeing cells with identifiers
extension UICollectionViewCell: ReusableView, NIbLoadableView {}
extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type){
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeReusableCell<T: UICollectionViewCell>(cellForItemAt indexPath: IndexPath)->T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
}


protocol ViewControllerLoader: class {}
extension ViewControllerLoader where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: ViewControllerLoader {}


extension UIStoryboard {
    func instantiateViewController<T:UIViewController>(_: T.Type) -> T {
        guard let vc = instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("Could not initiate controller with identifier: \(T.identifier)")
        }
        return vc
    }
}


/**
 inject dataSource into viewcontroller
 view controller must confort to this protocol, and implement the both functions
 result: private dataSource for the vc
 */
protocol Injectable {
    associatedtype Model
    
    func inject(model:Model)
    func assertDependencies()
}


// TODO: Decide whether to use this protocol or AlertControl 
protocol AlertPresentable {}
extension AlertPresentable {
    func showAlertViewControllerWithTitle(_ title: String? = nil,
                                          message: String? = nil,
                                          actions:[UIAlertAction]? =
        [UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)],
                                          preferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actions = actions {
            for action in actions {
                alert.addAction(action)
            }
        }
        if let topController = UIApplication.topViewController() {
            topController.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIApplication {
    
    class func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}

struct StoryboardName {
    static let main = "Main"
}

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: StoryboardName.main, bundle: .main)
    }
    
}
