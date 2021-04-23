//
//  PresenterInterface.swift
//  MathSolver
//
//  Created by Mehmet Kerem Keskin on 16.12.2020.
//  Copyright © 2020 MathSolver. All rights reserved.
//

import Foundation

public protocol PresenterInterface: class {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewWillEnterForeground()
    func viewDidLayoutSubviews()
}

public extension PresenterInterface {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
    func viewWillDisappear() {}
    func viewDidDisappear() {}
    func viewWillEnterForeground() {}
    func viewDidLayoutSubviews() {}
}
