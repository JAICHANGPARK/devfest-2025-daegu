# DevFest 2025 Daegu: Flutter GenUI Codelab 🚀

이 리포지토리는 **DevFest 2025 Daegu**의 **"Flutter와 Gemini로 구현하는 차세대 Generative UI(GenUI)"** 핸즈온 세션을 위한 실습 코드입니다.

사용자의 요구사항에 맞춰 AI가 실시간으로 최적의 UI 컴포넌트(FAQ 카드, 카데고리 그리드, 문의 상태 등)를 생성하여 응답하는 **고객센터 상담 앱(Customer Center App)**을 구축하는 과정을 담고 있습니다.

---

## 🌟 프로젝트 주요 특징

- **Generative UI (GenUI)**: 텍스트 응답을 넘어, AI가 앱의 위젯 구조를 직접 설계하고 렌더링합니다.
- **Gemini 3 Integration**: Google의 강력한 LLM을 사용하여 상황에 맞는 지능적인 응답을 제공합니다.
- **Custom Widget Catalog**: `FaqCard`, `CategoryGrid`, `InquiryStatusCard` 등 고객센터 앱에 특화된 위젯들을 AI가 자유자재로 조합할 수 있도록 카탈로그화되어 있습니다.
- **Interactive Experience**: AI가 생성한 UI를 통해 사용자와 상호작용하며 실시간으로 상태를 업데이트합니다.

---

## 🎓 코드랩 실습 단계 (Curriculum)

본 실습은 단계별로 구성되어 있습니다. `docs` 폴더의 가이드를 따라 진행해 주세요.

*   **[Step 0: 환경 설정 및 API 키 준비](docs/step0_setup.md)**: Flutter 개발 환경 확인 및 Gemini API 키 설정
*   **[Step 1: 기본적인 채팅 인터페이스 구현](docs/step1_chat_ui.md)**: Gemini API 연동 및 텍스트 채팅 기능 완성
*   **[Step 2: 고객센터 전용 커스텀 위젯 제작](docs/step2_custom_widgets.md)**: FAQ, 카테고리 그리드 등 UI 컴포넌트 구현
*   **[Step 3: GenUI 카탈로그 등록 및 연동](docs/step3_catalog_genui.md)**: 작성한 위젯을 AI가 사용 가능하도록 카탈로그 등록
*   **[Step 4: 시스템 프롬프트 최적화 및 완성](docs/step4_prompt_engineering.md)**: 상담원 페르소나 설정 및 시나리오 완성
*   **[Step 5: 위젯 개선 및 고급 인터렉션](docs/step5_advanced_refinement.md)**: 사용자 경험 고도화 및 고급 활용법

> [!TIP]
> **[시작 코드 (Starter Code)](docs/index.md#시작-코드-starter-code)** 섹션에서 본인에게 맞는 시작 코드를 선택할 수 있습니다.

---

## 🛠 실습 준비사항

시작하기 전에 다음 환경이 준비되어 있어야 합니다.

1. **Flutter SDK**: 최신 Stable 버전 권장 (v3.38.0 이상)
2. **Gemini API Key**: [Google AI Studio](https://aistudio.google.com/)에서 발급받은 API 키가 필요합니다.
3. **IDE**: VS Code 또는 Android Studio (Flutter 플러그인 설치 필수)

---

## 🚀 실행 방법

### 1. 리포지토리 클론 및 의존성 설치
```bash
git clone https://github.com/jaichangpark/devfest-2025-daegu.git
cd devfest-2025-daegu
flutter pub get
```

### 2. API 키 설정 및 실행
다음 명령어를 통해 API 키를 환경 변수로 전달하며 앱을 실행합니다:

```bash
flutter run --dart-define=GENAI_API_KEY=YOUR_API_KEY
```

또는 특정 플랫폼(예: macOS)에서 실행하려면:
```bash
flutter run -d macos --dart-define=GENAI_API_KEY=YOUR_API_KEY
```

---

## 📂 프로젝트 구조

- `lib/main.dart`: 앱의 엔트리 포인트이며, GenUI `Generator` 및 `Conversation` 객체를 설정합니다.
- `lib/catalog.dart`: AI가 사용할 수 있는 위젯들의 명세(Schema)와 빌더를 정의합니다.
- `lib/chat_screen.dart`: 사용자 인터페이스를 담당하며, AI의 텍스트와 UI 메시지를 렌더링합니다.
- `lib/widgets/`: `FaqCard`, `CategoryGrid` 등 실제 렌더링될 커스텀 위젯들이 포함되어 있습니다.
- `docs/`: 단계별 실습 가이드 문서가 포함되어 있습니다.

---

## 📝 라이선스

이 프로젝트는 [MIT License](LICENSE)를 따릅니다.

---

**DevFest 2025 Daegu**에서 즐거운 Flutter & AI 개발 경험 되시길 바랍니다! 💙
