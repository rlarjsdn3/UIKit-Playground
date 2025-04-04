# UIKit Demos

UIKit의 다양한 기능과 기술을 실험하고 학습하기 위한 자잘한 데모 프로젝트 모음집입니다.
각 프로젝트는 특정 주제나 기능을 중심으로 구현되었습니다. 프로젝트 정보는 순서대로 서술되어 있으며, 주요 내용과 특징은 다음과 같습니다:


* **[PlaceBook](/01-PlaceBook/PlaceBook)** : 이 프로젝트는 `UIViewControllerAnimatedTransitioning`과 `UIViewControllerTransitioningDelegate`를 활용하여 _커스텀 전환 애니메이션(Custom Transition)_ 을 구현한 예제입니다. 컬렉션 뷰의 특정 이미지를 클릭하면, 상세 화면으로 전환될 때 이미지가 부드럽게 확대되며 커스텀 트랜지션 애니메이션이 실행됩니다.

<details>
<summary>자세히 보기</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
| GIF |
| :--: |
| ![Simulator Screen Recording - iPhone 16 Pro - 2025-01-14 at 22 43 27](https://github.com/user-attachments/assets/b4a2c312-d5b8-4c55-8a37-f1be1733b346) |

</details>


* **[FlowCoordinator](/02-FlowCoordinator/FlowCoordinator)** : 이 프로젝트는 `FlowCoordinator`를 활용하여 화면 전환을 구현한 예제입니다. `FlowCoordinator`는 뷰 컨트롤러 생성 및 의존성 주입을 담당하는 `ViewControllerFactory`, 코디네이터 생성을 담당하는 `CoordinatorFactory`, 그리고 화면 간 전환을 담당하는 `Router`로 구성되어 있습니다. (참고: [How to implement flow coordinator pattern](https://pavlepesic.medium.com/flow-coordination-pattern-5eb60cd220d5)

<details>
<summary>자세히 보기</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
![무제 001](https://github.com/user-attachments/assets/98af3eec-ceed-48cd-9317-61a224f8c38a)

</details>



* **[RangeSlider](/03-RangeSlider/RangeSlider)** : 이 프로젝트는 `UIControl`을 서브클래싱하여 `RangeSlider`를 컨트롤을 구현한 예제입니다.  (참고: [How To Make a Custom Control Tutorial: A Reusable Slider](https://www.kodeco.com/7595-how-to-make-a-custom-control-tutorial-a-reusable-slider)

<details>
<summary>자세히 보기</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
![무제 001](https://github.com/user-attachments/assets/98af3eec-ceed-48cd-9317-61a224f8c38a)

</details>


* **[InfiniteCarousel](/04-InfiniteCarousel/UIKitTemplate)** : 이 프로젝트는 컬렉션 뷰를 활용해 양방향으로 무한 스크롤이 가능한 캐러셀 UI를 구현한 예제입니다. (참고: [Infinite Carousel (무한 스크롤 뷰) 구현 방법](https://ios-development.tistory.com/1197)

<details>
<summary>자세히 보기</summary>

<!-- summary 아래 한칸 공백 두어야함 -->
[GIF](creenshots/Carousel.gif)

</details>
