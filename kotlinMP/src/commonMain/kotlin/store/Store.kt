package store

typealias Reducer <S, A> = (S, A) -> S
typealias StoreSubscriber <S> = (S) -> Unit