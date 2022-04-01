//
//  MainUseCaseType.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/31/21.
//

import Combine
import Foundation
import UIKit

protocol MainUseCaseType {
    func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never>
    func loadDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never>
    func loadImage(for detail: Detailable) -> AnyPublisher<UIImage?, Never>
}

final class MainUseCase: MainUseCaseType {
    
    private let dataService: DataProviderServiceType
    private let imageLoaderService: ImageLoaderServiceType
    
    init(dataService: DataProviderServiceType, imageLoaderService: ImageLoaderServiceType) {
        self.dataService = dataService
        self.imageLoaderService = imageLoaderService
    }
    
    public func loadCategories() -> AnyPublisher<Result<Categories, Error>, Never> {
        dataService
            .loadCategories() //.load(Resource<Categories>.categories())
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<Categories, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    public func loadDetails(url: URL, page: Int, category: Category.T) -> AnyPublisher<Result<[Detailable], Error>, Never> {
        switch category {
        case .film:
            return loadDetails(url: url, page: page, type: Film.self)
        case .people:
            return loadDetails(url: url, page: page, type: Сharacter.self)
        case .planet:
            return loadDetails(url: url, page: page, type: Planet.self)
        case .species:
            return loadDetails(url: url, page: page, type: Species.self)
        case .starship:
            return loadDetails(url: url, page: page, type: Starship.self)
        case .vehicle:
            return loadDetails(url: url, page: page, type: Vehicle.self)
        case .unknown:
            return .just(.failure(UseCaseError.unknownType))
        }
    }

    private func loadDetails<T: Detailable>(url: URL, page: Int, type: T.Type) -> AnyPublisher<Result<[Detailable], Error>, Never> {
        dataService
            .load(Resource<Details<T>>.details(for: url, page: page, type: type))
            .map { .success($0.items) }
            .catch { error -> AnyPublisher<Result<[Detailable], Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    public func loadImage(for detail: Detailable) -> AnyPublisher<UIImage?, Never> {
        return Deferred { return Just(detail.bucketImagePath) }
            .flatMap({ [unowned self] path  -> AnyPublisher<UIImage?, Never> in
                return self.imageLoaderService.loadImage(for: path)
            })
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler) 
            .share()
            .eraseToAnyPublisher()
    }
}
