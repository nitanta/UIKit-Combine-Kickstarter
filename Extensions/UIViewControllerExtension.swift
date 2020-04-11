import Foundation
import UIKit

protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitializable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initialize(_ storyboard: Global.Storyboard) -> Self {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self //swiftlint:disable:this force_cast
    }
}
extension UIViewController: StoryboardInitializable {}

extension UIViewController{
    func showAlert(title:String?, message: String?){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = Color.primary
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    public func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        child.didMove(toParent: self)
    }

    public func remove(_ child: UIViewController) {
        guard child.parent != nil else {
            return
        }

        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
}
