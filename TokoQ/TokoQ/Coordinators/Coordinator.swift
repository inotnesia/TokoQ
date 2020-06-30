//
//  Coordinator.swift
//  TokoQ
//
//  Created by Tony Hadisiswanto on 25/06/20.
//  Copyright © 2020 inotnesia. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
    func stop()
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?)
}

extension Coordinator {
    func navigate(from source: UIViewController, to destination: UIViewController, with identifier: String?, and sender: AnyObject?) {
    }
    
    func stop() {
    }
}

protocol DefaultCoordinator: Coordinator {
    associatedtype VC: UIViewController
    var viewController: VC? { get set }
    
    var animated: Bool { get }
    var delegate: CoordinatorDelegate? { get }
}

protocol PushCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController { get }
}

protocol ModalCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController { get }
    var destinationNavigationController: UINavigationController? { get }
}

protocol PushModalCoordinator: DefaultCoordinator {
    var configuration: ((VC) -> ())? { get }
    var navigationController: UINavigationController? { get }
    var destinationNavigationController: UINavigationController? { get }
}

extension DefaultCoordinator {
    var animated: Bool {
        get {
            return true
        }
    }
    
    weak var delegate: CoordinatorDelegate? {
        get {
            return nil
        }
    }
}

extension PushCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }
        
        configuration?(viewController)
        viewController.setCoordinator(self)
        navigationController.pushViewController(viewController, animated: animated)
    }
    
    func stop() {
        delegate?.willStop(in: self)
        navigationController.popViewController(animated: animated)
        delegate?.didStop(in: self)
    }
}

extension ModalCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }
        
        configuration?(viewController)
        viewController.setCoordinator(self)
        
        if let destinationNavigationController = destinationNavigationController {
            navigationController.present(destinationNavigationController, animated: animated, completion: nil)
        } else {
            navigationController.present(viewController, animated: animated, completion: nil)
        }
    }
    
    func stop() {
        delegate?.willStop(in: self)
        viewController?.dismiss(animated: true, completion: {
            self.delegate?.didStop(in: self)
        })
    }
}

extension PushModalCoordinator where VC: UIViewController, VC: Coordinated {
    func start() {
        guard let viewController = viewController else {
            return
        }
        
        configuration?(viewController)
        viewController.setCoordinator(self)
        
        if let destinationNavigationController = destinationNavigationController {
            navigationController?.present(destinationNavigationController, animated: animated, completion: nil)
        } else {
            navigationController?.pushViewController(viewController, animated: animated)
        }
    }
    
    func stop() {
        delegate?.willStop(in: self)
        
        if let _ = destinationNavigationController {
            viewController?.dismiss(animated: true, completion: {
                self.delegate?.didStop(in: self)
            })
        } else {
            let _ = navigationController?.popViewController(animated: animated)
            delegate?.didStop(in: self)
        }
    }
}

protocol CoordinatorDelegate: class {
    func willStop(in coordinator: Coordinator)
    func didStop(in coordinator: Coordinator)
}

protocol Coordinated {
    func getCoordinator() -> Coordinator?
    func setCoordinator(_ coordinator: Coordinator)
}

class CoordinatorSegue: UIStoryboardSegue {
    open var sender: AnyObject!
    
    override func perform() {
        guard let source = self.source as? Coordinated else {
            return
        }
        
        source.getCoordinator()?.navigate(from: self.source, to: destination, with: identifier, and: sender)
    }
}
