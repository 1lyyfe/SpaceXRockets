//
//  Coordinator.swift
//  SpaceXRockets
//
//  Created by Haider Ashfaq on 19/10/2021.
//

import Foundation
import UIKit
import SafariServices

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
    func presentErrorMessage(_ message: String, onOkAction: AlertActionHandler?, presenter: UIViewController?)
    func presentInfoMessage(_ message: String, title: String?, isCancelIncluded: Bool, onOkAction: AlertActionHandler?)
    func presentWebContent(_ content: String, presenter: UIViewController?)
}

extension Coordinator {
    
    func presentErrorMessage(_ message: String, onOkAction: AlertActionHandler? = nil, presenter: UIViewController? = nil) {
        let alert = UIAlertController(title: "Deva Racing", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localised(), style: .default, handler: onOkAction)
        alert.addAction(ok)
        var presenter: UIViewController? = navigationController
        while let presented = presenter?.presentedViewController {
            presenter = presented
        }
        presenter?.present(alert, animated: true, completion: nil)
    }

    func presentInfoMessage(_ message: String, title: String? = nil, isCancelIncluded: Bool = false, onOkAction: AlertActionHandler? = nil) {
        let alert = UIAlertController(title: title ?? "Deva Racing", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK".localised(), style: .default, handler: onOkAction)
        alert.addAction(ok)
        if isCancelIncluded {
            let cancel = UIAlertAction(title: "CANCEL".localised(), style: .cancel, handler: nil)
            alert.addAction(cancel)
        }
        var presenter: UIViewController? = navigationController
        while let presented = presenter?.presentedViewController {
            presenter = presented
        }
        presenter?.present(alert, animated: true, completion: nil)
    }
    
    
    func presentWebContent(_ content: String, presenter: UIViewController? = nil) {
        guard let url = URL(string: content) else {return}
        let config = SFSafariViewController.Configuration()
        config.barCollapsingEnabled = true
        let safari = SFSafariViewController(url: url, configuration: config)
        safari.modalPresentationStyle = .overFullScreen
        safari.preferredBarTintColor = .blue
        safari.preferredControlTintColor = .blue
        guard let presenter = presenter else {
            navigationController?.visibleViewController?.present(safari, animated: true, completion: nil)
            return
        }
        presenter.present(safari, animated: true, completion: nil)
    }
}
