//  MoviesModule.swift
//  Architecture VIP+UI
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation
import SwiftUI

// MARK: - module builder
final class MoviesCoordinator: BaseCoordinator {
    
    typealias ContentView = MoviesView
    typealias Presenter = MoviesPresenter
    typealias Interactor = MoviesInteractor
    typealias Provider = MoviesProvider
    
    static func navigation() -> NavigationView<ContentView> {
        NavigationView{
            self.build()
        }
    }
    
    static func build(dto: MoviesCoordinatorDTO? = nil) -> ContentView {
        let vip = BaseCoordinator.coordinator(viewModel: Presenter.self,
                                              interactor: Interactor.self,
                                              provider: Provider.self)
        let view = ContentView(viewModel: vip.viewModel)
        return view
    }
}

struct MoviesCoordinatorDTO {
    
}
