# Clean Architecture + MVVM-C
### CleanArchitecture?
-   [](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)[https://github.com/kudoleh/iOS-Clean-Architecture-MVVM](https://github.com/kudoleh/iOS-Clean-Architecture-MVVM)
-   [](https://eunjin3786.tistory.com/207)[https://eunjin3786.tistory.com/207](https://eunjin3786.tistory.com/207)
-   [](https://ios-development.tistory.com/665?category=989887)[https://ios-development.tistory.com/665?category=989887](https://ios-development.tistory.com/665?category=989887)
---
### 템플릿 구조
-   Application: 앱을 시작하고, 필요한 정보들을 초기화 하는 계층
    -   DIContainer: 의존성 주입을 위한 클래스
-   Presentation: UI와 관련된 계층
    -   Coordinators: 모든 화면 전환을 담당하는 클래스
    -   Scenes: 각 화면에 해당하는 상세 UI 및 바인딩을 담당하는 클래스
        -   ViewController: View를 담당하는 클래스
            -   Storyboard
        -   ViewModel: 비즈니스 로직들을 View에 전달해주는 클래스
-   Domain: 비즈니스 로직과 관련된 계층
    -   Entities: MVC의 모델 역할
    -   UseCases: 비즈니스 로직을 캡슐화하여 ViewModel에 전달해주는 클래스
    -   RepositoryDelegate: Repository의 프로토콜을 정의해놓은 클래스
    -   DTO+VO: API 통신시에 데이터 변환을 도와주는 클래스
        -   DTO: 주로 Get 메서드를 사용할 때 사용
        -   VO: 주로 Post 메서드를 사용할 때 사용
-   Data: DB, API와 관련된 계층
    -   Repositories: Domain에 있는 프로토콜을 구현하는 실질적인 비즈니스 로직을 담당하는 클래스
    -   Network: Moya의 TargetType을 정의해주는 클래스
    -   Storages: LocalDB에 대한 I/O를 담당하는 클래스
-   Common: 공통적으로 사용 가능한 영역에 대한 클래스들
---

### 네트워킹을 포함한 비즈니스 로직 추가 Flow
1. Entity 구현 → 아래부터 API, Storage 등은 Optional
2.  API(TargetType) 구현
3. DIContainer에서 사용할 Scene에 ServiceAPI, Storage 의존성 주입
4. SceneDIContainer에서 UseCase, Repository 의존성 주입
5. RepositoryDelegate 프로토콜 구현
6. Storage 구현
7. Repository에서 Request Method (Provider Request), Business Logic 구현
8. UseCase 구현
9. ViewModel에서 UseCase Subscribe Method 구현
10. ViewController에서 ViewModel의 Subscribe Method 호출
---

### Clean Architecture + MVVM-C 를 사용하면서 느낀점
1. 장점
- 계층이 확실하게 분리되어있기 때문에 해당 아키텍처를 이해하기만 하면, 전반적인 소스코드들을 쉽게 이해할 수 있음.
- 의존성 주입이 쉽고 명확해짐.
- 인수인계가 수월했음.
- 응집도가 높기 때문에 유지보수 및 기능 추가가 수월했음.
- Coordinator 패턴으로 화면전환 관리가 수월했음.
- 익숙해지면 자신의 루틴으로 안정적으로 빠르게 개발 가능.

2. 단점
- 계속해서 늘어나는 폴더와 파일..!
- 익숙해지기 전까진 기능 추가시에 신경써야할 부분들이 많음.
- Ribs처럼 템플릿화 되어있지 않아서 처음 학습 및 구현시에 어려움이 있음.

3. 깨달음
- 아키텍쳐도 정말 중요하다. 프로젝트에 70 ~ 80%는 아키텍쳐가 다 하는 것 같다.
- 하지만 개인적으로 개발자가 직접 관여해야하는 나머지 20%가 개발자에겐 훨씬 더 중요하다는걸 느꼈음.
- 아키텍쳐의 경우 비교적 단기간에 학습할 수 있지만, 나머지 부분들은 단기간에 학습할 수 없다고 생각.
- 아키텍쳐에 파묻히지 말고 Clean Code, Design Pattern, OOP, POP, FP, TEST 등 개발자가 직접 관여해야하는 부분을 깊이 파고들어야 할 것 같다.
- 언젠간 TDD로 한줄 한줄 자신있게 뚝딱뚝딱 할 수 있는 날이 오겠지?!😆
