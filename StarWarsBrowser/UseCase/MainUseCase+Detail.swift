//
//  MainUseCase+Detail.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/20/21.
//

import Foundation
import Combine

extension MainUseCase {
    func loadFilms(with url: URL) -> AnyPublisher<Result<DetailCollection, Error>, Never>  {
        return networkService
            .load(Resource<FilmCollection>.films(with: url))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<DetailCollection, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func loadPeople(with url: URL) -> AnyPublisher<Result<DetailCollection, Error>, Never> {
        networkService
            .load(Resource<People>.people(with: url))
            .map { .success($0) }
            .catch { error -> AnyPublisher<Result<DetailCollection, Error>, Never> in .just(.failure(error)) }
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }

}
