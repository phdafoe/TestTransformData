//  MoviesInteractor.swift
//  Architecture VIP+UI
//
// This source file is open source project in iOS
// See README.md for more information

import Foundation

// Input del Interactor
protocol MoviesInteractorInputProtocol: BaseInteractorInputProtocol {
    func requestData()
}

// Output Provider
protocol MoviesProviderOutputProtocol: BaseProviderOutputProtocol{
    func setInformationFavourites(completion: Result<MoviesEntity, NetworkError>)
}

final class MoviesInteractor: BaseInteractor {

    // MARK: - DI
    weak var presenter: MoviesInteractorOutputProtocol? {
        super.baseViewModel as? MoviesInteractorOutputProtocol
    }
    
    // MARK: - DI
    var provider: MoviesProviderInputProtocol? {
        super.baseProvider as? MoviesProviderInputProtocol
    }
    
}

// Input del Interactor
extension MoviesInteractor: MoviesInteractorInputProtocol {
    func requestData() {
        self.provider?.fetchDataFromWeb { (resultMovie) in
            //self.presenter?.getDataArray(arrayResult: resultMovie.feed?.results)
        } failure: { (error) in
            print(error)
        }

    }
}

// Output Provider
extension MoviesInteractor: MoviesProviderOutputProtocol {
    func setInformationFavourites(completion: Result<MoviesEntity, NetworkError>) {
        switch completion{
        case .success(let data):
            //self.transformDataDetailMovieServerModelToDetailMovieTVModelView(data: data)
            self.presenter?.setInformationFavourites(data: self.dataSource )
        case .failure(let error):
            debugPrint(error)
        }
    }
}


