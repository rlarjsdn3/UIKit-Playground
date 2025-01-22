//
//  CoordinatorFinishOutput.swift
//  FlowCoordinator
//
//  Created by 김건우 on 1/22/25.
//

import Foundation

protocol CoordinatorFinishOutput {
    
    /// 코디네이터의 첫 화면이 사라질 때 호출되는 클로저
    ///
    /// # Discussion
    /// 이 프로퍼티는 코디네이터의 첫 화면이 사라지기 전에 호출되는 클로저입니다.
    /// 코디네이터의 첫 화면에서 '뒤로가기'나 '닫기' 버튼을 클릭하면 **반드시** 이 클로저를 실행해
    /// 코디네이터를 정리해야 합니다. 클로저에는 다음 작업이 포함되어야 합니다:
    /// - 상위 코디네이터의 하위 코디네이터 배열에서 해당 코디네이터 제거 (`removeDependency(_:)` 메서드 사용)
    /// - 뒤로 이동 (`router` 사용)
    ///
    var finishFlow: (() -> Void)? { get set }
}
