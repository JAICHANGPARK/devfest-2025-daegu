# Flutter GenUI x Gemini: 고객센터 앱 코드랩 (DevFest 2025 Daegu)

이 코드랩에서는 Flutter와 **GenUI (Generative UI)** 패키지, 그리고 **Gemini** AI를 활용하여 간단한 **고객센터 상담 앱**을 개발하는 방법을 배웁니다.

단순하게 텍스트로만 응답하는 챗봇이 아니라, 상황에 맞는 위젯(FAQ 카드, 카테고리 그리드, 문의 상태 카드)을 실시간으로 렌더링하는 진화된 AI 앱을 만들어 봅니다.

## 시작 코드 (Starter Code)
본격적인 실습에 앞서 기초가 되는 코드를 준비했습니다.
*   **[구조화된 코드 (권장)](./starter_code/lib/)**: 실제 앱 구조와 유사하게 구성된 코드입니다.
*   **[한 파일로 시작하기 (초보자용)](./starter_code/main_all_in_one.dart)**: 복잡한 구조 없이 하나의 `main.dart` 파일에서 실습을 진행하고 싶을 때 사용하세요.

## 실습 단계

이 코드랩은 총 6단계로 구성되어 있습니다.

*   **[Step 0: 환경 설정 및 API 키 준비](./step0_setup.md)**
    *   Flutter 개발 환경을 확인하고 Gemini API 키를 설정합니다.
*   **[Step 1: 기본적인 채팅 인터페이스 구현](./step1_chat_ui.md)**
    *   Gemini API와 연결하여 텍스트 기반 채팅 기능을 완성합니다.
*   **[Step 2: 고객센터 전용 커스텀 위젯 제작](./step2_custom_widgets.md)**
    *   FAQ, 문의 카테고리, 문의 내역 등 UI 컴포넌트를 직접 코딩합니다.
*   **[Step 3: GenUI 카탈로그 등록 및 연동](./step3_catalog_genui.md)**
    *   작성한 위젯을 GenUI 카탈로그에 등록하여 AI가 사용할 수 있도록 합니다.
*   **[Step 4: 시스템 프롬프트 최적화 및 완성](./step4_prompt_engineering.md)**
    *   고객센터 상담원으로서 AI의 역할을 정의하고 세련된 UI 시나리오를 완성합니다.
*   **[Step 5: 위젯 개선 및 고급 인터렉션](./step5_advanced_refinement.md)**
    *   더 나은 사용자 경험을 위한 위젯 정제 기법과 고급 활용법을 알아봅니다.

---

시작할 준비가 되셨나요? **[Step 0](./step0_setup.md)**으로 이동해 주세요!
