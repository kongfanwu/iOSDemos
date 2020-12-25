//
//  FWObservable.swift
//  RxSwiftDemo
//
//  Created by kfw on 2020/12/15.
// 可监听序列

import Foundation
import RxSwift
import RxCocoa

class FWObservable {
    init() {
        
       
        

    }
    // Signal Signal 和 Driver 相似，唯一的区别是，Driver 会对新观察者回放（重新发送）上一个元素，而 Signal 不会对新观察者回放上一个元素。
    // 一般情况下状态序列我们会选用 Driver 这个类型，事件序列我们会选用 Signal 这个类型。
    func test6() {
        let button = UIButton()
        let event: Signal<Void> = button.rx.tap.asSignal()
        _ = event.emit { (a) in
            print("observer1")
        } onCompleted: {
            print("onCompleted1")
        } onDisposed: {
            print("onDisposed1")
        }
    }
    
    /*
     Driver（司机？） 是一个精心准备的特征序列。它主要是为了简化 UI 层的代码。不过如果你遇到的序列具有以下特征，你也可以使用它：
     不会产生 error 事件
     一定在 MainScheduler 监听（主线程监听）
     共享附加作用
     */
    func test5() {
        /*
        let results = query.rx.text.asDriver()        // 将普通序列转换为 Driver
            .throttle(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest { query in
                fetchAutoCompleteItems(query)
                    .asDriver(onErrorJustReturn: [])  // 仅仅提供发生错误时的备选返回值
            }

        results
            .map { "\($0.count)" }
            .drive(resultCount.rx.text)               // 这里改用 `drive` 而不是 `bindTo`
            .disposed(by: disposeBag)                 // 这样可以确保必备条件都已经满足了

        results
            .drive(resultsTableView.rx.items(cellIdentifier: "Cell")) {
              (_, result, cell) in
                cell.textLabel?.text = "\(result)"
            }
            .disposed(by: disposeBag)
         */
    }
    
    // Maybe 是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。如果你遇到那种可能需要发出一个元素，又可能不需要发出时，就可以使用 Maybe。
    func test4() {
        func generateString() -> Maybe<String> {
            return Maybe<String>.create { maybe in
                maybe(.success("RxSwift"))
                // OR
                maybe(.completed)
                // OR
                maybe(.error(fatalError("error")))
                return Disposables.create {}
            }
        }
    }
    
    // Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
    func test3() {
        func cacheLocally() -> Completable {
            return Completable.create { completable in
              let success = true
               guard success else {
                   completable(.error(fatalError("error")))
                   return Disposables.create {}
               }
               completable(.completed)
               return Disposables.create {}
            }
        }
        cacheLocally().subscribe {
        } onError: { (error) in
        }
    }
    
    // Single 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能发出一个元素，要么产生一个 error 事件。
    func test2() {
        func getRepo(_ repo: String) -> Single<[String: Any]> {
            return Single<[String: Any]>.create { single in
                //                single(.error(error))
                single(.success(["key" : "value"]))
                return Disposables.create {}
            }
        }
        getRepo("ReactiveX/RxSwift").subscribe { (json) in
        } onError: { (error) in
        }
    }
    
    // Observable
    func test1() {
        // 创建一个序列
        let numbers: Observable<Int> = Observable.create { (observer) -> Disposable in
            observer.onNext(1)
            observer.onNext(2)
            observer.onCompleted()
            return Disposables.create()
        }
        // 订阅序列
        _ = numbers.subscribe { (value) in
            print(value)
        } onError: { (errow) in
            print(errow)
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("Disposed")
        }
    }
}
