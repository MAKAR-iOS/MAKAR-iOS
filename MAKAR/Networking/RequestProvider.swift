//
//  RequestProvider.swift
//  MAKAR
//
//  Created by 박지윤 on 2023/12/20.
//

import Moya

typealias ExampleProvider = RequestProvider<ExampleAPI>

final class RequestProvider<Target: TargetType>: MoyaProvider<Target> {

    // MARK: Initializer
    init(session: Session) {
        super.init(session: session, plugins: [])
    }
}

