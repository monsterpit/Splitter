//
//  MainTabBarController.swift
//  Splitter
//
//  Created by Vikas Salian on 02/11/24.
//

import UIKit

final class MainTabBarController: BaseTabBarController {
    private let viewModel: MainViewModelProtocol
    private var upperLineView: UIView?
    private let upperLineViewSpacing: CGFloat = 0
    private let upperLineViewHeight: CGFloat = 3

    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        delegate = self
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonTitle = ""
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didSelect(viewController _: UIViewController) {
        moveTabBarIndicatorView(to: selectedIndex)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let tabView = tabView(at: selectedIndex) {
            DispatchQueue.main.async { [weak self] in
                self?.updateUpperLineViewFrame(for: tabView)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        upperLineView = UIView(frame: .zero)
        upperLineView?.backgroundColor = .red
        if let upperLineView {
            tabBar.addSubview(upperLineView)
        }
    }

    private func moveTabBarIndicatorView(to index: Int) {
        guard let tabView = tabView(at: index) else {
            return
        }
        UIView.animate(withDuration: 0.1) {
            self.updateUpperLineViewFrame(for: tabView)
        }
    }

    private func updateUpperLineViewFrame(for tabView: UIView) {
        upperLineView?.frame = CGRect(x: tabView.frame.minX + upperLineViewSpacing,
                                      y: 0,
                                      width: tabView.frame.size.width - upperLineViewSpacing * 2,
                                      height: upperLineViewHeight)
    }

    private func tabView(at index: Int) -> UIView? {
        tabBar.items?[safe: index]?.value(forKey: "view") as? UIView
    }
}
