//
//  AssembleBuilder..swift
//  MVPTest
//
//  Created by Bezdenezhnykh Sergey on 16.06.2021.
//

import UIKit

final class AssembleBuilder {
    
    func startRootVC() -> UINavigationController {
        let mainViewController = createMainModule()
        let navigationController = UINavigationController.create(root: mainViewController)
        navigationController.view.backgroundColor = .primary
        return navigationController
    }
    
    private func createMainModule() -> UIViewController {
        let view = MainViewController()
        let netService = APIService()
        let presenter = MainPresenter(view: view, netService: netService)
        view.presenter = presenter
        return view
    }
    
}
