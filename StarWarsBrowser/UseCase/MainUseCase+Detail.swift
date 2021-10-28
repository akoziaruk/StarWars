//
//  MainUseCase+Detail.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/20/21.
//

import Foundation
import Combine

extension MainUseCase {
//    func loadFilms(with url: URL) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never>  {
//        networkService
//            .load(Resource<DetailCollection<Film>>(url: url))
//            .map { .success($0.result) }
//            .catch { error -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> in .just(.failure(error)) }
//            .subscribe(on: Scheduler.backgroundWorkScheduler)
//            .receive(on: Scheduler.mainScheduler)
//            .eraseToAnyPublisher()
//    }
//
//    func loadPeople(with url: URL, page: Int) -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> {
//        return networkService
//            .load(Resource<DetailCollection<People>>(url: url, parameters: ["page" : page]))
//            .map { .success($0.result) }
//            .catch { error -> AnyPublisher<Result<DetailCollectionResult, Error>, Never> in .just(.failure(error)) }
//            .subscribe(on: Scheduler.backgroundWorkScheduler)
//            .receive(on: Scheduler.mainScheduler)
//            .eraseToAnyPublisher()
//    }
    
//    func loadPlanets(with url: URL) -> AnyPublisher<Result<DetailCollection, Error>, Never> {
//        return networkService
//            .load(Resource<PlanetCollection>.platents(with: url))
//            .map { .success($0) }
//            .catch { error -> AnyPublisher<Result<DetailCollection, Error>, Never> in .just(.failure(error)) }
//            .subscribe(on: Scheduler.backgroundWorkScheduler)
//            .receive(on: Scheduler.mainScheduler)
//            .eraseToAnyPublisher()
//    }
    
}
