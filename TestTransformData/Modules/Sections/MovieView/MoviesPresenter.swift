//  MoviesPresenter.swift
//  Architecture VIP+UI
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation

// Output del Interactor
protocol MoviesInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func getDataArray(arrayResult: [ResultITunes]?)
}

final class MoviesPresenter: BaseViewModel, ObservableObject {
    
    // MARK: - DI
    var interactor: MoviesInteractorInputProtocol?{
        super.baseInteractor as? MoviesInteractorInputProtocol
    }

    @Published var arrayMovies: [ResultITunes] = []
        
    func fetchData(){
        self.interactor?.requestData()
    }
    
}

// Output del Interactor
extension MoviesPresenter: MoviesInteractorOutputProtocol{
    func getDataArray(arrayResult: [ResultITunes]?) {
        self.arrayMovies.removeAll()
        self.arrayMovies = arrayResult ?? []
    }
}
