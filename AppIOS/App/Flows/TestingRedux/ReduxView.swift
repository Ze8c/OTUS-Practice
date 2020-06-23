//
//  ReduxView.swift
//  OTUS-Practice
//
//  Created by Максим Сытый on 23.06.2020.
//  Copyright © 2020 Mak. All rights reserved.
//

import Combine
import SwiftUI

final class Store<State, Action>: ObservableObject {
    
    typealias Reducer = (State, Action) -> State
    
    private let reducer: Reducer
    
    @Published var state: State
    
    init(initialState: State, reducer: @escaping Reducer) {
        state = initialState
        self.reducer = reducer
    }
    
    func dispatch(action: Action) -> () -> Void {
        { [weak self] in
            guard let self = self else { return }
            self.state = self.reducer(self.state, action)
        }
    }
}

enum ActionReduxView {
    case increment
    case decrement
}

struct ReduxView: View {
    
    @EnvironmentObject var store: Store<Int, ActionReduxView>
    
    var body: some View {
        VStack {
            Color.green.hueRotation(Angle(radians: Double(store.state)))
                .clipShape(Circle())
                .frame(height: 200)
                .modifier(ScoreModifier(animatableData: CGFloat(store.state)))
            HStack(spacing: 100) {
                Button(action: store.dispatch(action: .increment)) {
                    Image(systemName: "plus.circle.fill")
                        .scaleEffect(3)
                        .foregroundColor(.green)
                }
                Button(action: store.dispatch(action: .decrement)) {
                    Image(systemName: "minus.circle.fill")
                        .scaleEffect(3)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct ReduxView_Previews: PreviewProvider {
    static var previews: some View {
        ReduxView()
    }
}
